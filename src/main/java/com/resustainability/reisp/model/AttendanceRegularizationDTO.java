package com.resustainability.reisp.model;

public class AttendanceRegularizationDTO {
	 private String empCode;
	    private String workDate;
	    private String checkIn;
	    private String checkOut;
	    private String totalHours;
	    private String otHours;
	    private String status;
		public String getEmpCode() {
			return empCode;
		}
		public void setEmpCode(String empCode) {
			this.empCode = empCode;
		}
		
		public String getWorkDate() {
			return workDate;
		}
		public void setWorkDate(String workDate) {
			this.workDate = workDate;
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
		public String getOtHours() {
			return otHours;
		}
		public void setOtHours(String otHours) {
			this.otHours = otHours;
		}
		public String getStatus() {
			return status;
		}
		public void setStatus(String status) {
			this.status = status;
		}
	    
	    
}
