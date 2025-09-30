package com.resustainability.reisp.model;

import org.springframework.web.multipart.MultipartFile;

public class EsiContribution {

private String id,Entity_code,pt,pts,profit_center_code,email_id,profit_center_name,month_year,employee_contribution,employer_contribution,total_amount,amount_paid,
difference,due_date,actual_payment_date,delay_days,challan_no,no_of_emp,status,employee_contributions,employer_contributions,total_amounts,amount_paids,differences,due_dates,actual_payment_dates,delay_dayss,challan_nos,no_of_emps
,created_date,modified_date,created_by,modified_by,user_name,user_id,result,atatchment,remarks,atatchments,remarkss,entity_name,upload_file,sbu;

private MultipartFile mediaList;


public String getUser_name() {
	return user_name;
}

public void setUser_name(String user_name) {
	this.user_name = user_name;
}

public String getUser_id() {
	return user_id;
}

public void setUser_id(String user_id) {
	this.user_id = user_id;
}

public String getResult() {
	return result;
}

public void setResult(String result) {
	this.result = result;
}

public String getEmail_id() {
	return email_id;
}

public void setEmail_id(String email_id) {
	this.email_id = email_id;
}

public String getSbu() {
	return sbu;
}

public void setSbu(String sbu) {
	this.sbu = sbu;
}

public String getUpload_file() {
	return upload_file;
}

public void setUpload_file(String upload_file) {
	this.upload_file = upload_file;
}

public MultipartFile getMediaList() {
	return mediaList;
}

public void setMediaList(MultipartFile mediaList) {
	this.mediaList = mediaList;
}

public String getAtatchment() {
	return atatchment;
}

public void setAtatchment(String atatchment) {
	this.atatchment = atatchment;
}

public String getRemarks() {
	return remarks;
}

public void setRemarks(String remarks) {
	this.remarks = remarks;
}

public String getAtatchments() {
	return atatchments;
}

public void setAtatchments(String atatchments) {
	this.atatchments = atatchments;
}

public String getRemarkss() {
	return remarkss;
}

public void setRemarkss(String remarkss) {
	this.remarkss = remarkss;
}

public String getCreated_date() {
	return created_date;
}

public void setCreated_date(String created_date) {
	this.created_date = created_date; 
}

public String getModified_date() {
	return modified_date;
}

public void setModified_date(String modified_date) {
	this.modified_date = modified_date;
}

public String getCreated_by() {
	return created_by;
}

public void setCreated_by(String created_by) {
	this.created_by = created_by;
}

public String getModified_by() {
	return modified_by;
}

public void setModified_by(String modified_by) {
	this.modified_by = modified_by;
}

public String getPt() {
	return pt;
}

public void setPt(String pt) {
	this.pt = pt;
}

public String getPts() {
	return pts;
}

public void setPts(String pts) {
	this.pts = pts;
}

public String getProfit_center_name() {
	return profit_center_name;
}

public void setProfit_center_name(String profit_center_name) {
	this.profit_center_name = profit_center_name;
}

public String getEntity_code() {
	return Entity_code;
}

public void setEntity_code(String entity_code) {
	Entity_code = entity_code;
}

public String getEmployee_contributions() {
	return employee_contributions;
}

public void setEmployee_contributions(String employee_contributions) {
	this.employee_contributions = employee_contributions;
}

public String getEmployer_contributions() {
	return employer_contributions;
}

public void setEmployer_contributions(String employer_contributions) {
	this.employer_contributions = employer_contributions;
}

public String getTotal_amounts() {
	return total_amounts;
}

public void setTotal_amounts(String total_amounts) {
	this.total_amounts = total_amounts;
}

public String getAmount_paids() {
	return amount_paids;
}

public void setAmount_paids(String amount_paids) {
	this.amount_paids = amount_paids;
}

public String getDifferences() {
	return differences;
}

public void setDifferences(String differences) {
	this.differences = differences;
}

public String getDue_dates() {
	return due_dates;
}

public void setDue_dates(String due_dates) {
	this.due_dates = due_dates;
}

public String getActual_payment_dates() {
	return actual_payment_dates;
}

public void setActual_payment_dates(String actual_payment_dates) {
	this.actual_payment_dates = actual_payment_dates;
}

public String getDelay_dayss() {
	return delay_dayss;
}

public void setDelay_dayss(String delay_dayss) {
	this.delay_dayss = delay_dayss;
}

public String getChallan_nos() {
	return challan_nos;
}

public void setChallan_nos(String challan_nos) {
	this.challan_nos = challan_nos;
}

public String getNo_of_emps() {
	return no_of_emps;
}

public void setNo_of_emps(String no_of_emps) {
	this.no_of_emps = no_of_emps;
}

public String getId() {
	return id;
}

public void setId(String id) {
	this.id = id;
}

public String getProfit_center_code() {
	return profit_center_code;
}

public void setProfit_center_code(String profit_center_code) {
	this.profit_center_code = profit_center_code;
}

public String getMonth_year() {
	return month_year;
}

public void setMonth_year(String month_year) {
	this.month_year = month_year;
}

public String getEmployee_contribution() {
	return employee_contribution;
}

public void setEmployee_contribution(String employee_contribution) {
	this.employee_contribution = employee_contribution;
}

public String getEmployer_contribution() {
	return employer_contribution;
}

public void setEmployer_contribution(String employer_contribution) {
	this.employer_contribution = employer_contribution;
}

public String getTotal_amount() {
	return total_amount;
}

public void setTotal_amount(String total_amount) {
	this.total_amount = total_amount;
}

public String getAmount_paid() {
	return amount_paid;
}

public void setAmount_paid(String amount_paid) {
	this.amount_paid = amount_paid;
}

public String getDifference() {
	return difference;
}

public void setDifference(String difference) {
	this.difference = difference;
}

public String getDue_date() {
	return due_date;
}

public void setDue_date(String due_date) {
	this.due_date = due_date;
}

public String getActual_payment_date() {
	return actual_payment_date;
}

public void setActual_payment_date(String actual_payment_date) {
	this.actual_payment_date = actual_payment_date;
}

public String getDelay_days() {
	return delay_days;
}

public void setDelay_days(String delay_days) {
	this.delay_days = delay_days;
}

public String getChallan_no() {
	return challan_no;
}

public void setChallan_no(String challan_no) {
	this.challan_no = challan_no;
}

public String getNo_of_emp() {
	return no_of_emp;
}

public void setNo_of_emp(String no_of_emp) {
	this.no_of_emp = no_of_emp;
}

public String getStatus() {
	return status;
}

public void setStatus(String status) {
	this.status = status;
}

public String getEntity_name() {
	return entity_name;
}

public void setEntity_name(String entity_name) {
	this.entity_name = entity_name;
}






}
