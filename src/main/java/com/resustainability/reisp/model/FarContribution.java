package com.resustainability.reisp.model;

import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class FarContribution {

    private String entity_Code;
    private String entity_Name;
    private String profit_Center_Code;
    private String profit_Center_Name;
    private String sbu,email_id,message;
    private String plant_Code;
    private String plant_Name;

    private Double gross_Book_Value;      // Use Double for decimal values
    private Double quantity;              // Current quantity
    private Double reported_Value;
    private Double quantity_PV;           // Previous Value quantity
    private Double value_Variance;
    private Double quantity_Variance;

    private String remarks;
    private Date modified_date;
    private String modified_by;
    private Date created_date;
    private String created_by;
    private String uploads;               // Comma-separated file names or paths

    // Optional: for form binding (like month/year filter)
    private String month_year;

    // Optional: for file upload in controller
    private MultipartFile[] mediaList;

    // ------------------- Getters and Setters -------------------

    public String getEntity_Code() {
        return entity_Code;
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

	public void setEntity_Code(String entity_Code) {
        this.entity_Code = entity_Code;
    }

    public String getEntity_Name() {
        return entity_Name;
    }

    public void setEntity_Name(String entity_Name) {
        this.entity_Name = entity_Name;
    }

    public String getProfit_Center_Code() {
        return profit_Center_Code;
    }

    public void setProfit_Center_Code(String profit_Center_Code) {
        this.profit_Center_Code = profit_Center_Code;
    }

    public String getProfit_Center_Name() {
        return profit_Center_Name;
    }

    public void setProfit_Center_Name(String profit_Center_Name) {
        this.profit_Center_Name = profit_Center_Name;
    }

    public String getSbu() {
        return sbu;
    }

    public void setSbu(String sbu) {
        this.sbu = sbu;
    }

    public String getPlant_Code() {
        return plant_Code;
    }

    public void setPlant_Code(String plant_Code) {
        this.plant_Code = plant_Code;
    }

    public String getPlant_Name() {
        return plant_Name;
    }

    public void setPlant_Name(String plant_Name) {
        this.plant_Name = plant_Name;
    }

    public Double getGross_Book_Value() {
        return gross_Book_Value;
    }

    public void setGross_Book_Value(Double gross_Book_Value) {
        this.gross_Book_Value = gross_Book_Value;
    }

    public Double getQuantity() {
        return quantity;
    }

    public void setQuantity(Double quantity) {
        this.quantity = quantity;
    }

    public Double getReported_Value() {
        return reported_Value;
    }

    public void setReported_Value(Double reported_Value) {
        this.reported_Value = reported_Value;
    }

    public Double getQuantity_PV() {
        return quantity_PV;
    }

    public void setQuantity_PV(Double quantity_PV) {
        this.quantity_PV = quantity_PV;
    }

    public Double getValue_Variance() {
        return value_Variance;
    }

    public void setValue_Variance(Double value_Variance) {
        this.value_Variance = value_Variance;
    }

    public Double getQuantity_Variance() {
        return quantity_Variance;
    }

    public void setQuantity_Variance(Double quantity_Variance) {
        this.quantity_Variance = quantity_Variance;
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


}