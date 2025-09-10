package com.resustainability.reisp.model;

public class EmployeeDto {
	 private String empCode;
	    private String firstName;
	    private String employeeName,position_name;
	    private String workDate;
	    private String dayStart;
	    private String dayEnd;
	    private String shiftType;
	    private String attendanceStatus,leave_reason;
	    private int totalHours;
	    private int overtimeHours;
	    private String remarks;
	    
	
		public EmployeeDto() {
	    }

	

	    public String getEmpCode() {
			return empCode;
		}



		public void setEmpCode(String empCode) {
			this.empCode = empCode;
		}



		public String getFirstName() {
			return firstName;
		}



		public void setFirstName(String firstName) {
			this.firstName = firstName;
		}



		public String getEmployeeName() {
			return employeeName;
		}



		public void setEmployeeName(String employeeName) {
			this.employeeName = employeeName;
		}



		public String getPosition_name() {
			return position_name;
		}



		public void setPosition_name(String position_name) {
			this.position_name = position_name;
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



		public String getLeave_reason() {
			return leave_reason;
		}



		public void setLeave_reason(String leave_reason) {
			this.leave_reason = leave_reason;
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



		@Override
	    public String toString() {
	        return "EmployeeDto{" +
	                "empCode='" + empCode + '\'' +
	                ", firstName='" + firstName + '\'' +
	                '}';
	    }
}
