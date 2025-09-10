package com.resustainability.reisp.model;

import java.time.LocalDate;

public class AttendanceDayDTO {
	 private String inTime;     // e.g., "09:15"
	    private String outTime;    // e.g., "18:00"
	    private String workedHours; // e.g., "8h 30m"
	    private String otHours;    // e.g., "1h 0m"
	    private String leaveType;
	    private String status;
	    private LocalDate date;
	    
	    
		public LocalDate getDate() {
			return date;
		}
		public void setDate(LocalDate date) {
			this.date = date;
		}
		public String getStatus() {
			return status;
		}
		public void setStatus(String status) {
			this.status = status;
		}
		
		public String getInTime() { 
			return inTime;
		}
		public void setInTime(String inTime) {
			this.inTime = inTime;
		}
		public String getOutTime() {
			return outTime;
		}
		public void setOutTime(String outTime) {
			this.outTime = outTime;
		}
		public String getWorkedHours() {
			return workedHours;
		}
		public void setWorkedHours(String workedHours) {
			this.workedHours = workedHours;
		}
		public String getOtHours() {
			return otHours;
		}
		public void setOtHours(String otHours) {
			this.otHours = otHours;
		}
		public String getLeaveType() {
			return leaveType;
		}
		public void setLeaveType(String leaveType) {
			this.leaveType = leaveType;
		}  
	    
}
