package com.resustainability.reisp.dao;

import com.resustainability.reisp.model.User;
import com.resustainability.reisp.model.FarContribution;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.BeanPropertySqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.util.StringUtils;

import javax.sql.DataSource;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@Repository
public class FarContributionDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Autowired
    private DataSource dataSource;

    @Autowired
    private DataSourceTransactionManager transactionManager;

    /**
     * Add new FAR contribution
     */
    public boolean addfarContribution(FarContribution far) {
        TransactionDefinition def = new DefaultTransactionDefinition();
        TransactionStatus status = transactionManager.getTransaction(def);
        try {
            NamedParameterJdbcTemplate namedTemplate = new NamedParameterJdbcTemplate(dataSource);
            String sql = "INSERT INTO [FIDB].[dbo].[far] " +
                         "( profit_center_code, " +
                         "plant_code, plant_name, gross_book_value, quantity, reported_value, " +
                         "quantity_pv, value_variance, quantity_variance, remarks, " +
                         "created_by, created_date, uploads) " +
                         "VALUES " +
                         "( :profit_center_code, " +
                         ":plant_code, :plant_name, :gross_book_value, :quantity, :reported_value, " +
                         ":quantity_pv, :value_variance, :quantity_variance, :remarks, " +
                         ":created_by, GETDATE(), :uploads)";
            BeanPropertySqlParameterSource paramSource = new BeanPropertySqlParameterSource(far);
            int rows = namedTemplate.update(sql, paramSource);
            transactionManager.commit(status);
            return rows > 0;
        } catch (Exception e) {
            transactionManager.rollback(status);
            e.printStackTrace();
            throw new RuntimeException("Error adding FAR contribution: " + e.getMessage(), e);
        }
    }

    /**
     * Update existing FAR contribution
     */
    public boolean updatefarContribution(FarContribution far) {
        TransactionDefinition def = new DefaultTransactionDefinition();
        TransactionStatus status = transactionManager.getTransaction(def);
        try {
            NamedParameterJdbcTemplate namedTemplate = new NamedParameterJdbcTemplate(dataSource);
            String sql = "UPDATE [FIDB].[dbo].[far] SET " +
                         "gross_book_value = :gross_book_value, " +
                         "quantity = :quantity, " +
                         "reported_value = :reported_value, " +
                         "quantity_pv = :quantity_pv, " +
                         "value_variance = :value_variance, " +
                         "quantity_variance = :quantity_variance, " +
                         "remarks = :remarks, " +
                         "modified_by = :modified_by, " +
                         "modified_date = GETDATE(), " +
                         "uploads = CASE " +
                         " WHEN :uploads IS NULL OR LTRIM(RTRIM(:uploads)) = '' THEN uploads " +
                         " ELSE ISNULL(uploads + ',', '') + :uploads " +
                         "END " +
                         "WHERE far_id = :far_id";
            BeanPropertySqlParameterSource paramSource = new BeanPropertySqlParameterSource(far);
            int rows = namedTemplate.update(sql, paramSource);
            transactionManager.commit(status);
            return rows > 0;
        } catch (Exception e) {
            transactionManager.rollback(status);
            e.printStackTrace();
            throw new RuntimeException("Error updating FAR contribution: " + e.getMessage(), e);
        }
    }

    /**
     * Get list of distinct Entities for dropdown
     */
    public List<FarContribution> getEntityList() {
        String sql = "SELECT DISTINCT entity_code, entity_name " +
                     "FROM [FIDB].[dbo].[far] " +
                     "WHERE entity_code IS NOT NULL AND LTRIM(RTRIM(entity_code)) <> '' " +
                     "ORDER BY entity_name";
        try {
            return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(FarContribution.class));
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Error fetching entity list: " + e.getMessage(), e);
        }
    }

    public FarContribution getFarById(Long id) {
        String sql = "SELECT far_id, entity_code, entity_name, profit_center_code, profit_center_name, "
                   + "sbu, plant_code, plant_name, gross_book_value, quantity, reported_value, "
                   + "quantity_pv, value_variance, quantity_variance, remarks, "
                   + "modified_date, modified_by, created_date, created_by, uploads "
                   + "FROM [FIDB].[dbo].[far] WHERE far_id = ?";
        try {
            return jdbcTemplate.queryForObject(sql, new Object[]{id},
                    new BeanPropertyRowMapper<>(FarContribution.class));
        } catch (EmptyResultDataAccessException e) {
            return null;
        } catch (Exception e) {
            throw new RuntimeException("Error fetching FAR record: " + e.getMessage(), e);
        }
    }

    /**
     * Get list of distinct Profit Centers for dropdown
     */
    public List<FarContribution> getProfitCenterList() {
        String sql = "SELECT DISTINCT profit_center_code, profit_center_name " +
                     "FROM [FIDB].[dbo].[far] " +
                     "WHERE profit_center_code IS NOT NULL AND LTRIM(RTRIM(profit_center_code)) <> '' " +
                     "ORDER BY profit_center_name";
        try {
            return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(FarContribution.class));
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Error fetching profit center list: " + e.getMessage(), e);
        }
    }

    /**
     * Get FAR contributions with filters
     */
    public List<FarContribution> getFarContributions(String monthYear, String entityCode, String profitCenterCode, User user) {
        StringBuilder sql = new StringBuilder(
                "SELECT far_id, p.entity_code, e.entity_name, f.profit_center_code, p.profit_center_name, " +
                "p.sbu, plant_code, plant_name, gross_book_value, quantity, reported_value, " +
                "quantity_pv, value_variance, quantity_variance, f.remarks, " +
                "f.modified_date, f.modified_by, f.created_date, f.created_by, uploads " +
                "FROM [FIDB].[dbo].[far] f " +
                "LEFT JOIN profit_center p ON f.profit_center_code = p.profit_center_code " +
                "LEFT JOIN entity e ON p.entity_code = e.entity_code " +
                "WHERE far_id IS NOT NULL "
        );

        List<Object> params = new ArrayList<>();

        // Role-based filtering: Non-admin users see only their profit centers
        if (user != null && !("Admin".equals(user.getRole()) || "SA".equals(user.getRole()))) {
            String pcCodes = user.getProfit_center_code();
            if (StringUtils.hasText(pcCodes)) {
                if (pcCodes.contains(",")) {
                    String[] codes = pcCodes.split(",");
                    String placeholders = String.join(",", java.util.Collections.nCopies(codes.length, "?"));
                    sql.append(" AND f.profit_center_code IN (").append(placeholders).append(")"); // Fixed: f.profit_center_code
                    for (String code : codes) {
                        params.add(code.trim()); // Trim each code
                    }
                } else {
                    sql.append(" AND f.profit_center_code = ?"); // Fixed: f.profit_center_code
                    params.add(pcCodes.trim());
                }
            }
        }

        // Apply filters from UI
        if (StringUtils.hasText(monthYear)) {
            sql.append(" AND CONVERT(varchar(7), created_date, 126) = ?");
            params.add(monthYear);
        }
        if (StringUtils.hasText(entityCode)) {
            sql.append(" AND p.entity_code = ?"); // Safe: only p has entity_code in SELECT
            params.add(entityCode);
        }
        if (StringUtils.hasText(profitCenterCode)) {
            sql.append(" AND f.profit_center_code = ?"); // Fixed: f.profit_center_code
            params.add(profitCenterCode.trim());
        }

        sql.append(" ORDER BY created_date DESC");

        try {
            return jdbcTemplate.query(sql.toString(), params.toArray(),
                    new BeanPropertyRowMapper<>(FarContribution.class));
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Error fetching FAR contributions: " + e.getMessage(), e);
        }
    }
}