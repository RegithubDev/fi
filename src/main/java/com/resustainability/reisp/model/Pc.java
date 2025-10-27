package com.resustainability.reisp.model;

public class Pc {

    private String id,entity_code,profit_center_code,profit_center_name,sbu,created_on,modified_on,status;

    

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getEntity_code() {
		return entity_code;
	}

	public void setEntity_code(String entity_code) {
		this.entity_code = entity_code;
	}

	public String getProfit_center_code() {
		return profit_center_code;
	}

	public void setProfit_center_code(String profit_center_code) {
		this.profit_center_code = profit_center_code;
	}

	public String getProfit_center_name() {
		return profit_center_name;
	}

	public void setProfit_center_name(String profit_center_name) {
		this.profit_center_name = profit_center_name;
	}

	public String getSbu() {
		return sbu;
	}

	public void setSbu(String sbu) {
		this.sbu = sbu;
	}

	public String getCreated_on() {
		return created_on;
	}

	public void setCreated_on(String created_on) {
		this.created_on = created_on;
	}

	public String getModified_on() {
		return modified_on;
	}

	public void setModified_on(String modified_on) {
		this.modified_on = modified_on;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public void setModifiedBy(String userId) {
		// TODO Auto-generated method stub
		
	}

	public void setCreatedBy(String userId) {
		// TODO Auto-generated method stub
		
	}
}