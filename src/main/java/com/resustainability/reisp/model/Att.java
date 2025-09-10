package com.resustainability.reisp.model;

import java.util.List;

public class Att {


private String user,role,sl_No,wd,from_date,to_date,emp_code,employee_name,area_name,work_date,day_start,day_end,total_working_hours,overtime_hours,has_overtime,
attendance_status,
sl_no,shift_type,total_hours,remarks,final_OT,Site_name,total_minutes,overtime_minutes,is_holiday,holiday_reason,position_name,position_id,leave_reason,is_leave,action_by,is_regularised,user_id,user_name;


private  List<Att> emp_codee,employee_namee,area_namee,work_datee,day_endd,day_startt,total_working_hourss,overtime_hourss,regularise_reason,checkOut,checkIn;

public String getFinal_OT() {
	return final_OT;
}

public String getRemarks() {
	return remarks;
}

public void setRemarks(String remarks) {
	this.remarks = remarks;
}

public void setFinal_OT(String final_OT) {
	this.final_OT = final_OT;
}

public List<Att> getCheckOut() {
	return checkOut;
}

public void setCheckOut(List<Att> checkOut) {
	this.checkOut = checkOut;
}

public List<Att> getCheckIn() {
	return checkIn;
}

public void setCheckIn(List<Att> checkIn) {
	this.checkIn = checkIn;
}

public String getLeave_reason() {
	return leave_reason;
}

public void setLeave_reason(String leave_reason) {
	this.leave_reason = leave_reason;
}

public String getIs_leave() {
	return is_leave;
}

public void setIs_leave(String is_leave) {
	this.is_leave = is_leave;
}

public List<Att> getEmp_codee() {
	return emp_codee;
}

public void setEmp_codee(List<Att> emp_codee) {
	this.emp_codee = emp_codee;
}

public List<Att> getEmployee_namee() {
	return employee_namee;
}

public void setEmployee_namee(List<Att> employee_namee) {
	this.employee_namee = employee_namee;
}

public List<Att> getArea_namee() {
	return area_namee;
}

public void setArea_namee(List<Att> area_namee) {
	this.area_namee = area_namee;
}

public List<Att> getWork_datee() {
	return work_datee;
}

public void setWork_datee(List<Att> work_datee) {
	this.work_datee = work_datee;
}

public List<Att> getDay_endd() {
	return day_endd;
}

public void setDay_endd(List<Att> day_endd) {
	this.day_endd = day_endd;
}

public List<Att> getDay_startt() {
	return day_startt;
}

public void setDay_startt(List<Att> day_startt) {
	this.day_startt = day_startt;
}

public List<Att> getTotal_working_hourss() {
	return total_working_hourss;
}

public void setTotal_working_hourss(List<Att> total_working_hourss) {
	this.total_working_hourss = total_working_hourss;
}

public List<Att> getOvertime_hourss() {
	return overtime_hourss;
}

public void setOvertime_hourss(List<Att> overtime_hourss) {
	this.overtime_hourss = overtime_hourss;
}

public List<Att> getRegularise_reason() {
	return regularise_reason;
}

public void setRegularise_reason(List<Att> regularise_reason) {
	this.regularise_reason = regularise_reason;
}

public String getUser_id() {
	return user_id;
}

public void setUser_id(String user_id) {
	this.user_id = user_id;
}

public String getUser_name() {
	return user_name;
}

public void setUser_name(String user_name) {
	this.user_name = user_name;
}

public String getAction_by() {
	return action_by;
}

public void setAction_by(String action_by) {
	this.action_by = action_by;
}

public String getIs_regularised() {
	return is_regularised;
}

public void setIs_regularised(String is_regularised) {
	this.is_regularised = is_regularised;
}

public String getSite_name() {
	return Site_name;
}

public void setSite_name(String site_name) {
	Site_name = site_name;
}

public String getPosition_id() {
	return position_id;
}

public void setPosition_id(String position_id) {
	this.position_id = position_id;
}

public String getPosition_name() {
	return position_name;
}

public void setPosition_name(String position_name) {
	this.position_name = position_name;
}

public String getSl_no() {
	return sl_no;
}

public void setSl_no(String sl_no) {
	this.sl_no = sl_no;
}

public String getShift_type() {
	return shift_type;
}

public void setShift_type(String shift_type) {
	this.shift_type = shift_type;
}

public String getTotal_hours() {
	return total_hours;
}

public void setTotal_hours(String total_hours) {
	this.total_hours = total_hours;
}

public String getTotal_minutes() {
	return total_minutes;
}

public void setTotal_minutes(String total_minutes) {
	this.total_minutes = total_minutes;
}

public String getOvertime_minutes() {
	return overtime_minutes;
}

public void setOvertime_minutes(String overtime_minutes) {
	this.overtime_minutes = overtime_minutes;
}

public String getIs_holiday() {
	return is_holiday;
}

public void setIs_holiday(String is_holiday) {
	this.is_holiday = is_holiday;
}

public String getHoliday_reason() {
	return holiday_reason;
}

public void setHoliday_reason(String holiday_reason) {
	this.holiday_reason = holiday_reason;
}

public String getWd() {
	return wd;
}

public void setWd(String wd) {
	this.wd = wd;
}

public String getSl_No() {
	return sl_No;
}

public void setSl_No(String sl_No) {
	this.sl_No = sl_No;
}

public String getUser() {
	return user;
}

public void setUser(String user) {
	this.user = user;
}

public String getRole() {
	return role;
}

public void setRole(String role) {
	this.role = role;
}

public String getFrom_date() {
	return from_date;
}

public void setFrom_date(String from_date) {
	this.from_date = from_date;
}

public String getTo_date() {
	return to_date;
}

public void setTo_date(String to_date) {
	this.to_date = to_date;
}

public String getEmp_code() {
	return emp_code;
}

public void setEmp_code(String emp_code) {
	this.emp_code = emp_code;
}

public String getEmployee_name() {
	return employee_name;
}

public void setEmployee_name(String employee_name) {
	this.employee_name = employee_name;
}

public String getArea_name() {
	return area_name;
}

public void setArea_name(String area_name) {
	this.area_name = area_name;
}

public String getWork_date() {
	return work_date;
}

public void setWork_date(String work_date) {
	this.work_date = work_date;
}

public String getDay_start() {
	return day_start;
}

public void setDay_start(String day_start) {
	this.day_start = day_start;
}

public String getDay_end() {
	return day_end;
}

public void setDay_end(String day_end) {
	this.day_end = day_end;
}

public String getTotal_working_hours() {
	return total_working_hours;
}

public void setTotal_working_hours(String total_working_hours) {
	this.total_working_hours = total_working_hours;
}

public String getOvertime_hours() {
	return overtime_hours;
}

public void setOvertime_hours(String overtime_hours) {
	this.overtime_hours = overtime_hours;
}

public String getHas_overtime() {
	return has_overtime;
}

public void setHas_overtime(String has_overtime) {
	this.has_overtime = has_overtime;
}

public String getAttendance_status() {
	return attendance_status;
}

public void setAttendance_status(String attendance_status) {
	this.attendance_status = attendance_status;
}




}
