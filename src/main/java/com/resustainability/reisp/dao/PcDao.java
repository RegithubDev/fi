package com.resustainability.reisp.dao;

import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

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

import com.resustainability.reisp.model.Pc;

@Repository
public class PcDao {

    @Autowired
    JdbcTemplate jdbcTemplate;

    @Autowired
    DataSource dataSource;

    @Autowired
    DataSourceTransactionManager transactionManager;

    public List<Pc> getPcList(Pc obj) throws Exception {
        List<Pc> objsList = new ArrayList<>();
        try {
            String qry = "SELECT [id], [entity_code], [entity_name], [profit_center_code], [profit_center_name], "
                    + "[sbu], [emp_id], [emp_name], [email_id], [created_date], [modified_date], [status] "
                    + "FROM [FIDB].[dbo].[pc] WHERE 1=1 ";
            
            int arrSize = 0;
            if (!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getId())) {
                qry += " AND id = ? ";
                arrSize++;
            }
            if (!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getEntityCode())) {
                qry += " AND entity_code = ? ";
                arrSize++;
            }
            if (!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getProfitCenterCode())) {
                qry += " AND profit_center_code = ? ";
                arrSize++;
            }
            if (!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getSbu())) {
                qry += " AND sbu = ? ";
                arrSize++;
            }
            if (!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getStatus())) {
                qry += " AND status = ? ";
                arrSize++;
            }
            qry += " ORDER BY id ASC";

            Object[] pValues = new Object[arrSize];
            int i = 0;
            if (!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getId())) {
                pValues[i++] = obj.getId();
            }
            if (!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getEntityCode())) {
                pValues[i++] = obj.getEntityCode();
            }
            if (!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getProfitCenterCode())) {
                pValues[i++] = obj.getProfitCenterCode();
            }
            if (!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getSbu())) {
                pValues[i++] = obj.getSbu();
            }
            if (!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getStatus())) {
                pValues[i++] = obj.getStatus();
            }

            objsList = jdbcTemplate.query(qry, pValues, new BeanPropertyRowMapper<>(Pc.class));
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(e);
        }
        return objsList;
    }

    public boolean addPc(Pc obj) throws Exception {
        boolean flag = false;
        TransactionDefinition def = new DefaultTransactionDefinition();
        TransactionStatus status = transactionManager.getTransaction(def);
        try {
            NamedParameterJdbcTemplate namedParamJdbcTemplate = new NamedParameterJdbcTemplate(dataSource);
            String insertQry = "INSERT INTO [FIDB].[dbo].[pc] "
                    + "(entity_code, entity_name, profit_center_code, profit_center_name, sbu, emp_id, emp_name, email_id, created_date, status) "
                    + "VALUES (:entityCode, :entityName, :profitCenterCode, :profitCenterName, :sbu, :empId, :empName, :emailId, GETDATE(), :status)";
            
            BeanPropertySqlParameterSource paramSource = new BeanPropertySqlParameterSource(obj);
            int count = namedParamJdbcTemplate.update(insertQry, paramSource);
            if (count > 0) {
                flag = true;
            }
            transactionManager.commit(status);
        } catch (Exception e) {
            transactionManager.rollback(status);
            e.printStackTrace();
            throw new Exception(e);
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
            throw new Exception(e);
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
            throw new Exception(e);
        }
        return flag;
    }
}