package com.resustainability.reisp.service;

import java.sql.Date;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;

import com.resustainability.reisp.model.AttendanceRegularizationDTO;
import java.util.Map;
import java.util.Set;

import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddressList;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.apache.poi.ss.usermodel.DataValidation;
import org.apache.poi.ss.usermodel.DataValidationConstraint;
import org.apache.poi.ss.usermodel.DataValidationHelper;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.CreationHelper;
import org.apache.poi.ss.usermodel.CellStyle;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;
import java.sql.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.resustainability.reisp.common.DateParser;
import com.resustainability.reisp.dao.AttendanceDAO;
import com.resustainability.reisp.dto.EmployeeMeta;
import com.resustainability.reisp.model.AttendanceDayDTO;
import com.resustainability.reisp.model.AttendanceDto;
import com.resustainability.reisp.model.AttendanceExportDTO;
import com.resustainability.reisp.model.AttendanceLeaveDTO;
import com.resustainability.reisp.model.AttendanceRegularizationDTO;
import com.resustainability.reisp.model.EmployeeDto;

@Service
public class AttendanceServiceImpl implements AttendanceService {
	@Autowired
    private AttendanceDAO attendanceDAO;

    @Override
    public List<AttendanceDto> getPaginatedAttendance(String empCode, String fromDate, String toDate, int start, int length, String searchValue) {
        return attendanceDAO.fetchPaginatedAttendance(empCode, fromDate, toDate, start, length, searchValue);
    }
	@Override
	public Object regularizeAttendance(AttendanceRegularizationDTO data, String userId) {
		  return attendanceDAO.regularizeAttendance(data,userId);
		
	}
    @Override
    public int getTotalAttendanceCount(String empCode, String fromDate, String toDate,String searchValue) {
        return attendanceDAO.fetchTotalAttendanceCount(empCode, fromDate, toDate, searchValue);
    }

    @Override
    public List<EmployeeDto> getEmployeeFilterList() {
        return attendanceDAO.fetchDistinctEmployees();
    }
    
    @Override
    public void reloadAndInsertAttendance(String fromDate, String toDate, String areaAlias) throws SQLException {
        attendanceDAO.executeAttendanceReloadInsert( fromDate,  toDate,  areaAlias);
    }

    @Override
    public List<AttendanceDto> getAllMissedPunches(String empCode, LocalDate fromDate, 
                                                 LocalDate toDate, String areaAlias, 
                                                 boolean onlyMissed) {
        // Convert LocalDate to java.sql.Date if needed
        Date sqlFromDate = fromDate != null ? Date.valueOf(fromDate) : null;
        Date sqlToDate = toDate != null ? Date.valueOf(toDate) : null;
        
        return attendanceDAO.findMissedPunches(empCode, sqlFromDate, sqlToDate, areaAlias, onlyMissed);
    }
    
    @Override
    public void downloadMissedPunches(List<AttendanceDto> missedPunches, 
                                    HttpServletResponse response) throws IOException {
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=\"all_missed_punches.xlsx\"");
        
        try (Workbook workbook = new XSSFWorkbook()) {
            Sheet sheet = workbook.createSheet("Missed Punches");
            
            // Create styles
            CellStyle headerStyle = createHeaderStyle(workbook);
            CellStyle highlightStyle = createHighlightStyle(workbook);
            CellStyle dateStyle = createDateCellStyle(workbook);
            
            // Create header row
            createHeaderRow(sheet, headerStyle);
            
            // Fill data
            fillDataRows(sheet, missedPunches, highlightStyle, dateStyle);
            
            // Auto-size columns
            autoSizeColumns(sheet);
            
            workbook.write(response.getOutputStream());
        }
    }

    private CellStyle createHeaderStyle(Workbook workbook) {
        CellStyle style = workbook.createCellStyle();
        Font font = workbook.createFont();
        font.setBold(true);
        font.setColor(IndexedColors.WHITE.getIndex());
        style.setFont(font);
        style.setFillForegroundColor(IndexedColors.DARK_BLUE.getIndex());
        style.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        style.setAlignment(HorizontalAlignment.CENTER);
        return style;
    }
    
    private CellStyle createHighlightStyle(Workbook workbook) {
        CellStyle style = workbook.createCellStyle();
        style.setFillForegroundColor(IndexedColors.LIGHT_YELLOW.getIndex());
        style.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        return style;
    }
    
    private CellStyle createDateCellStyle(Workbook workbook) {
        CellStyle style = workbook.createCellStyle();
        CreationHelper createHelper = workbook.getCreationHelper();
        style.setDataFormat(createHelper.createDataFormat().getFormat("yyyy-MM-dd"));
        return style;
    }
    
    private void createHeaderRow(Sheet sheet, CellStyle headerStyle) {
        Row headerRow = sheet.createRow(0);
        String[] headers = {
            "Employee Code", "Employee Name", "Date", 
            "Check In", "Check Out", "Total Hours", 
            "Status", "Missed Punch Type", "Holiday Reason"
        };
        
        for (int i = 0; i < headers.length; i++) {
            Cell cell = headerRow.createCell(i);
            cell.setCellValue(headers[i]);
            cell.setCellStyle(headerStyle);
        }
    }
    
    private void fillDataRows(Sheet sheet, List<AttendanceDto> records, 
                            CellStyle highlightStyle, CellStyle dateStyle) {
        int rowNum = 1;
        for (AttendanceDto record : records) {
            Row row = sheet.createRow(rowNum++);
            
            // Employee Code
            row.createCell(0).setCellValue(record.getEmpCode());
            
            // Employee Name
            row.createCell(1).setCellValue(record.getEmployeeName());
            
            // Date
            Cell dateCell = row.createCell(2);
            if (record.getWorkDate() != null) {
                dateCell.setCellValue(record.getWorkDate());
                dateCell.setCellStyle(dateStyle);
            }
            
            // Check In
            String checkIn = record.getCheckIn() != null && !record.getCheckIn().equals("-") ? 
                record.getCheckIn() : "MISSING";
            Cell checkInCell = row.createCell(3);
            checkInCell.setCellValue(checkIn);
            
            // Check Out
            String checkOut = record.getCheckOut() != null && !record.getCheckOut().equals("-") ? 
                record.getCheckOut() : "MISSING";
            Cell checkOutCell = row.createCell(4);
            checkOutCell.setCellValue(checkOut);
            
            // Total Hours
            row.createCell(5).setCellValue(record.getTotalHours() != null ? 
                record.getTotalHours() : "0:00");
            
            // Status
            row.createCell(6).setCellValue(record.getAttendanceStatus());
            
            // Missed Punch Type
            String missedType = determineMissedType(checkIn, checkOut);
            row.createCell(7).setCellValue(missedType);
            
            // Highlight cells
            if (missedType.contains("In")) checkInCell.setCellStyle(highlightStyle);
            if (missedType.contains("Out")) checkOutCell.setCellStyle(highlightStyle);
            
            // Holiday Reason
            row.createCell(8).setCellValue(record.getHolidayReason() != null ? 
                record.getHolidayReason() : "");
        }
    }
    
    private String determineMissedType(String checkIn, String checkOut) {
        if (checkIn.equals("MISSING") && checkOut.equals("MISSING")) {
            return "Both";
        } else if (checkIn.equals("MISSING")) {
            return "Check In";
        } else if (checkOut.equals("MISSING")) {
            return "Check Out";
        }
        return "None";
    }
    
    private void autoSizeColumns(Sheet sheet) {
        for (int i = 0; i < 9; i++) {
            sheet.autoSizeColumn(i);
        }
    }
	@Override
	public Object applyLeave(AttendanceLeaveDTO dto, String userId) {
		  return attendanceDAO.applyLeave(dto,userId);
		
	}
	
	@Override
	public String v2ApplyLeave(AttendanceLeaveDTO dto, String userId) {
        return attendanceDAO.v2ApplyLeave(dto, userId);
	}
	
	@Override
	public Object addAttendance(AttendanceDto data, String userId) {
		 return attendanceDAO.addAttendance(data,userId);
		
	}
	@Override
	public List<EmployeeDto> getEligibleEmployees() {
		 return attendanceDAO.getEligibleEmployees();
	}
	@Override
	public List<AttendanceExportDTO> getExportData(String fromDate, String toDate) {
	    List<AttendanceExportDTO> flatList = attendanceDAO.getExportData(fromDate, toDate);

	    Map<String, AttendanceExportDTO> uniqueEmployees = new LinkedHashMap<>();
	    Map<String, Map<LocalDate, AttendanceDayDTO>> empDailyMap = new HashMap<>();

	    for (AttendanceExportDTO flat : flatList) {
	        String key = flat.getEmpCode();

	        if (!uniqueEmployees.containsKey(key)) {
	            AttendanceExportDTO main = new AttendanceExportDTO();
	            main.setEmpCode(flat.getEmpCode());
	            main.setEmployeeName(flat.getEmployeeName());
	            uniqueEmployees.put(key, main);
	            empDailyMap.put(key, new HashMap<>());
	        }

	        AttendanceDayDTO day = new AttendanceDayDTO();
	        day.setDate(flat.getWorkDate());
	        day.setInTime(flat.getInTime());
	        day.setOutTime(flat.getOutTime());
	        day.setWorkedHours(flat.getTotalWorkingHours());
	        day.setOtHours(flat.getOtHours());
	        day.setStatus(flat.getAttendanceStatus());
	        day.setLeaveType(flat.getLeaveReason());

	        empDailyMap.get(key).put(flat.getWorkDate(), day);
	    }

	    for (String empCode : uniqueEmployees.keySet()) {
	        AttendanceExportDTO emp = uniqueEmployees.get(empCode);
	        emp.setDailyAttendanceMap(empDailyMap.get(empCode));
	    }

	    return new ArrayList<>(uniqueEmployees.values());
	}

}
