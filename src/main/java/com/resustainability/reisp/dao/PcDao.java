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

    public List<Pc> getPcList(Pc obj, int startIndex, int offset, String searchParameter) throws Exception {
        List<Pc> objsList = new ArrayList<>();
        try {
            StringBuilder qry = new StringBuilder(
                "SELECT [id], [entity_code], [entity_name], [profit_center_code], [profit_center_name], "
                + "[sbu], [emp_id], [emp_name], [email_id], [created_date], [modified_date], [status] "
                + "FROM [FIDB].[dbo].[pc] WHERE 1=1 "
            );

            MapSqlParameterSource params = new MapSqlParameterSource();

            if (!StringUtils.isEmpty(searchParameter)) {
                qry.append(" AND (");
                qry.append("[id] LIKE :search OR ");
                qry.append("[entity_code] LIKE :search OR ");
                qry.append("[entity_name] LIKE :search OR ");
                qry.append("[profit_center_code] LIKE :search OR ");
                qry.append("[profit_center_name] LIKE :search OR ");
                qry.append("[sbu] LIKE :search OR ");
                qry.append("[emp_id] LIKE :search OR ");
                qry.append("[emp_name] LIKE :search OR ");
                qry.append("[email_id] LIKE :search OR ");
                qry.append("[status] LIKE :search)");
                params.addValue("search", "%" + searchParameter + "%");
            }

            // Additional filters from Pc object
            if (!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getId())) {
                qry.append(" AND [id] = :id");
                params.addValue("id", obj.getId());
            }
            if (!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getEntityCode())) {
                qry.append(" AND [entity_code] = :entityCode");
                params.addValue("entityCode", obj.getEntityCode());
            }
            if (!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getProfitCenterCode())) {
                qry.append(" AND [profit_center_code] = :profitCenterCode");
                params.addValue("profitCenterCode", obj.getProfitCenterCode());
            }
            if (!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getSbu())) {
                qry.append(" AND [sbu] = :sbu");
                params.addValue("sbu", obj.getSbu());
            }
            if (!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getStatus())) {
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
                "SELECT COUNT(*) FROM [FIDB].[dbo].[pc] WHERE 1=1 "
            );

            MapSqlParameterSource params = new MapSqlParameterSource();

            if (!StringUtils.isEmpty(searchParameter)) {
                qry.append(" AND (");
                qry.append("[id] LIKE :search OR ");
                qry.append("[entity_code] LIKE :search OR ");
                qry.append("[entity_name] LIKE :search OR ");
                qry.append("[profit_center_code] LIKE :search OR ");
                qry.append("[profit_center_name] LIKE :search OR ");
                qry.append("[sbu] LIKE :search OR ");
                qry.append("[emp_id] LIKE :search OR ");
                qry.append("[emp_name] LIKE :search OR ");
                qry.append("[email_id] LIKE :search OR ");
                qry.append("[status] LIKE :search)");
                params.addValue("search", "%" + searchParameter + "%");
            }

            if (!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getId())) {
                qry.append(" AND [id] = :id");
                params.addValue("id", obj.getId());
            }
            if (!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getEntityCode())) {
                qry.append(" AND [entity_code] = :entityCode");
                params.addValue("entityCode", obj.getEntityCode());
            }
            if (!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getProfitCenterCode())) {
                qry.append(" AND [profit_center_code] = :profitCenterCode");
                params.addValue("profitCenterCode", obj.getProfitCenterCode());
            }
            if (!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getSbu())) {
                qry.append(" AND [sbu] = :sbu");
                params.addValue("sbu", obj.getSbu());
            }
            if (!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getStatus())) {
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
            String insertQry = "INSERT INTO [FIDB].[dbo].[pc] "
                    + "(id, entity_code, entity_name, profit_center_code, profit_center_name, sbu, emp_id, emp_name, email_id, created_date, status) "
                    + "VALUES (:id, :entityCode, :entityName, :profitCenterCode, :profitCenterName, :sbu, :empId, :empName, :emailId, GETDATE(), :status)";
            
            // Generate ID if not provided
            if (StringUtils.isEmpty(obj.getId())) {
                obj.setId(java.util.UUID.randomUUID().toString());
            }

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
            String updateQry = "UPDATE [FIDB].[dbo].[pc] SET "
                    + "entity_code = :entityCode, "
                    + "entity_name = :entityName, "
                    + "profit_center_code = :profitCenterCode, "
                    + "profit_center_name = :profitCenterName, "
                    + "sbu = :sbu, "
                    + "emp_id = :empId, "
                    + "emp_name = :empName, "
                    + "email_id = :emailId, "
                    + "modified_date = GETDATE(), "
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
            String deleteQry = "DELETE FROM [FIDB].[dbo].[pc] WHERE id = ?";
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
            String qry = "SELECT * FROM [FIDB].[dbo].[pc] WHERE email_id = ? AND status = ?";
            return jdbcTemplate.queryForObject(qry, new Object[]{emailId, status}, new BeanPropertyRowMapper<>(Pc.class));
        } catch (Exception e) {
            return null; // Return null if no record is found
        }
    }
}