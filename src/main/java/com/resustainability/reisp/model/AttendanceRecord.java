package com.resustainability.reisp.model;


public class AttendanceRecord {
	 private String empCode;
	    private String employeeName;
	    private String positionName;
	    private String areaName;
	    private String siteName;
	    private String workDate;
	    private String dayStart;
	    private String dayEnd,shiftType;
	    private int totalHours;
	    private int totalMinutes;
	    private int overtimeHours;
	    private int overtimeMinutes;
	    private String attendanceStatus;
	    private boolean isHoliday;
	    private String holidayReason;
	    
	    
		public String getShiftType() {
			return shiftType;
		}
		public void setShiftType(String shiftType) {
			this.shiftType = shiftType;
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
		public String getPositionName() {
			return positionName;
		}
		public void setPositionName(String positionName) {
			this.positionName = positionName;
		}
		public String getAreaName() {
			return areaName;
		}
		public void setAreaName(String areaName) {
			this.areaName = areaName;
		}
		public String getSiteName() {
			return siteName;
		}
		public void setSiteName(String siteName) {
			this.siteName = siteName;
		}
	
		public int getTotalHours() {
			return totalHours;
		}
		public void setTotalHours(int totalHours) {
			this.totalHours = totalHours;
		}
		public int getTotalMinutes() {
			return totalMinutes;
		}
		public void setTotalMinutes(int totalMinutes) {
			this.totalMinutes = totalMinutes;
		}
		public int getOvertimeHours() {
			return overtimeHours;
		}
		public void setOvertimeHours(int overtimeHours) {
			this.overtimeHours = overtimeHours;
		}
		public int getOvertimeMinutes() {
			return overtimeMinutes;
		}
		public void setOvertimeMinutes(int overtimeMinutes) {
			this.overtimeMinutes = overtimeMinutes;
		}
		public String getAttendanceStatus() {
			return attendanceStatus;
		}
		public void setAttendanceStatus(String attendanceStatus) {
			this.attendanceStatus = attendanceStatus;
		}
		public boolean isHoliday() {
			return isHoliday;
		}
		public void setHoliday(boolean isHoliday) {
			this.isHoliday = isHoliday;
		}
		public String getHolidayReason() {
			return holidayReason;
		}
		public void setHolidayReason(String holidayReason) {
			this.holidayReason = holidayReason;
		}
	    
	    
}
