package com.resustainability.reisp.model;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

public class FarContribution {
	private Long far_id;
    private String entity_code;
    private String entity_name;
    private String profit_center_code;
    private String profit_center_name;
    private String sbu,email_id,message;
    private String plant_code;
    private String plant_name;

    private Double gross_book_value;      // Use Double for decimal values
    private Double quantity;              // Current quantity
    private Double reported_value;
    private Double quantity_pv;           // Previous Value quantity
    private Double value_variance;
    private Double quantity_variance;

    private String remarks;
    private Date modified_date;
    private String modified_by;
    private Date created_date;
    private String created_by;
    private String uploads;               // Comma-separated file names or paths



	public FarContribution() {

	}

	public FarContribution(Long far_id, String entity_code, String entity_name, String profit_center_code,
			String profit_center_name, String sbu, String email_id, String message, String plant_code,
			String plant_name, Double gross_book_value, Double quantity, Double reported_value, Double quantity_pv,
			Double value_variance, Double quantity_variance, String remarks, Date modified_date, String modified_by,
			Date created_date, String created_by, String uploads, String month_year, MultipartFile[] mediaList) {
		super();
		this.far_id = far_id;
		this.entity_code = entity_code;
		this.entity_name = entity_name;
		this.profit_center_code = profit_center_code;
		this.profit_center_name = profit_center_name;
		this.sbu = sbu;
		this.email_id = email_id;
		this.message = message;
		this.plant_code = plant_code;
		this.plant_name = plant_name;
		this.gross_book_value = gross_book_value;
		this.quantity = quantity;
		this.reported_value = reported_value;
		this.quantity_pv = quantity_pv;
		this.value_variance = value_variance;
		this.quantity_variance = quantity_variance;
		this.remarks = remarks;
		this.modified_date = modified_date;
		this.modified_by = modified_by;
		this.created_date = created_date;
		this.created_by = created_by;
		this.uploads = uploads;
		this.month_year = month_year;
		this.mediaList = mediaList;
	}

	public Long getFar_id() {
		return far_id;
	}

	public void setFar_id(Long far_id) {
		this.far_id = far_id;
	}

	// Optional: for form binding (like month/year filter)
    private String month_year;

    // Optional: for file upload in controller
    private MultipartFile[] mediaList;

	public String getEntity_code() {
		return entity_code;
	}

	public void setEntity_code(String entity_code) {
		this.entity_code = entity_code;
	}

	public String getEntity_name() {
		return entity_name;
	}

	public void setEntity_name(String entity_name) {
		this.entity_name = entity_name;
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

	public String getEmail_id() {
		return email_id;
	}

	public void setEmail_id(String email_id) {
		this.email_id = email_id;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getPlant_code() {
		return plant_code;
	}

	public void setPlant_code(String plant_code) {
		this.plant_code = plant_code;
	}

	public String getPlant_name() {
		return plant_name;
	}

	public void setPlant_name(String plant_name) {
		this.plant_name = plant_name;
	}

	public Double getGross_book_value() {
		return gross_book_value;
	}

	public void setGross_book_value(Double gross_book_value) {
		this.gross_book_value = gross_book_value;
	}

	public Double getQuantity() {
		return quantity;
	}

	public void setQuantity(Double quantity) {
		this.quantity = quantity;
	}

	public Double getReported_value() {
		return reported_value;
	}

	public void setReported_value(Double reported_value) {
		this.reported_value = reported_value;
	}

	public Double getQuantity_pv() {
		return quantity_pv;
	}

	public void setQuantity_pv(Double quantity_pv) {
		this.quantity_pv = quantity_pv;
	}

	public Double getValue_variance() {
		return value_variance;
	}

	public void setValue_variance(Double value_variance) {
		this.value_variance = value_variance;
	}

	public Double getQuantity_variance() {
		return quantity_variance;
	}

	public void setQuantity_variance(Double quantity_variance) {
		this.quantity_variance = quantity_variance;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public Date getModified_date() {
		return modified_date;
	}

	public void setModified_date(Date modified_date) {
		this.modified_date = modified_date;
	}

	public String getModified_by() {
		return modified_by;
	}

	public void setModified_by(String modified_by) {
		this.modified_by = modified_by;
	}

	public Date getCreated_date() {
		return created_date;
	}

	public void setCreated_date(Date created_date) {
		this.created_date = created_date;
	}

	public String getCreated_by() {
		return created_by;
	}

	public void setCreated_by(String created_by) {
		this.created_by = created_by;
	}

	public String getUploads() {
		return uploads;
	}

	public void setUploads(String uploads) {
		this.uploads = uploads;
	}

	public String getMonth_year() {
		return month_year;
	}

	public void setMonth_year(String month_year) {
		this.month_year = month_year;
	}

	public MultipartFile[] getMediaList() {
		return mediaList;
	}

	public void setMediaList(MultipartFile[] mediaList) {
		this.mediaList = mediaList;
	}

	public void setAdditional_files(List<Map<String, String>> additionalFiles) {
		// TODO Auto-generated method stub
		
	}

	
}