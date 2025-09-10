package com.resustainability.reisp.model;

import java.util.List;

public class AttendanceLeaveDTO {
    private String empCode;
    private String employeeName,position_name;
    private String workDate;
    private String dayStart;
    private String dayEnd;
    private String shiftType;
    private String attendanceStatus,leave_reason,leaveType;
    private int totalHours;
    private int overtimeHours;
    private String remarks;
    private String halfDayTime; // e.g., "13:30"

    private List<String> workDates; // for multi-day leave
    
    private String checkIn;
    private String checkOut;

    private boolean multiple;
    private String fromDate;
    private String toDate;
    
    private boolean halfDay;
    private String halfDaySlot;
    
    
    public String getCheckIn() {
		return checkIn;
	}

	public void setCheckIn(String checkIn) {
		this.checkIn = checkIn;
	}

	public String getCheckOut() {
		return checkOut;
	}

	public void setCheckOut(String checkOut) {
		this.checkOut = checkOut;
	}

	public boolean isMultiple() {
    	return multiple;
    }
    
	public void setMultiple(boolean multiple) {
		this.multiple = multiple;
	}
    
	public String getFromDate() {
		return fromDate;
	}
	
	public void setFromDate(String fromDate) {
		this.fromDate = fromDate;
	}

	public String getToDate() {
		return toDate;
	}

	public void setToDate(String toDate) {
		this.toDate = toDate;
	}

	public boolean isHalfDay() {
		return halfDay;
	}

	public void setHalfDay(boolean halfDay) {
		this.halfDay = halfDay;
	}

	public String getHalfDaySlot() {
		return halfDaySlot;
	}

	public void setHalfDaySlot(String halfDaySlot) {
		this.halfDaySlot = halfDaySlot;
	}
	

	public String getHalfDayTime() {
		return halfDayTime;
	}
	public void setHalfDayTime(String halfDayTime) {
		this.halfDayTime = halfDayTime;
	}
	public List<String> getWorkDates() {
		return workDates;
	}
	public void setWorkDates(List<String> workDates) {
		this.workDates = workDates;
	}
	public String getLeaveType() {
		return leaveType;
	}
	public void setLeaveType(String leaveType) {
		this.leaveType = leaveType;
	}
	public String getPosition_name() {
		return position_name;
	}
	public void setPosition_name(String position_name) {
		this.position_name = position_name;
	}
	public String getLeave_reason() {
		return leave_reason;
	}
	public void setLeave_reason(String leave_reason) {
		this.leave_reason = leave_reason;
	}
	public String getEmpCode() {
		return empCode;
	}
	public void setEmpCode(String empCode) {
		this.empCode = empCode;
	}
	public String getEmployeeName() {
		return employeeName;
	}
	public void setEmployeeName(String employeeName) {
		this.employeeName = employeeName;
	}
	public String getWorkDate() {
		return workDate;
	}
	public void setWorkDate(String workDate) {
		this.workDate = workDate;
	}
	public String getDayStart() {
		return dayStart;
	}
	public void setDayStart(String dayStart) {
		this.dayStart = dayStart;
	}
	public String getDayEnd() {
		return dayEnd;
	}
	public void setDayEnd(String dayEnd) {
		this.dayEnd = dayEnd;
	}
	public String getShiftType() {
		return shiftType;
	}
	public void setShiftType(String shiftType) {
		this.shiftType = shiftType;
	}
	public String getAttendanceStatus() {
		return attendanceStatus;
	}
	public void setAttendanceStatus(String attendanceStatus) {
		this.attendanceStatus = attendanceStatus;
	}
	public int getTotalHours() {
		return totalHours;
	}
	public void setTotalHours(int totalHours) {
		this.totalHours = totalHours;
	}
	public int getOvertimeHours() {
		return overtimeHours;
	}
	public void setOvertimeHours(int overtimeHours) {
		this.overtimeHours = overtimeHours;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
    
    
}

