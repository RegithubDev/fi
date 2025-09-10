package com.resustainability.reisp.model;

public class AttendanceDto {
	private Long sl_no;
	private String workDate;
	private String empCode;
	private String employeeName;
	private String checkIn;
	private String checkOut;
	private String shiftType;
	private String totalWorkingHours;
	private String totalHours;
	private String attendanceStatus;
	private int isHoliday;
	private String holidayReason;
	private String overtime;
	private String finalOT;
	private String remarks,leave_reason,is_leave;
	private String isRegularised;
	
	private String leaveDuration;
	private String leaveHalfSlot;


	public AttendanceDto() {}

	public Long getSl_no() {
		return sl_no;
	}
	public void setSl_no(Long sl_no) {
		this.sl_no = sl_no;
	}
	public String getIsRegularised() {
		return isRegularised;
	}
	public void setIsRegularised(String isRegularised) {
		this.isRegularised = isRegularised;
	}
	public String getLeaveDuration() {
		return leaveDuration;
	}
	public void setLeaveDuration(String leaveDuration) {
		this.leaveDuration = leaveDuration;
	}
	public String getLeaveHalfSlot() {
		return leaveHalfSlot;
	}
	public void setLeaveHalfSlot(String leaveHalfSlot) {
		this.leaveHalfSlot = leaveHalfSlot;
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
	public String getEmployeeName() {
		return employeeName;
	}
	public void setEmployeeName(String employeeName) {
		this.employeeName = employeeName;
	}
	public String getShiftType() {
		return shiftType;
	}
	public void setShiftType(String shiftType) {
		this.shiftType = shiftType;
	}
	public String getTotalWorkingHours() {
		return totalWorkingHours;
	}
	public void setTotalWorkingHours(String totalWorkingHours) {
		this.totalWorkingHours = totalWorkingHours;
	}
	public String getAttendanceStatus() {
		return attendanceStatus;
	}
	public void setAttendanceStatus(String attendanceStatus) {
		this.attendanceStatus = attendanceStatus;
	}
	public int getIsHoliday() {
		return isHoliday;
	}
	public void setIsHoliday(int isHoliday) {
		this.isHoliday = isHoliday;
	}
	public String getHolidayReason() {
		return holidayReason;
	}
	public void setHolidayReason(String holidayReason) {
		this.holidayReason = holidayReason;
	}
	public String getOvertime() {
		return overtime;
	}
	public void setOvertime(String overtime) {
		this.overtime = overtime;
	}
	public String getFinalOT() {
		return finalOT;
	}
	public void setFinalOT(String finalOT) {
		this.finalOT = finalOT;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	// Getters and setters
	public String getWorkDate() {
		return workDate;
	}
	public void setWorkDate(String workDate) {
		this.workDate = workDate;
	}
	public String getEmpCode() {
		return empCode;
	}
	public void setEmpCode(String empCode) {
		this.empCode = empCode;
	}
	
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
	public String getTotalHours() {
		return totalHours;
	}
	public void setTotalHours(String totalHours) {
		this.totalHours = totalHours;
	}

    
}


