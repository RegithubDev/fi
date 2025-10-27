package com.resustainability.reisp.dao;

import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.BeanPropertySqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.util.StringUtils;

import com.resustainability.reisp.model.Pc;

@Repository
public class PcDao {

    @Autowired
    JdbcTemplate jdbcTemplate;

    @Autowired
    DataSource dataSource;

    @Autowired
    DataSourceTransactionManager transactionManager;

    public List<Pc> getpcList(Pc obj, int startIndex, int offset, String searchParameter) throws Exception {
        List<Pc> objsList = new ArrayList<>();
        try {
            StringBuilder qry = new StringBuilder(
                "SELECT [id], [entity_code], [profit_center_code], [profit_center_name], "
                + "[sbu], [created_on], [modified_on], [status] "
                + "FROM [FIDB].[dbo].[profit_center] WHERE 1=1 "
            );

            MapSqlParameterSource params = new MapSqlParameterSource();

            if (!StringUtils.isEmpty(searchParameter)) {
                qry.append(" AND (");
                qry.append("[id] LIKE :search OR ");
                qry.append("[entity_code] LIKE :search OR ");
                qry.append("[profit_center_code] LIKE :search OR ");
                qry.append("[profit_center_name] LIKE :search OR ");
                qry.append("[sbu] LIKE :search OR ");
                qry.append("[status] LIKE :search)");
                params.addValue("search", "%" + searchParameter + "%");
            }

            // Additional filters from pc object
            if (obj != null && !StringUtils.isEmpty(obj.getId())) {
                qry.append(" AND [id] = :id");
                params.addValue("id", obj.getId());
            }
            if (obj != null && !StringUtils.isEmpty(obj.getEntity_code())) {
                qry.append(" AND [entity_code] = :entity_code");
                params.addValue("entity_code", obj.getEntity_code());
            }
            if (obj != null && !StringUtils.isEmpty(obj.getProfit_center_code())) {
                qry.append(" AND [profit_center_code] = :profit_center_code");
                params.addValue("profit_center_code", obj.getProfit_center_code());
            }
            if (obj != null && !StringUtils.isEmpty(obj.getSbu())) {
                qry.append(" AND [sbu] = :sbu");
                params.addValue("sbu", obj.getSbu());
            }
            if (obj != null && !StringUtils.isEmpty(obj.getStatus())) {
                qry.append(" AND [status] = :status");
                params.addValue("status", obj.getStatus());
            }

            qry.append(" ORDER BY [id] ASC");
            qry.append(" OFFSET :startIndex ROWS FETCH NEXT :offset ROWS ONLY");

            params.addValue("startIndex", startIndex);
            params.addValue("offset", offset);

            NamedParameterJdbcTemplate namedParamJdbcTemplate = new NamedParameterJdbcTemplate(dataSource);
            objsList = namedParamJdbcTemplate.query(qry.toString(), params, new BeanPropertyRowMapper<>(Pc.class));
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Error fetching profit center list: " + e.getMessage());
        }
        return objsList;
    }

    public int getTotalRecords(Pc obj, String searchParameter) throws Exception {
        int totalRecords = 0;
        try {
            StringBuilder qry = new StringBuilder(
                "SELECT COUNT(*) FROM [FIDB].[dbo].[profit_center] WHERE 1=1 "
            );

            MapSqlParameterSource params = new MapSqlParameterSource();

            if (!StringUtils.isEmpty(searchParameter)) {
                qry.append(" AND (");
                qry.append("[id] LIKE :search OR ");
                qry.append("[entity_code] LIKE :search OR ");
                qry.append("[profit_center_code] LIKE :search OR ");
                qry.append("[profit_center_name] LIKE :search OR ");
                qry.append("[sbu] LIKE :search OR ");
                qry.append("[status] LIKE :search)");
                params.addValue("search", "%" + searchParameter + "%");
            }

            if (obj != null && !StringUtils.isEmpty(obj.getId())) {
                qry.append(" AND [id] = :id");
                params.addValue("id", obj.getId());
            }
            if (obj != null && !StringUtils.isEmpty(obj.getEntity_code())) {
                qry.append(" AND [entity_code] = :entity_code");
                params.addValue("entity_code", obj.getEntity_code());
            }
            if (obj != null && !StringUtils.isEmpty(obj.getProfit_center_code())) {
                qry.append(" AND [profit_center_code] = :profit_center_code");
                params.addValue("profit_center_code", obj.getProfit_center_code());
            }
            if (obj != null && !StringUtils.isEmpty(obj.getSbu())) {
                qry.append(" AND [sbu] = :sbu");
                params.addValue("sbu", obj.getSbu());
            }
            if (obj != null && !StringUtils.isEmpty(obj.getStatus())) {
                qry.append(" AND [status] = :status");
                params.addValue("status", obj.getStatus());
            }

            NamedParameterJdbcTemplate namedParamJdbcTemplate = new NamedParameterJdbcTemplate(dataSource);
            totalRecords = namedParamJdbcTemplate.queryForObject(qry.toString(), params, Integer.class);
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Error counting total records: " + e.getMessage());
        }
        return totalRecords;
    }

    public boolean addPc(Pc obj) throws Exception {
        boolean flag = false;
        TransactionDefinition def = new DefaultTransactionDefinition();
        TransactionStatus status = transactionManager.getTransaction(def);
        try {
            NamedParameterJdbcTemplate namedParamJdbcTemplate = new NamedParameterJdbcTemplate(dataSource);
            String insertQry = "INSERT INTO [FIDB].[dbo].[profit_center] "
                    + "(entity_code, profit_center_code, profit_center_name, sbu, created_on, status) "
                    + "VALUES (:entity_code, :profit_center_code, :profit_center_name, :sbu, GETDATE(), :status)";

            BeanPropertySqlParameterSource paramSource = new BeanPropertySqlParameterSource(obj);
            int count = namedParamJdbcTemplate.update(insertQry, paramSource);
            if (count > 0) {
                flag = true;
            }
            transactionManager.commit(status);
        } catch (Exception e) {
            transactionManager.rollback(status);
            e.printStackTrace();
            throw new Exception("Error adding profit center: " + e.getMessage());
        }
        return flag;
    }

    public boolean updatePc(Pc obj) throws Exception {
        boolean flag = false;
        TransactionDefinition def = new DefaultTransactionDefinition();
        TransactionStatus status = transactionManager.getTransaction(def);
        try {
            NamedParameterJdbcTemplate namedParamJdbcTemplate = new NamedParameterJdbcTemplate(dataSource);
            String updateQry = "UPDATE [FIDB].[dbo].[profit_center] SET "
                    + "entity_code = :entity_code, "
                    + "profit_center_code = :profit_center_code, "
                    + "profit_center_name = :profit_center_name, "
                    + "sbu = :sbu, "
                    + "modified_on = GETDATE(), "
                    + "status = :status "
                    + "WHERE id = :id";
            
            BeanPropertySqlParameterSource paramSource = new BeanPropertySqlParameterSource(obj);
            int count = namedParamJdbcTemplate.update(updateQry, paramSource);
            if (count > 0) {
                flag = true;
            }
            transactionManager.commit(status);
        } catch (Exception e) {
            transactionManager.rollback(status);
            e.printStackTrace();
            throw new Exception("Error updating profit center: " + e.getMessage());
        }
        return flag;
    }

    public boolean deletePc(Pc obj) throws Exception {
        boolean flag = false;
        try {
            String deleteQry = "DELETE FROM [FIDB].[dbo].[profit_center] WHERE id = ?";
            Object[] args = new Object[]{obj.getId()};
            int count = jdbcTemplate.update(deleteQry, args);
            if (count > 0) {
                flag = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Error deleting profit center: " + e.getMessage());
        }
        return flag;
    }

    public Pc findByEmailIdAndStatus(String emailId, String status) throws Exception {
        try {
            String qry = "SELECT * FROM [FIDB].[dbo].[profit_center] WHERE email_id = ? AND status = ?";
            return jdbcTemplate.queryForObject(qry, new Object[]{emailId, status}, new BeanPropertyRowMapper<>(Pc.class));
        } catch (Exception e) {
            return null; // Return null if no record is found
        }
    }
}