package com.resustainability.reisp.dao;

import java.math.BigDecimal;
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

import com.resustainability.reisp.model.EsiContribution;
import com.resustainability.reisp.model.User;

@Repository
public class EsiContributionDao {

	 	@Autowired
	    private JdbcTemplate jdbcTemplate;
	 	
		@Autowired
		DataSource dataSource;

		@Autowired
		DataSourceTransactionManager transactionManager;
	 	public List<EsiContribution> getEsiContributions(String monthYear, String entity, String profitCenter, User usr) {
	        String sql = "SELECT pf.[id]\r\n"
	        		+ "      ,p.[entity_code],e.entity_name\r\n"
	        		+ "      ,pf.[profit_center_code],p.profit_center_name\r\n"
	        		+ "      ,pf.[month_year]\r\n"
	        		+ "      ,pf.[employee_contribution]\r\n"
	        		+ "      ,pf.[employer_contribution]\r\n"
	        		+ "      ,pf.[total_amount]\r\n"
	        		+ "      ,pf.[amount_paid]\r\n"
	        		+ "      ,pf.[difference]\r\n"
	        		+ "      ,pf.[due_date]\r\n"
	        		+ "      ,pf.[actual_payment_date]\r\n"
	        		+ "      ,pf.[delay_days]\r\n"
	        		+ "      ,pf.[challan_no],no_of_emp,pf.status FROM esi pf "
	        		+ "left join profit_center p on pf.profit_center_code = p.profit_center_code "
	        		+ "left join entity e on p.entity_code = e.entity_code "

	        		+ "WHERE 1=1 ";
	        List<Object> params = new ArrayList<>();
<<<<<<< HEAD
	        if (!usr.getRole().equals("Admin") && !usr.getRole().equals("SA")) {
	            String pcCodes = usr.getProfit_center_code();

	            if (pcCodes != null && pcCodes.contains(",")) {
	                // Split into array
	                String[] codes = pcCodes.split(",");

	                // Build IN clause with placeholders
	                String placeholders = String.join(",", java.util.Collections.nCopies(codes.length, "?"));
	                sql += " AND pf.status <> 'Inactive' AND pf.[profit_center_code] IN (" + placeholders + ") ";

	                // Add each code as parameter
	                for (String code : codes) {
	                    params.add(code.trim());
	                }
	            } else {
	                // Single code as before
	                sql += " AND pf.status <> 'Inactive' AND pf.[profit_center_code] = ? ";
	                params.add(pcCodes);
	            }
	        }

=======
    		if(!usr.getRole().equals("Admin") && !usr.getRole().equals("SA")) {
    			sql += "and pf.status <> 'Inactive' and pf.[profit_center_code] = ? ";
    			 params.add(usr.getProfit_center_code());
    		}
>>>>>>> 0be22774be56f74f236fbb15502732a798d923a4

	        if (monthYear != null) {
	            sql += " AND month_year = ?";
	            params.add(monthYear);
	        }
	        if (entity != null) {
	            sql += " AND entity = ?";
	            params.add(entity);
	        }
	        if (profitCenter != null) {
	            sql += " AND profit_center_code = ?";
	            params.add(profitCenter);
	        }
	        sql += " order by month_year desc";
	        return jdbcTemplate.query(sql, params.toArray(), new BeanPropertyRowMapper<>(EsiContribution.class));
	    }

	 	 public boolean addEsiContribution(EsiContribution pf) {
	 		int count = 0;
			boolean flag = false;
			TransactionDefinition def = new DefaultTransactionDefinition();
			TransactionStatus status = transactionManager.getTransaction(def);
	 		 try {
	 			 pf.setStatus("Active");
	 			NamedParameterJdbcTemplate namedParamJdbcTemplate = new NamedParameterJdbcTemplate(dataSource);
	 			String insertQry = "INSERT INTO [esi] "
						+ "(created_by,profit_center_code, month_year, employee_contribution,employer_contribution,total_amount,amount_paid,difference,challan_no, "
						+ "due_date, actual_payment_date,no_of_emp,status,created_date)"
						+ " VALUES "
						+ "(:created_by,:profit_center_code, :month_year, :employee_contribution,:employer_contribution, :total_amount, :amount_paid, :difference,:challan_no, "
						+ ":due_date, :actual_payment_date, :no_of_emp, :status, getdate())";
				BeanPropertySqlParameterSource paramSource = new BeanPropertySqlParameterSource(pf);		 
			    count = namedParamJdbcTemplate.update(insertQry, paramSource);
			    transactionManager.commit(status);
			    if(count > 0) {
			    	flag = true;
			    }
	 		}catch (Exception e) {
	 			transactionManager.rollback(status);
	 			 e.printStackTrace();
	 		 }
	 		 return flag;
	     }

	     public boolean updateEsiContribution(EsiContribution pf) {
	    	 int count = 0;
				boolean flag = false;
				TransactionDefinition def = new DefaultTransactionDefinition();
				TransactionStatus status = transactionManager.getTransaction(def);
		 		 try {
		 			NamedParameterJdbcTemplate namedParamJdbcTemplate = new NamedParameterJdbcTemplate(dataSource);
		 			String uQry = "UPDATE [esi] SET "
		 				    + " employee_contribution = :employee_contributions"
		 				    + ", employer_contribution = :employer_contributions"
		 				    + ", total_amount = :total_amounts"
		 				    + ", amount_paid = :amount_paids"
		 				    + ", difference = :differences"
		 				    + ", challan_no = :challan_nos"
		 				    + ", due_date = :due_dates"
		 				    + ", actual_payment_date = :actual_payment_dates"
		 				    + ", no_of_emp = :no_of_emps"
		 				    + ", status = :status, modified_date = getdate(),modified_by =:modified_by "
		 				    + " WHERE id = :id";

					BeanPropertySqlParameterSource paramSource = new BeanPropertySqlParameterSource(pf);		 
				    count = namedParamJdbcTemplate.update(uQry, paramSource);
				    transactionManager.commit(status);
				    if(count > 0) {
				    	flag = true;
				    }
		 		}catch (Exception e) {
		 			transactionManager.rollback(status);
		 			 e.printStackTrace();
		 		 }
		 		 return flag;
	     }

		public List<EsiContribution> geteList() throws Exception {
			List<EsiContribution> objsList = new ArrayList<EsiContribution>();
			try {
				String qry = "SELECT[id]\r\n"
						+ "      ,[entity_code]\r\n"
						+ "      ,[entity_name]\r\n"
						+ "      ,[created_on]\r\n"
						+ "      ,[modified_on]\r\n"
						+ "      ,[status] FROM [FIDB].[dbo].[entity] "
						+ " where entity_code <> '' and entity_code is not null and status = 'Active' ";
				
				objsList = jdbcTemplate.query( qry, new BeanPropertyRowMapper<EsiContribution>(EsiContribution.class));
			} catch (Exception e) {
				e.printStackTrace();
				throw new Exception(e);
			}
			return objsList;
			
		}

		public List<EsiContribution> getpList()throws Exception {
			List<EsiContribution> objsList = new ArrayList<EsiContribution>();
			try {
				String qry = "SELECT p.[id]\r\n"
						+ "      ,p.[entity_code],e.entity_name\r\n"
						+ "      ,[profit_center_code]\r\n"
						+ "      ,[profit_center_name]\r\n"
						+ "      ,p.[created_on]\r\n"
						+ "      ,p.[modified_on]\r\n"
						+ "      ,p.[status] from [FIDB].[dbo].[profit_center] p "
						+ "left join entity e on p.entity_code = e.entity_code "
						+ " where p.entity_code <> '' and p.entity_code is not null and p.status = 'Active' ";
				
				objsList = jdbcTemplate.query( qry, new BeanPropertyRowMapper<EsiContribution>(EsiContribution.class));
			} catch (Exception e) {
				e.printStackTrace();
				throw new Exception(e);
			}
			return objsList;
		}
}
