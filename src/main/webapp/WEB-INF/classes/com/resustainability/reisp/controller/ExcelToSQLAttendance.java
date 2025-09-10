package com.resustainability.reisp.controller;

import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.FileInputStream;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.Calendar;

public class ExcelToSQLAttendance {

    private static String serialDateToString(double serialDate) {
        Calendar calendar = Calendar.getInstance();
        calendar.set(1899, Calendar.DECEMBER, 30);
        calendar.add(Calendar.DAY_OF_YEAR, (int) serialDate);
        return new SimpleDateFormat("yyyy-MM-dd").format(calendar.getTime());
    }

    private static int[] parseWorkHours(String input) {
        try {
            if (input == null || input.trim().isEmpty()) return new int[]{0, 0};
            input = input.trim();
            if (input.contains(" ")) {
                String[] parts = input.split(" ");
                return new int[]{Integer.parseInt(parts[0]), Integer.parseInt(parts[1])};
            } else if (input.contains(".")) {
                double value = Double.parseDouble(input);
                int hours = (int) value;
                int minutes = (int) Math.round((value - hours) * 60);
                return new int[]{hours, minutes};
            } else {
                int hours = Integer.parseInt(input);
                return new int[]{hours, 0};
            }
        } catch (Exception e) {
            return new int[]{0, 0};
        }
    }

    private static String getStringCellValue(Cell cell, FormulaEvaluator evaluator) {
        if (cell == null) return "";
        CellType type = cell.getCellType();
        if (type == CellType.FORMULA) {
            type = evaluator.evaluateFormulaCell(cell);
        }
        switch (type) {
            case NUMERIC:
                if (DateUtil.isCellDateFormatted(cell)) {
                    return new SimpleDateFormat("HH:mm").format(cell.getDateCellValue());
                } else {
                    return String.valueOf(cell.getNumericCellValue());
                }
            case STRING:
                return cell.getStringCellValue().trim();
            case BOOLEAN:
                return Boolean.toString(cell.getBooleanCellValue());
            default:
                return "";
        }
    }

    public static void main(String[] args) {
        String url = "jdbc:sqlserver://10.125.145.217:1433;databaseName=INOPSETPDB;encrypt=false";
        String user = "appuser";
        String password = "Appuser@123$";
        String excelFilePath = "D:/git/05 May_ 25_OT.xlsx";

        String insertQuery = "INSERT INTO [INOPSETPDB].[dbo].[att_attendanceRe] " +
                "(emp_code, employee_name, position_name, area_name, site_name, work_date, " +
                "day_start, day_end, shift_type, total_working_hours, total_hours, total_minutes, " +
                "overtime_hours, overtime_minutes, attendance_status, is_holiday, holiday_reason, " +
                "is_regularised, action_by, regularise_reason, is_leave, leave_reason, final_OT) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (
            Connection conn = DriverManager.getConnection(url, user, password);
            FileInputStream fis = new FileInputStream(excelFilePath);
            Workbook workbook = new XSSFWorkbook(fis)
        ) {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            conn.setAutoCommit(false);
            FormulaEvaluator evaluator = workbook.getCreationHelper().createFormulaEvaluator();
            Sheet sheet = workbook.getSheetAt(0);

            for (int rowIndex = 1; rowIndex <= sheet.getLastRowNum(); rowIndex++) {
                Row row = sheet.getRow(rowIndex);
                if (row == null) continue;

                Cell empCodeCell = row.getCell(1);
                Cell empNameCell = row.getCell(2);
                if (empCodeCell == null || empNameCell == null) continue;

                String empCode = empCodeCell.getCellType() == CellType.NUMERIC
                        ? String.valueOf((long) empCodeCell.getNumericCellValue())
                        : empCodeCell.getStringCellValue().trim();
                String empName = empNameCell.getStringCellValue().trim();
                if (empCode.isEmpty() || empName.isEmpty()) continue;

                String designation = "BMW-MEML-" + row.getCell(3).getStringCellValue();
                String area = "BMW-MEML-HYDERABAD";
                String site = "BMW-MEML-HYDERABAD";

                for (int day = 1; day <= 31; day++) {
                    int colBase = 5 + (day - 1) * 4;
                    if (colBase + 3 >= row.getLastCellNum()) break;

                    Cell inTimeCell = row.getCell(colBase);
                    Cell outTimeCell = row.getCell(colBase + 1);
                    Cell workHrsCell = row.getCell(colBase + 2);
                    Cell otCell = row.getCell(colBase + 3);

                    if (inTimeCell == null || outTimeCell == null || workHrsCell == null) continue;

                    String inTime = getStringCellValue(inTimeCell, evaluator);
                    String outTime = getStringCellValue(outTimeCell, evaluator);
                    String workHrs = getStringCellValue(workHrsCell, evaluator);
                    String otTime = getStringCellValue(otCell, evaluator);

                    String workDate = serialDateToString(45773 + (day - 1)); // May 1 = 45773

                    int[] wh = parseWorkHours(workHrs);
                    int[] ot = parseWorkHours(otTime);

                    String totalWorkTime = String.format("%02d:%02d:00", wh[0], wh[1]);
                    String dayStart = inTime;
                    String dayEnd = outTime;

                    String shiftType;
                    try {
                        String[] inParts = inTime.split(":");
                        int hour = Integer.parseInt(inParts[0]);
                        int minute = Integer.parseInt(inParts[1]);
                        int totalMinutes = hour * 60 + minute;

                        if (totalMinutes >= 225 && totalMinutes < 525) shiftType = "Shift A";
                        else if (totalMinutes >= 525 && totalMinutes < 765) shiftType = "General Shift";
                        else if (totalMinutes >= 765 && totalMinutes < 1275) shiftType = "Shift B";
                        else shiftType = "Shift C";
                    } catch (Exception e) {
                        shiftType = "Unknown";
                    }

                    String attendanceStatus = (ot[0] > 0 || ot[1] > 0) ? "Full Day with OT" : "Full Day";

                    // Holiday or Sunday logic
                    boolean isHoliday = false;
                    String holidayReason = null;
                    int finalOtMinutes = ot[0] * 60 + ot[1];

                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    Calendar cal = Calendar.getInstance();
                    cal.setTime(sdf.parse(workDate));

                    if (cal.get(Calendar.DAY_OF_WEEK) == Calendar.SUNDAY) {
                        isHoliday = true;
                        holidayReason = "Sunday";
                    }

                    try (PreparedStatement holidayStmt = conn.prepareStatement(
                            "SELECT alias FROM [INOPSETPDB].[dbo].[att_holiday] WHERE start_date = ?")) {
                        holidayStmt.setString(1, workDate);
                        ResultSet holidayRs = holidayStmt.executeQuery();
                        if (holidayRs.next()) {
                            isHoliday = true;
                            holidayReason = holidayRs.getString("alias");
                        }
                    }

                    if (isHoliday && (wh[0] > 0 || wh[1] > 0)) {
                        finalOtMinutes *= 2;
                    }

                    boolean exists;
                    try (PreparedStatement checkStmt = conn.prepareStatement(
                            "SELECT COUNT(*) FROM [INOPSETPDB].[dbo].[att_attendanceRe] WHERE emp_code = ? AND work_date = ?")) {
                        checkStmt.setString(1, empCode);
                        checkStmt.setString(2, workDate);
                        ResultSet rs = checkStmt.executeQuery();
                        exists = rs.next() && rs.getInt(1) > 0;
                    }

                    if (exists) {
                        String updateQuery = "UPDATE [INOPSETPDB].[dbo].[att_attendanceRe] SET " +
                                "employee_name=?, position_name=?, area_name=?, site_name=?, " +
                                "day_start=?, day_end=?, shift_type=?, total_working_hours=?, " +
                                "total_hours=?, total_minutes=?, overtime_hours=?, overtime_minutes=?, " +
                                "attendance_status=?, is_holiday=?, holiday_reason=?, is_regularised=?, " +
                                "action_by=?, regularise_reason=?, is_leave=?, leave_reason=?, final_OT=? " +
                                "WHERE emp_code=? AND work_date=?";
                        try (PreparedStatement updateStmt = conn.prepareStatement(updateQuery)) {
                            updateStmt.setString(1, empName);
                            updateStmt.setString(2, designation);
                            updateStmt.setString(3, area);
                            updateStmt.setString(4, site);
                            updateStmt.setString(5, dayStart);
                            updateStmt.setString(6, dayEnd);
                            updateStmt.setString(7, shiftType);
                            updateStmt.setString(8, totalWorkTime);
                            updateStmt.setInt(9, wh[0]);
                            updateStmt.setInt(10, wh[1]);
                            updateStmt.setInt(11, ot[0]);
                            updateStmt.setInt(12, ot[1]);
                            updateStmt.setString(13, attendanceStatus);
                            updateStmt.setInt(14, isHoliday ? 1 : 0);
                            updateStmt.setString(15, holidayReason);
                            updateStmt.setNull(16, Types.BIT);
                            updateStmt.setNull(17, Types.VARCHAR);
                            updateStmt.setNull(18, Types.VARCHAR);
                            updateStmt.setNull(19, Types.BIT);
                            updateStmt.setNull(20, Types.VARCHAR);
                            int finalOt = ((wh[0] * 60) + wh[1]) * ((isHoliday) ? 2 : 1);
                            if(finalOt > 0) {
                            	finalOt = finalOt / 60;
                            }
                            updateStmt.setInt(21, finalOt );
                            updateStmt.setString(22, empCode);
                            updateStmt.setString(23, workDate);
                            updateStmt.executeUpdate();
                        }
                    } else {
                        try (PreparedStatement pstmt = conn.prepareStatement(insertQuery)) {
                            pstmt.setString(1, empCode);
                            pstmt.setString(2, empName);
                            pstmt.setString(3, designation);
                            pstmt.setString(4, area);
                            pstmt.setString(5, site);
                            pstmt.setString(6, workDate);
                            pstmt.setString(7, dayStart);
                            pstmt.setString(8, dayEnd);
                            pstmt.setString(9, shiftType);
                            pstmt.setString(10, totalWorkTime);
                            pstmt.setInt(11, wh[0]);
                            pstmt.setInt(12, wh[1]);
                            pstmt.setInt(13, ot[0]);
                            pstmt.setInt(14, ot[1]);
                            pstmt.setString(15, attendanceStatus);
                            pstmt.setInt(16, isHoliday ? 1 : 0);
                            pstmt.setString(17, holidayReason);
                            pstmt.setNull(18, Types.BIT);
                            pstmt.setNull(19, Types.VARCHAR);
                            pstmt.setNull(20, Types.VARCHAR);
                            pstmt.setNull(21, Types.BIT);
                            pstmt.setNull(22, Types.VARCHAR);
                            pstmt.setInt(23, finalOtMinutes);
                            pstmt.executeUpdate();
                        }
                    }
                }
            }

            conn.commit();
            System.out.println("Data inserted/updated successfully.");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
