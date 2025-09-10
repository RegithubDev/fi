package com.resustainability.reisp.model;

public class DailyAttendanceDTO {
    private String dayOfWeek;       // e.g., Mon, Tue
    private String checkIn;         // e.g., 09:00
    private String checkOut;        // e.g., 18:00
    private String totalHours;      // e.g., 9h 0m
    private String workedHours;     // e.g., 9h 0m
    private String ot;              // e.g., 1h
    private String attendanceStatus; // Present/Absent/Leave
    private String leaveReason;     // CL/SL/EL or null
	public String getDayOfWeek() {
		return dayOfWeek;
	}
	public void setDayOfWeek(String dayOfWeek) {
		this.dayOfWeek = dayOfWeek;
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
	public String getWorkedHours() {
		return workedHours;
	}
	public void setWorkedHours(String workedHours) {
		this.workedHours = workedHours;
	}
	public String getOt() {
		return ot;
	}
	public void setOt(String ot) {
		this.ot = ot;
	}
	public String getAttendanceStatus() {
		return attendanceStatus;
	}
	public void setAttendanceStatus(String attendanceStatus) {
		this.attendanceStatus = attendanceStatus;
	}
	public String getLeaveReason() {
		return leaveReason;
	}
	public void setLeaveReason(String leaveReason) {
		this.leaveReason = leaveReason;
	}

    // Getters and Setters
}

