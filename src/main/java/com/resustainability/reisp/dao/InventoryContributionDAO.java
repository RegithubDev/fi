package com.resustainability.reisp.dao;


import com.resustainability.reisp.model.User;
import com.resustainability.reisp.model.inventoryContribution;

import org.springframework.beans.factory.annotation.Autowired;
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
import java.util.ArrayList;
import java.util.List;

@Repository
public class InventoryContributionDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Autowired
    private DataSource dataSource;

    @Autowired
    private DataSourceTransactionManager transactionManager;

    public List<inventoryContribution> getInventoryContributions(String monthYear, String entityCode, String profitCenterCode, User user) {
        StringBuilder sql = new StringBuilder(
                "SELECT TOP 1000 inv.[id], e.[entity_code], e.entity_name, inv.[profit_center_code], p.profit_center_name, " +
                "inv.[sbu], inv.[month_year], inv.[book_value], inv.[reported_value], inv.[tb_adjustment_gl], " +
                "inv.[tb_system_gl], inv.[varience], inv.[remarks], inv.[upload_file], inv.[created_by], " +
                "inv.[created_date], inv.[modified_by], inv.[modified_date], inv.[status] " +
                "FROM [FIDB].[dbo].[inventory] inv " +
                "LEFT JOIN [FIDB].[dbo].[profit_center] p ON inv.profit_center_code = p.profit_center_code " +
                "LEFT JOIN [FIDB].[dbo].[entity] e ON p.entity_code = e.entity_code " +
                "WHERE 1=1"
        );
        List<Object> params = new ArrayList<>();

        // Role-based filtering
        if (user != null && !user.getRole().equals("Admin") && !user.getRole().equals("SA")) {
            String pcCodes = user.getProfit_center_code();
            if (StringUtils.hasText(pcCodes)) {
                if (pcCodes.contains(",")) {
                    String[] codes = pcCodes.split(",");
                    String placeholders = String.join(",", java.util.Collections.nCopies(codes.length, "?"));
                    sql.append(" AND inv.status <> 'Inactive' AND inv.[profit_center_code] IN (").append(placeholders).append(")");
                    for (String code : codes) {
                        params.add(code.trim());
                    }
                } else {
                    sql.append(" AND inv.status <> 'Inactive' AND inv.[profit_center_code] = ?");
                    params.add(pcCodes);
                }
            }
        }

        // Additional filters
        if (StringUtils.hasText(monthYear)) {
            sql.append(" AND inv.month_year = ?");
            params.add(monthYear);
        }
        if (StringUtils.hasText(entityCode)) {
            sql.append(" AND inv.entity_code = ?");
            params.add(entityCode);
        }
        if (StringUtils.hasText(profitCenterCode)) {
            sql.append(" AND inv.profit_center_code = ?");
            params.add(profitCenterCode);
        }

        sql.append(" ORDER BY inv.month_year DESC");

        try {
            return jdbcTemplate.query(sql.toString(), params.toArray(), new BeanPropertyRowMapper<>(inventoryContribution.class));
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Error fetching inventory contributions: " + e.getMessage(), e);
        }
    }

    public List<inventoryContribution> getAllInventoryContributions() {
        String sql = "SELECT TOP 1000 inv.[id], inv.[entity_code], e.entity_name, inv.[profit_center_code], p.profit_center_name, " +
                     "inv.[sbu], inv.[month_year], inv.[book_value], inv.[reported_value], inv.[tb_adjustment_gl], " +
                     "inv.[tb_system_gl], inv.[varience], inv.[remarks], inv.[upload_file], inv.[created_by], " +
                     "inv.[created_date], inv.[modified_by], inv.[modified_date], inv.[status] " +
                     "FROM [FIDB].[dbo].[inventory] inv " +
                     "LEFT JOIN [FIDB].[dbo].[profit_center] p ON inv.profit_center_code = p.profit_center_code " +
                     "LEFT JOIN [FIDB].[dbo].[entity] e ON inv.entity_code = e.entity_code " +
                     "WHERE inv.status <> 'Inactive' " +
                     "ORDER BY inv.month_year DESC";

        try {
            return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(inventoryContribution.class));
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Error fetching all inventory contributions: " + e.getMessage(), e);
        }
    }

    public boolean addInventoryContribution(inventoryContribution inventory) {
        boolean flag = false;
        TransactionDefinition def = new DefaultTransactionDefinition();
        TransactionStatus status = transactionManager.getTransaction(def);
        try {
            inventory.setStatus("Active");
            NamedParameterJdbcTemplate namedParamJdbcTemplate = new NamedParameterJdbcTemplate(dataSource);
            String insertQry = "INSERT INTO [FIDB].[dbo].[inventory] " +
                              "(entity_code, entity_name, profit_center_code, profit_center_name, sbu, month_year, " +
                              "book_value, reported_value, tb_adjustment_gl, tb_system_gl, varience, remarks, " +
                              "upload_file, created_by, created_date, modified_by, modified_date, status) " +
                              "VALUES (:entity_code, :entity_name, :profit_center_code, :profit_center_name, :sbu, " +
                              ":month_year, :book_value, :reported_value, :tb_adjustment_gl, :tb_system_gl, :varience, " +
                              ":remarks, :upload_file, :created_by, GETDATE(), :modified_by, GETDATE(), :status)";

            BeanPropertySqlParameterSource paramSource = new BeanPropertySqlParameterSource(inventory);
            int count = namedParamJdbcTemplate.update(insertQry, paramSource);
            transactionManager.commit(status);
            flag = count > 0;
        } catch (Exception e) {
            transactionManager.rollback(status);
            e.printStackTrace();
            throw new RuntimeException("Error adding inventory contribution: " + e.getMessage(), e);
        }
        return flag;
    }

    private void setStatus(String string) {
		// TODO Auto-generated method stub
		
	}

	public boolean updateInventoryContribution(inventoryContribution inventory) {
        boolean flag = false;
        TransactionDefinition def = new DefaultTransactionDefinition();
        TransactionStatus status = transactionManager.getTransaction(def);
        try {
            NamedParameterJdbcTemplate namedParamJdbcTemplate = new NamedParameterJdbcTemplate(dataSource);
            String updateQry = "UPDATE [FIDB].[dbo].[inventory] SET " +
                              "entity_code = :entity_code, entity_name = :entity_name, " +
                              "profit_center_code = :profit_center_code, profit_center_name = :profit_center_name, " +
                              "sbu = :sbu, month_year = :month_year, book_value = :book_value, " +
                              "reported_value = :reported_value, tb_adjustment_gl = :tb_adjustment_gl, " +
                              "tb_system_gl = :tb_system_gl, varience = :varience, remarks = :remarks, " +
                              "upload_file = :upload_file, modified_by = :modified_by, modified_date = GETDATE(), " +
                              "status = :status WHERE id = :id";

            BeanPropertySqlParameterSource paramSource = new BeanPropertySqlParameterSource(inventory);
            int count = namedParamJdbcTemplate.update(updateQry, paramSource);
            transactionManager.commit(status);
            flag = count > 0;
        } catch (Exception e) {
            transactionManager.rollback(status);
            e.printStackTrace();
            throw new RuntimeException("Error updating inventory contribution: " + e.getMessage(), e);
        }
        return flag;
    }

    public List<InventoryContributionDAO> getEntityList() throws Exception {
        List<InventoryContributionDAO> entityList = new ArrayList<>();
        try {
            String qry = "SELECT [id], [entity_code], [entity_name], [created_on], [modified_on], [status] " +
                         "FROM [FIDB].[dbo].[entity] " +
                         "WHERE entity_code <> '' AND entity_code IS NOT NULL AND status = 'Active'";
            entityList = jdbcTemplate.query(qry, new BeanPropertyRowMapper<>(InventoryContributionDAO.class));
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Error fetching entity list: " + e.getMessage(), e);
        }
        return entityList;
    }

    public List<InventoryContributionDAO> getProfitCenterList() throws Exception {
        List<InventoryContributionDAO> profitCenterList = new ArrayList<>();
        try {
            String qry = "SELECT p.[id], p.[entity_code], e.entity_name, p.[profit_center_code], p.[profit_center_name], " +
                         "p.[created_on], p.[modified_on], p.[status] " +
                         "FROM [FIDB].[dbo].[profit_center] p " +
                         "LEFT JOIN [FIDB].[dbo].[entity] e ON p.entity_code = e.entity_code " +
                         "WHERE p.entity_code <> '' AND p.entity_code IS NOT NULL AND p.status = 'Active'";
            profitCenterList = jdbcTemplate.query(qry, new BeanPropertyRowMapper<>(InventoryContributionDAO.class));
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Error fetching profit center list: " + e.getMessage(), e);
        }
        return profitCenterList;
    }
}