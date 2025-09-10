package com.resustainability.reisp.model;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.Map;

public class AttendanceExportDTO {
    private String empCode;
    private String employeeName;
    private LocalDate workDate;

    private String checkIn;            // e.g., "2025-06-25 09:00"
    private String checkOut;           // e.g., "2025-06-25 18:00"

    private String shiftType;          // e.g., "Shift A", "General Shift"
    private String totalWorkingHours;  // e.g., "8h 30m"
    private String overtime;           // e.g., "1h 30m"
    private String rawHours;           // optional raw time in hh:mm:ss if needed
 // Must contain:
    private String inTime;        // "05:09"
    private String outTime;       // "16:10"
    private String workedHours;   // "11:01"
    private String otHours;       // "01:30" or "0" — avoid null

    private String attendanceStatus;   // e.g., "Present", "Absent", "Leave"
    private String leaveReason;        // e.g., "CL", "SL", "EL"  // e.g., "CL", "SL", "EL", or null
    private Map<LocalDate, AttendanceDayDTO> dailyAttendanceMap = new HashMap<>();

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

	public Map<LocalDate, AttendanceDayDTO> getDailyAttendanceMap() {
        return dailyAttendanceMap;
    }

    public void setDailyAttendanceMap(Map<LocalDate, AttendanceDayDTO> dailyAttendanceMap) {
        this.dailyAttendanceMap = dailyAttendanceMap;
    }
	public String getRawHours() {
		return rawHours;
	}

	public void setRawHours(String rawHours) {
		this.rawHours = rawHours;
	}

	// Getters and Setters
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

    public LocalDate getWorkDate() {
        return workDate;
    }

    public void setWorkDate(LocalDate workDate) {
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

    public String getOvertime() {
        return overtime;
    }

    public void setOvertime(String overtime) {
        this.overtime = overtime;
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
}

