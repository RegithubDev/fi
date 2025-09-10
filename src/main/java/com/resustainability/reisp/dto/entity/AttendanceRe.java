package com.resustainability.reisp.dto.entity;

// 27 columns
public class AttendanceRe {
    private Long slNo;
    private String employeeCode;
    private String employeeName;
    private String positionName;
    private String areaName;
    private String siteName;
    private String workDate;
    private String dayStart;
    private String dayEnd;
    private String shiftType;
    private String totalWorkingHours;
    private String totalHours;
    private String totalMinutes;
    private String overtimeHours;
    private String overtimeMinutes;
    private String attendanceStatus;
    private String holiday;
    private String holidayReason;
    private String regularised;
    private String actionBy;
    private String regulariseReason;
    private String leave;
    private String leaveReason;
    private String finalOT;
    private String remarks;
    private String leaveDuration;
    private String leaveHalfSlot;

    public AttendanceRe() {}
    public AttendanceRe(Long slNo, String employeeCode, String employeeName, String positionName, String areaName, String siteName, String workDate, String dayStart, String dayEnd, String shiftType, String totalWorkingHours, String totalHours, String totalMinutes, String overtimeHours, String overtimeMinutes, String attendanceStatus, String holiday, String holidayReason, String regularised, String actionBy, String regulariseReason, String leave, String leaveReason, String finalOT, String remarks, String leaveDuration, String leaveHalfSlot) {
        this.slNo = slNo;
        this.employeeCode = employeeCode;
        this.employeeName = employeeName;
        this.positionName = positionName;
        this.areaName = areaName;
        this.siteName = siteName;
        this.workDate = workDate;
        this.dayStart = dayStart;
        this.dayEnd = dayEnd;
        this.shiftType = shiftType;
        this.totalWorkingHours = totalWorkingHours;
        this.totalHours = totalHours;
        this.totalMinutes = totalMinutes;
        this.overtimeHours = overtimeHours;
        this.overtimeMinutes = overtimeMinutes;
        this.attendanceStatus = attendanceStatus;
        this.holiday = holiday;
        this.holidayReason = holidayReason;
        this.regularised = regularised;
        this.actionBy = actionBy;
        this.regulariseReason = regulariseReason;
        this.leave = leave;
        this.leaveReason = leaveReason;
        this.finalOT = finalOT;
        this.remarks = remarks;
        this.leaveDuration = leaveDuration;
        this.leaveHalfSlot = leaveHalfSlot;
    }

    public Long getSlNo() {
        return slNo;
    }

    public String getEmployeeCode() {
        return employeeCode;
    }

    public String getEmployeeName() {
        return employeeName;
    }

    public String getPositionName() {
        return positionName;
    }

    public String getAreaName() {
        return areaName;
    }

    public String getSiteName() {
        return siteName;
    }

    public String getWorkDate() {
        return workDate;
    }

    public String getDayStart() {
        return dayStart;
    }

    public String getDayEnd() {
        return dayEnd;
    }

    public String getShiftType() {
        return shiftType;
    }

    public String getTotalWorkingHours() {
        return totalWorkingHours;
    }

    public String getTotalHours() {
        return totalHours;
    }

    public String getTotalMinutes() {
        return totalMinutes;
    }

    public String getOvertimeHours() {
        return overtimeHours;
    }

    public String getOvertimeMinutes() {
        return overtimeMinutes;
    }

    public String getAttendanceStatus() {
        return attendanceStatus;
    }

    public String getHoliday() {
        return holiday;
    }

    public String getHolidayReason() {
        return holidayReason;
    }

    public String getRegularised() {
        return regularised;
    }

    public String getActionBy() {
        return actionBy;
    }

    public String getRegulariseReason() {
        return regulariseReason;
    }

    public String getLeave() {
        return leave;
    }

    public String getLeaveReason() {
        return leaveReason;
    }

    public String getFinalOT() {
        return finalOT;
    }

    public String getRemarks() {
        return remarks;
    }

    public String getLeaveDuration() {
        return leaveDuration;
    }

    public String getLeaveHalfSlot() {
        return leaveHalfSlot;
    }

    public void setSlNo(Long slNo) {
        this.slNo = slNo;
    }

    public void setEmployeeCode(String employeeCode) {
        this.employeeCode = employeeCode;
    }

    public void setEmployeeName(String employeeName) {
        this.employeeName = employeeName;
    }

    public void setPositionName(String positionName) {
        this.positionName = positionName;
    }

    public void setAreaName(String areaName) {
        this.areaName = areaName;
    }

    public void setSiteName(String siteName) {
        this.siteName = siteName;
    }

    public void setWorkDate(String workDate) {
        this.workDate = workDate;
    }

    public void setDayStart(String dayStart) {
        this.dayStart = dayStart;
    }

    public void setDayEnd(String dayEnd) {
        this.dayEnd = dayEnd;
    }

    public void setShiftType(String shiftType) {
        this.shiftType = shiftType;
    }

    public void setTotalWorkingHours(String totalWorkingHours) {
        this.totalWorkingHours = totalWorkingHours;
    }

    public void setTotalHours(String totalHours) {
        this.totalHours = totalHours;
    }

    public void setTotalMinutes(String totalMinutes) {
        this.totalMinutes = totalMinutes;
    }

    public void setOvertimeHours(String overtimeHours) {
        this.overtimeHours = overtimeHours;
    }

    public void setOvertimeMinutes(String overtimeMinutes) {
        this.overtimeMinutes = overtimeMinutes;
    }

    public void setAttendanceStatus(String attendanceStatus) {
        this.attendanceStatus = attendanceStatus;
    }

    public void setHoliday(String holiday) {
        this.holiday = holiday;
    }

    public void setHolidayReason(String holidayReason) {
        this.holidayReason = holidayReason;
    }

    public void setRegularised(String regularised) {
        this.regularised = regularised;
    }

    public void setActionBy(String actionBy) {
        this.actionBy = actionBy;
    }

    public void setRegulariseReason(String regulariseReason) {
        this.regulariseReason = regulariseReason;
    }

    public void setLeave(String leave) {
        this.leave = leave;
    }

    public void setLeaveReason(String leaveReason) {
        this.leaveReason = leaveReason;
    }

    public void setFinalOT(String finalOT) {
        this.finalOT = finalOT;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    public void setLeaveDuration(String leaveDuration) {
        this.leaveDuration = leaveDuration;
    }

    public void setLeaveHalfSlot(String leaveHalfSlot) {
        this.leaveHalfSlot = leaveHalfSlot;
    }
}
