package com.resustainability.reisp.common;

import com.resustainability.reisp.model.AttendanceDayDTO;
import com.resustainability.reisp.model.AttendanceExportDTO;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.util.StringUtils;

import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.TextStyle;
import java.util.*;
import org.apache.poi.ss.util.CellRangeAddress;

public class ExportUtil {

    public static void exportToCSV(HttpServletResponse response, List<AttendanceExportDTO> data) throws IOException {
        response.setContentType("text/csv");
        response.setHeader("Content-Disposition", "attachment; filename=attendance.csv");

        PrintWriter writer = response.getWriter();
        writer.println("Emp Code,Employee Name,Date,Check In,Check Out,Shift,Working Hours,Overtime,Status,Leave Reason");

        for (AttendanceExportDTO dto : data) {
            writer.printf("%s,%s,%s,%s,%s,%s,%s,%s,%s,%s%n",
                dto.getEmpCode(),
                dto.getEmployeeName(),
                dto.getWorkDate(),
                optional(dto.getCheckIn()),
                optional(dto.getCheckOut()),
                optional(dto.getShiftType()),
                optional(dto.getTotalWorkingHours()),
                optional(dto.getOvertime()),
                optional(dto.getAttendanceStatus()),
                optional(dto.getLeaveReason())
            );
        }

        writer.flush();
        writer.close();
    }

    public static void exportToExcel(HttpServletResponse response, List<AttendanceExportDTO> data) throws IOException {
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=attendance.xlsx");

        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("Attendance");

        String[] headers = {
            "Emp Code", "Employee Name", "Date", "Check In", "Check Out",
            "Shift", "Working Hours", "Overtime", "Status", "Leave Reason"
        };

        // Header row
        Row headerRow = sheet.createRow(0);
        CellStyle headerStyle = workbook.createCellStyle();
        org.apache.poi.ss.usermodel.Font headerFont = workbook.createFont();
        headerFont.setBold(true);
        headerStyle.setFont(headerFont);

        for (int i = 0; i < headers.length; i++) {
            Cell cell = headerRow.createCell(i);
            cell.setCellValue(headers[i]);
            cell.setCellStyle(headerStyle);
        }

        int rowNum = 1;
        for (AttendanceExportDTO dto : data) {
            Row row = sheet.createRow(rowNum++);
            row.createCell(0).setCellValue(dto.getEmpCode());
            row.createCell(1).setCellValue(dto.getEmployeeName());
            row.createCell(2).setCellValue(dto.getWorkDate() != null ? dto.getWorkDate().toString() : "-");
            row.createCell(3).setCellValue(optional(dto.getCheckIn()));
            row.createCell(4).setCellValue(optional(dto.getCheckOut()));
            row.createCell(5).setCellValue(optional(dto.getShiftType()));
            row.createCell(6).setCellValue(optional(dto.getTotalWorkingHours()));
            row.createCell(7).setCellValue(optional(dto.getOvertime()));
            row.createCell(8).setCellValue(optional(dto.getAttendanceStatus()));
            row.createCell(9).setCellValue(optional(dto.getLeaveReason()));
        }

        for (int i = 0; i < headers.length; i++) {
            sheet.autoSizeColumn(i);
        }

        workbook.write(response.getOutputStream());
        workbook.close();
    }

    public static ByteArrayInputStream exportToExcel(List<AttendanceExportDTO> employees, List<LocalDate> allDates) {
        try (Workbook workbook = new XSSFWorkbook(); ByteArrayOutputStream out = new ByteArrayOutputStream()) {
            Sheet sheet = workbook.createSheet("Attendance");

            // ==== STYLES ====
            Font whiteBoldFont = workbook.createFont();
            whiteBoldFont.setBold(true);
            whiteBoldFont.setColor(IndexedColors.WHITE.getIndex());
            whiteBoldFont.setFontHeightInPoints((short) 10); // NEW

            Font boldFont = workbook.createFont();
            boldFont.setBold(true);
            boldFont.setFontHeightInPoints((short) 10); // NEW

            Font italicBoldFont = workbook.createFont();
            italicBoldFont.setBold(true);
            italicBoldFont.setItalic(true);
            italicBoldFont.setFontHeightInPoints((short) 10); // NEW

            Font code = workbook.createFont();
            code.setBold(false);
            code.setFontHeightInPoints((short) 10); // NEW
            
            CellStyle headerStyle1 = workbook.createCellStyle();
            headerStyle1.setAlignment(HorizontalAlignment.CENTER);
            CellStyle codeStyle = workbook.createCellStyle();
            codeStyle.cloneStyleFrom(headerStyle1);
            codeStyle.setFont(code);
            
            Font code1 = workbook.createFont();
            code1.setBold(false);
            code1.setFontHeightInPoints((short) 7); // NEW
            
            CellStyle headerStyle11 = workbook.createCellStyle();
            headerStyle11.setAlignment(HorizontalAlignment.RIGHT);
            CellStyle codeStyle1 = workbook.createCellStyle();
            codeStyle1.cloneStyleFrom(headerStyle11);
            codeStyle1.setFont(code1);
            codeStyle1.setBorderBottom(BorderStyle.MEDIUM);
            codeStyle1.setBorderTop(BorderStyle.MEDIUM);
            codeStyle1.setBorderLeft(BorderStyle.MEDIUM);
            codeStyle1.setBorderRight(BorderStyle.MEDIUM);
            
            
            

            CellStyle headerStyle = workbook.createCellStyle();
            headerStyle.setFillForegroundColor(IndexedColors.DARK_BLUE.getIndex());
            headerStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
            headerStyle.setAlignment(HorizontalAlignment.CENTER);
            headerStyle.setVerticalAlignment(VerticalAlignment.CENTER);
            headerStyle.setFont(whiteBoldFont);
            headerStyle.setBorderBottom(BorderStyle.MEDIUM);
            headerStyle.setBorderTop(BorderStyle.MEDIUM);
            headerStyle.setBorderLeft(BorderStyle.MEDIUM);
            headerStyle.setBorderRight(BorderStyle.MEDIUM);

            CellStyle subHeaderStyle = workbook.createCellStyle();
            subHeaderStyle.cloneStyleFrom(headerStyle);
            subHeaderStyle.setFont(whiteBoldFont);

            CellStyle sundayHeaderStyle = workbook.createCellStyle();
            sundayHeaderStyle.cloneStyleFrom(headerStyle);
            sundayHeaderStyle.setFillForegroundColor(IndexedColors.RED.getIndex());

            CellStyle absentStyle = workbook.createCellStyle();
            absentStyle.setFillForegroundColor(IndexedColors.ORANGE.getIndex());
            absentStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
            absentStyle.setFont(italicBoldFont);
            absentStyle.setAlignment(HorizontalAlignment.CENTER);
            absentStyle.setBorderBottom(BorderStyle.DASH_DOT_DOT);
            absentStyle.setBorderTop(BorderStyle.DASH_DOT_DOT);
            absentStyle.setBorderLeft(BorderStyle.DASH_DOT_DOT);
            absentStyle.setBorderRight(BorderStyle.DASH_DOT_DOT);
            
            
            CellStyle leaveStyle = workbook.createCellStyle();
            leaveStyle.setFillForegroundColor(IndexedColors.YELLOW.getIndex());
            leaveStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
            leaveStyle.setFont(italicBoldFont);
            leaveStyle.setAlignment(HorizontalAlignment.CENTER);

            CellStyle centerBoldStyle = workbook.createCellStyle();
            centerBoldStyle.setAlignment(HorizontalAlignment.CENTER);
            centerBoldStyle.setFont(boldFont);

            CellStyle decimalStyle = workbook.createCellStyle();
            decimalStyle.setDataFormat(workbook.createDataFormat().getFormat("0.00"));

            // ==== HEADER ROWS ====
            Row headerRow1 = sheet.createRow(0);
            Row headerRow2 = sheet.createRow(1);

            sheet.setDefaultColumnWidth(15);

            // Static columns
            headerRow1.createCell(0).setCellValue("Employee Code");
            headerRow1.createCell(1).setCellValue("Employee Name");
            headerRow1.getCell(0).setCellStyle(headerStyle);
            headerRow1.getCell(1).setCellStyle(headerStyle);
            sheet.addMergedRegion(new CellRangeAddress(0, 1, 0, 0));
            sheet.addMergedRegion(new CellRangeAddress(0, 1, 1, 1));

            int col = 2;
            for (LocalDate date : allDates) {
                String baseHeader = date.format(DateTimeFormatter.ofPattern("dd-MMM (EEE)", Locale.ENGLISH));
                boolean isSunday = date.getDayOfWeek().getValue() == 7;

                // Date header (merged)
                Cell cell = headerRow1.createCell(col);
                cell.setCellValue(baseHeader);
                cell.setCellStyle(isSunday ? sundayHeaderStyle : headerStyle);
                sheet.addMergedRegion(new CellRangeAddress(0, 0, col, col + 3));

                // Sub-headers: IN, OUT, HOURS, OT
                String[] subHeaders = {"IN", "OUT", "Hours", "OT"};
                for (int i = 0; i < 4; i++) {
                    Cell subCell = headerRow2.createCell(col + i);
                    subCell.setCellValue(subHeaders[i]);
                    subCell.setCellStyle(isSunday ? sundayHeaderStyle : subHeaderStyle);
                }

                col += 4;
            }

            // ==== DATA ROWS ====
            int rowIdx = 2;
            for (AttendanceExportDTO emp : employees) {
                Row row = sheet.createRow(rowIdx++);
                row.createCell(0).setCellValue(emp.getEmpCode());
                row.createCell(1).setCellValue(emp.getEmployeeName());

                col = 2;
                Map<LocalDate, AttendanceDayDTO> daily = emp.getDailyAttendanceMap();
                if (daily == null) daily = new HashMap<>();

                for (LocalDate date : allDates) {
                    AttendanceDayDTO day = daily.get(date);

                    if (day == null) {
                        // ABSENT: merge 4 cells
                        Cell cell = row.createCell(col);
                        cell.setCellValue("Absent");
                        cell.setCellStyle(absentStyle);
                        sheet.addMergedRegion(new CellRangeAddress(row.getRowNum(), row.getRowNum(), col, col + 3));
                        col += 4;
                        continue;
                    }

                    if (day.getLeaveType() != null && !day.getLeaveType().isBlank()) {
                        Cell cell = row.createCell(col);
                        cell.setCellValue("Leave (" + day.getLeaveType() + ")");
                        cell.setCellStyle(leaveStyle);
                        sheet.addMergedRegion(new CellRangeAddress(row.getRowNum(), row.getRowNum(), col, col + 3));
                        col += 4;
                        continue;
                    }

                    // IN Time
                    Cell in = row.createCell(col++);
                    in.setCellValue(day.getInTime() != null ? day.getInTime().substring(11) : "-"); in.setCellStyle(headerStyle11);
                    if ("-".equals(in.getStringCellValue())) in.setCellStyle(centerBoldStyle); 

                    // OUT Time
                    Cell out1 = row.createCell(col++);
                    out1.setCellValue(day.getOutTime() != null ? day.getOutTime().substring(11) : "-");out1.setCellStyle(headerStyle11);
                    if ("-".equals(out1.getStringCellValue())) out1.setCellStyle(centerBoldStyle);

                    // HOURS (worked)
                    Cell worked = row.createCell(col++);
                    if (day.getWorkedHours() != null) {
                        try {
                        	// Create numeric style with 2 decimal places + " Hrs"
                        	CellStyle decimalStyle1 = workbook.createCellStyle();
                        	DataFormat format = workbook.createDataFormat();
                        	decimalStyle1.setDataFormat(format.getFormat("0.00\" Hrs\""));
                        	decimalStyle1.setAlignment(HorizontalAlignment.RIGHT);
                        	decimalStyle1.setFont(code);
                        	// Then set the numeric value (no string concatenation)
                        	double val = Double.parseDouble(day.getWorkedHours());
                        	worked.setCellValue(val);               // Set as double, not string
                        	worked.setCellStyle(decimalStyle1);      // Apply style

                        } catch (NumberFormatException e) {
                            worked.setCellValue("-");
                            worked.setCellStyle(centerBoldStyle);
                        }
                    } else {
                        worked.setCellValue("-");
                        worked.setCellStyle(centerBoldStyle);
                    }

                    // OT
                    Cell ot = row.createCell(col++);
                    ot.setCellValue(day.getOtHours() != null ? day.getOtHours()+ " Hrs" : "0");
                    ot.setCellStyle(headerStyle11);    ;
                }
            }

            // Autosize all
         // Fixed width settings
            sheet.setColumnWidth(0, 30 * 256); // Employee Code
            sheet.setColumnWidth(1, 40 * 256); // Employee Name

            int colIndex = 2;
            for (int i = 0; i < allDates.size(); i++) {
                // Each date spans 4 columns: IN, OUT, Hours, OT
                for (int j = 0; j < 4; j++) {
                    sheet.setColumnWidth(colIndex++, 12 * 256); // Set fixed width
                }
            }


            workbook.write(out);
            return new ByteArrayInputStream(out.toByteArray());
        } catch (Exception e) {
            throw new RuntimeException("Failed to export Excel: " + e.getMessage(), e);
        }
    }




    private static String optional(String val) {
        return val != null ? val : "-";
    }
}
