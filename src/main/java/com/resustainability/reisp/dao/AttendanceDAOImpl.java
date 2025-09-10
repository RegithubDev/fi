package com.resustainability.reisp.dao;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.stream.Collectors;

import javax.sql.DataSource;
import javax.ws.rs.QueryParam;

import com.resustainability.reisp.common.DateParser;
import com.resustainability.reisp.dto.AttendanceDuration;
import com.resustainability.reisp.dto.EmployeeMeta;

import com.resustainability.reisp.dto.entity.AttendanceRe;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BatchPreparedStatementSetter;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.resustainability.reisp.model.AttendanceDto;
import com.resustainability.reisp.model.AttendanceExportDTO;
import com.resustainability.reisp.model.AttendanceLeaveDTO;
import com.resustainability.reisp.model.AttendanceRecord;
import com.resustainability.reisp.model.AttendanceRegularizationDTO;
import com.resustainability.reisp.model.EmployeeDto;

import org.springframework.stereotype.Repository;
@Repository
public class AttendanceDAOImpl  implements AttendanceDAO {
	@Autowired
	DataSource dataSource;
	
    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public List<AttendanceDto> fetchPaginatedAttendance(String empCode, String fromDate, String toDate, int start, int length, String searchValue) {
        try{
    	
    	StringBuilder sql = new StringBuilder();
        sql.append("WITH Filtered AS ( ");
        sql.append("  SELECT *, ");
        sql.append("  ROW_NUMBER() OVER (ORDER BY work_date DESC) AS rn ");
        sql.append("  FROM [INOPSETPDB].[dbo].[att_attendanceRe] ");
        sql.append("  WHERE CAST(work_date AS DATE) BETWEEN ? AND ? ");

        List<Object> params = new ArrayList<>();
        params.add(fromDate);
        params.add(toDate);

        if (empCode != null && !empCode.isEmpty()) {
            sql.append(" AND emp_code = ? ");
            params.add(empCode);
        }

        sql.append(" AND ( ");
        sql.append("     UPPER([position_name]) LIKE '%PICKER%' ");
        sql.append("     OR UPPER([position_name]) LIKE '%DRIVER%' ");
        sql.append("     OR UPPER([position_name]) LIKE '%WELDER%' ");
        sql.append("     OR UPPER([position_name]) LIKE '%GARDENER%' ");
        sql.append("     OR UPPER([position_name]) LIKE '%WORKER%' ");
        sql.append("     OR UPPER([position_name]) LIKE '%OFFICE ASSISTANT%' ");
      //  sql.append("     OR UPPER([position_name]) LIKE '%MARKETING%' ");
        sql.append("     OR UPPER([position_name]) LIKE '%VEHCLE SUPERVISOUR%' ");
        sql.append(" )");

        if (searchValue != null && !searchValue.trim().isEmpty()) {
            sql.append(" AND ( ");
            sql.append("     emp_code LIKE ? OR ");
            sql.append("     employee_name LIKE ? OR ");
            sql.append("     attendance_status LIKE ? ");
            sql.append(" )");
            params.add("%" + searchValue + "%");
            params.add("%" + searchValue + "%");
            params.add("%" + searchValue + "%");
        }

        sql.append(") ");
        sql.append("SELECT * FROM Filtered WHERE rn BETWEEN ? AND ?");

        params.add(start + 1);
        params.add(start + length);

        return jdbcTemplate.query(sql.toString(), params.toArray(), (rs, rowNum) -> {
            AttendanceDto dto = new AttendanceDto();
            dto.setSl_no(rs.getLong("sl_no"));
            dto.setWorkDate(rs.getString("work_date"));
            dto.setEmpCode(rs.getString("emp_code"));
            dto.setEmployeeName(rs.getString("employee_name"));
            dto.setCheckIn(rs.getString("day_start"));
            dto.setCheckOut(rs.getString("day_end"));
            dto.setShiftType(rs.getString("shift_type"));
            dto.setTotalHours(rs.getInt("total_hours") + ":" + rs.getInt("total_minutes"));
            dto.setTotalWorkingHours(rs.getString("total_working_hours"));
            dto.setAttendanceStatus(rs.getString("attendance_status"));
            dto.setHolidayReason(rs.getString("holiday_reason"));
            dto.setIsHoliday(rs.getInt("is_holiday"));
            dto.setIs_leave(rs.getString("is_leave"));
            dto.setLeave_reason(rs.getString("leave_reason"));
            dto.setOvertime(rs.getInt("overtime_hours") + ":" + rs.getInt("overtime_minutes"));
            dto.setFinalOT(rs.getString("final_OT"));
            dto.setRemarks(rs.getString("remarks"));
            dto.setIsRegularised(rs.getString("is_regularised"));
            dto.setLeaveDuration(rs.getString("leave_duration"));
            dto.setLeaveHalfSlot(rs.getString("leave_half_slot"));
            return dto;
        });
        
        }catch(Exception e) {
        	e.printStackTrace();
        }
		return null;
    }


    @Override
    public int fetchTotalAttendanceCount(String empCode, String fromDate, String toDate, String searchValue) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM att_attendanceRe WHERE CAST(work_date AS DATE) BETWEEN ? AND ? ");
        List<Object> params = new ArrayList<>();
        params.add(fromDate);
        params.add(toDate);
        if (empCode != null && !empCode.isEmpty()) {
            sql.append(" AND emp_code = ? ");
          
            params.add(empCode);
           
        }
        if (searchValue != null && !searchValue.trim().isEmpty()) {
            sql.append(" AND ( ");
            sql.append("     emp_code LIKE ? OR ");
            sql.append("     employee_name LIKE ? OR ");
            sql.append("     attendance_status LIKE ? ");
            sql.append(" )");
        }
        if (searchValue != null && !searchValue.trim().isEmpty()) {
            params.add("%" + searchValue + "%");
            params.add("%" + searchValue + "%");
            params.add("%" + searchValue + "%");
        }
        return jdbcTemplate.queryForObject(sql.toString(), params.toArray(), Integer.class);
    }

    @Override
    public List<EmployeeDto> fetchDistinctEmployees() {
        String sql = "SELECT DISTINCT emp_code, first_name FROM personnel_employee ORDER BY first_name";
        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            EmployeeDto emp = new EmployeeDto();
            emp.setEmpCode(rs.getString("emp_code"));
            emp.setFirstName(rs.getString("first_name"));
            return emp;
        });
    }
    @Override
    public void executeAttendanceReloadInsert(String fromDate, String toDate, String areaAlias) throws SQLException {
        try (Connection con = dataSource.getConnection()) {
            con.setAutoCommit(false); // Disable auto-commit for transaction control

            // Optional: Create indexes for performance
            createIndexesIfNeeded(con);

            // 1. First execute the complex query to get attendance data
            List<AttendanceRecord> records = fetchAttendanceRecords(con, fromDate, toDate, areaAlias);
            
            // 2. Then perform the MERGE operation in batches
            if (!records.isEmpty()) {
                mergeAttendanceRecords(con, records);
            }
            
            con.commit(); // Commit the transaction
        } catch (SQLException e) {
            throw new SQLException("Failed to process attendance records: " + e.getMessage(), e);
        }
    }

    private void createIndexesIfNeeded(Connection con) throws SQLException {
        try (Statement stmt = con.createStatement()) {
            try {
                stmt.execute("CREATE NONCLUSTERED INDEX IX_iclock_transaction_punch_time ON [INOPSETPDB].[dbo].[iclock_transaction] (punch_time);");
                stmt.execute("CREATE NONCLUSTERED INDEX IX_iclock_transaction_emp_code ON [INOPSETPDB].[dbo].[iclock_transaction] (emp_code);");
            } catch (SQLException e) {
                // Indexes might already exist - safe to ignore
            }
        }
    }

    private List<AttendanceRecord> fetchAttendanceRecords(Connection con, String fromDate, String toDate, String areaAlias) throws SQLException {
        StringBuilder query = buildAttendanceQuery();
        List<AttendanceRecord> records = new ArrayList<>();
        
        try (PreparedStatement stmt = con.prepareStatement(query.toString())) {
            stmt.setString(1, fromDate);
            stmt.setString(2, toDate);
            stmt.setString(3, areaAlias);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    AttendanceRecord record = new AttendanceRecord();
                    record.setEmpCode(rs.getString("emp_code"));
                    record.setEmployeeName(rs.getString("first_name"));
                    record.setPositionName(rs.getString("position_name"));
                    record.setAreaName(rs.getString("area_name"));
                    record.setSiteName(rs.getString("site_name"));
                    record.setWorkDate(rs.getString("work_date"));
                    record.setDayStart(rs.getString("check_in"));
                    record.setDayEnd(rs.getString("check_out"));
                    record.setTotalHours(rs.getInt("total_hours"));
                    record.setTotalMinutes(rs.getInt("total_minutes"));
                    record.setOvertimeHours(rs.getInt("overtime_hours"));
                    record.setOvertimeMinutes(rs.getInt("overtime_minutes"));
                    record.setAttendanceStatus(rs.getString("attendance_status"));
                    record.setHoliday(rs.getBoolean("is_holiday"));
                    record.setHolidayReason(rs.getString("holiday_reason"));
                    
                    records.add(record);
                }
            }
        }
        
        return records;
    }

    private void mergeAttendanceRecords(Connection con, List<AttendanceRecord> records) throws SQLException {
        final int BATCH_SIZE = 100;
        StringBuilder mergeQuery = buildMergeQuery();
        
        try (PreparedStatement stmt = con.prepareStatement(mergeQuery.toString())) {
            int count = 0;
            
            for (AttendanceRecord record : records) {
                setMergeParameters(stmt, record);
                stmt.addBatch();
                
                if (++count % BATCH_SIZE == 0) {
                    stmt.executeBatch();
                }
            }
            
            if (count % BATCH_SIZE != 0) {
                stmt.executeBatch();
            }
        }
    }

    private StringBuilder buildAttendanceQuery() throws SQLException {
    	Connection con = dataSource.getConnection();
    	 try (Statement indexStmt = con.createStatement()) {
             indexStmt.execute("CREATE NONCLUSTERED INDEX IX_iclock_transaction_punch_time ON iclock_transaction (punch_time);");
             indexStmt.execute("CREATE NONCLUSTERED INDEX IX_iclock_transaction_emp_code ON iclock_transaction (emp_code);");
         } catch (SQLException e) {
             // Index might already exist – safe to ignore
         }

    	 StringBuilder qry = new StringBuilder();

    	 qry.append("DECLARE @fromDate DATE = ?;\n");
    	 qry.append("DECLARE @toDate DATE = ?;\n");
    	 qry.append("DECLARE @areaAlias VARCHAR(100) = ?;\n");
    	 qry.append("\n");
    	 qry.append("WITH Calendar AS (\n");
    	 qry.append("    SELECT CAST(DATEADD(DAY, -number, CAST(@toDate AS DATE)) AS DATE) AS work_date\n");
    	 qry.append("    FROM master..spt_values\n");
    	 qry.append("    WHERE type = 'P' AND number BETWEEN 0 AND DATEDIFF(DAY, @fromDate, @toDate)\n");
    	 qry.append("),\n");
    	 qry.append("\n");
    	 qry.append("RawPunches AS (\n");
    	 qry.append("    SELECT \n");
    	 qry.append("        it.emp_code,\n");
    	 qry.append("        CAST(it.punch_time AS DATE) AS work_date,\n");
    	 qry.append("        it.punch_time,\n");
    	 qry.append("        it.punch_state,\n");
    	 qry.append("        it.emp_id,\n");
    	 qry.append("        pe.first_name,\n");
    	 qry.append("        pa.area_name,\n");
    	 qry.append("        pee.position_name,\n");
    	 qry.append("        ssd.site_name\n");
    	 qry.append("    FROM [INOPSETPDB].[dbo].[iclock_transaction] it\n");
    	 qry.append("    INNER JOIN [INOPSETPDB].[dbo].[personnel_employee] pe ON it.emp_id = pe.id\n");
    	 qry.append("    LEFT JOIN [INOPSETPDB].[dbo].[personnel_area] pa ON UPPER(it.area_alias) = UPPER(pa.area_code)\n");
    	 qry.append("    LEFT JOIN [INOPSETPDB].[dbo].[personnel_position] pee ON pe.position_id = pee.id\n");
    	 qry.append("    LEFT JOIN [INOPSETPDB].[dbo].[site_shift_details_re] ssd ON UPPER(it.area_alias) = UPPER(ssd.site_name)\n");
    	 qry.append("    WHERE \n");
    	 qry.append("        it.punch_time >= @fromDate\n");
    	 qry.append("        AND it.punch_time <= @toDate\n");
    	 qry.append("        AND (@areaAlias IS NULL OR UPPER(it.area_alias) = UPPER(@areaAlias))\n");
    	 qry.append("),\n");
    	 qry.append("\n");
    	 qry.append("ManualPunches AS (\n");
    	 qry.append("    SELECT \n");
    	 qry.append("        ml.employee_id,\n");
    	 qry.append("        CAST(ml.punch_time AS DATE) AS work_date,\n");
    	 qry.append("        ml.punch_time,\n");
    	 qry.append("        ml.punch_state\n");
    	 qry.append("    FROM [INOPSETPDB].[dbo].[att_manuallog] ml\n");
    	 qry.append("    WHERE ml.punch_time >= @fromDate\n");
    	 qry.append("      AND ml.punch_time <= @toDate\n");
    	 qry.append("),\n");
    	 qry.append("\n");
    	 qry.append("FirstPunch AS (\n");
    	 qry.append("    SELECT emp_code, work_date, MIN(punch_time) AS check_in\n");
    	 qry.append("    FROM RawPunches\n");
    	 qry.append("    WHERE punch_state = 0\n");
    	 qry.append("    GROUP BY emp_code, work_date\n");
    	 qry.append("\n");
    	 qry.append("    UNION\n");
    	 qry.append("\n");
    	 qry.append("    SELECT pe.emp_code, mfp.work_date, MIN(mfp.punch_time) AS check_in\n");
    	 qry.append("    FROM ManualPunches mfp\n");
    	 qry.append("    JOIN [INOPSETPDB].[dbo].[personnel_employee] pe ON mfp.employee_id = pe.id\n");
    	 qry.append("    WHERE mfp.punch_state = 0\n");
    	 qry.append("    GROUP BY pe.emp_code, mfp.work_date\n");
    	 qry.append("),\n");
    	 qry.append("\n");
    	 qry.append("SecondPunch AS (\n");
    	 qry.append("    SELECT emp_code, work_date, MIN(punch_time) AS check_out\n");
    	 qry.append("    FROM RawPunches\n");
    	 qry.append("    WHERE punch_state = 1\n");
    	 qry.append("    GROUP BY emp_code, work_date\n");
    	 qry.append("\n");
    	 qry.append("    UNION\n");
    	 qry.append("\n");
    	 qry.append("    SELECT pe.emp_code, msp.work_date, MIN(msp.punch_time) AS check_out\n");
    	 qry.append("    FROM ManualPunches msp\n");
    	 qry.append("    JOIN [INOPSETPDB].[dbo].[personnel_employee] pe ON msp.employee_id = pe.id\n");
    	 qry.append("    WHERE msp.punch_state = 1\n");
    	 qry.append("    GROUP BY pe.emp_code, msp.work_date\n");
    	 qry.append("),\n");
    	 qry.append("\n");
    	 qry.append("ShiftDurations AS (\n");
    	 qry.append("    SELECT \n");
    	 qry.append("        fp.emp_code,\n");
    	 qry.append("        fp.work_date,\n");
    	 qry.append("        fp.check_in,\n");
    	 qry.append("        MIN(sp.check_out) AS check_out,\n");
    	 qry.append("        CASE \n");
    	 qry.append("            WHEN CONVERT(TIME, fp.check_in) >= '05:40:00' AND CONVERT(TIME, fp.check_in) < '13:40:00' THEN 'A' -- Morning shift (06:00 AM - 02:00 PM, grace from 05:40 AM)\n");
    	 qry.append("            WHEN CONVERT(TIME, fp.check_in) >= '13:40:00' AND CONVERT(TIME, fp.check_in) < '21:40:00' THEN 'B' -- Afternoon shift (02:00 PM - 10:00 PM, grace from 13:40)\n");
    	 qry.append("            WHEN CONVERT(TIME, fp.check_in) >= '21:40:00' OR CONVERT(TIME, fp.check_in) < '05:40:00' THEN 'C' -- Night shift (10:00 PM - 06:00 AM, grace from 21:40)\n");
    	 qry.append("            ELSE 'G' -- General shift (09:00 AM - 06:00 PM) or fallback\n");
    	 qry.append("        END AS shift_type\n");
    	 qry.append("    FROM FirstPunch fp\n");
    	 qry.append("    LEFT JOIN SecondPunch sp \n");
    	 qry.append("        ON fp.emp_code = sp.emp_code \n");
    	 qry.append("        AND sp.check_out > fp.check_in \n");
    	 qry.append("        AND sp.check_out <= DATEADD(HOUR, 24, fp.check_in)\n");
    	 qry.append("    GROUP BY fp.emp_code, fp.work_date, fp.check_in\n");
    	 qry.append("),\n");
    	 qry.append("\n");
    	 qry.append("EmployeeData AS (\n");
    	 qry.append("    SELECT \n");
    	 qry.append("        emp_id,\n");
    	 qry.append("        emp_code,\n");
    	 qry.append("        first_name,\n");
    	 qry.append("        area_name,\n");
    	 qry.append("        position_name,\n");
    	 qry.append("        site_name,\n");
    	 qry.append("        work_date\n");
    	 qry.append("    FROM (\n");
    	 qry.append("        SELECT \n");
    	 qry.append("            it.emp_id,\n");
    	 qry.append("            it.emp_code,\n");
    	 qry.append("            pe.first_name,\n");
    	 qry.append("            pa.area_name,\n");
    	 qry.append("            pp.position_name,\n");
    	 qry.append("            ssd.site_name,\n");
    	 qry.append("            CAST(it.punch_time AS DATE) AS work_date,\n");
    	 qry.append("            ROW_NUMBER() OVER (\n");
    	 qry.append("                PARTITION BY it.emp_id, CAST(it.punch_time AS DATE)\n");
    	 qry.append("                ORDER BY it.punch_time DESC\n");
    	 qry.append("            ) AS rn\n");
    	 qry.append("        FROM [INOPSETPDB].[dbo].[iclock_transaction] it\n");
    	 qry.append("        INNER JOIN [INOPSETPDB].[dbo].[personnel_employee] pe ON it.emp_id = pe.id\n");
    	 qry.append("        LEFT JOIN [INOPSETPDB].[dbo].[personnel_area] pa ON UPPER(it.area_alias) = UPPER(pa.area_code)\n");
    	 qry.append("        LEFT JOIN [INOPSETPDB].[dbo].[personnel_position] pp ON pe.position_id = pp.id\n");
    	 qry.append("        LEFT JOIN [INOPSETPDB].[dbo].[site_shift_details_re] ssd ON UPPER(ssd.site_name) = UPPER(it.area_alias)\n");
    	 qry.append("        WHERE it.punch_time >= @fromDate\n");
    	 qry.append("            AND it.punch_time <= @toDate\n");
    	 qry.append("            AND (@areaAlias IS NULL OR UPPER(it.area_alias) = UPPER(@areaAlias))\n");
    	 qry.append("    ) x\n");
    	 qry.append("    WHERE x.rn = 1\n");
    	 qry.append("),\n");
    	 qry.append("\n");
    	 qry.append("HolidayData AS (\n");
    	 qry.append("    SELECT CAST(start_date AS DATE) AS holiday_date, alias AS holiday_reason\n");
    	 qry.append("    FROM [INOPSETPDB].[dbo].[att_holiday]\n");
    	 qry.append("),\n");
    	 qry.append("\n");
    	 qry.append("Combined AS (\n");
    	 qry.append("    SELECT \n");
    	 qry.append("        c.work_date,\n");
    	 qry.append("        ISNULL(sd.emp_code, '') AS emp_code,\n");
    	 qry.append("        ed.first_name,\n");
    	 qry.append("        ed.area_name,\n");
    	 qry.append("        ed.position_name,\n");
    	 qry.append("        ed.site_name,\n");
    	 qry.append("        sd.shift_type,\n");
    	 qry.append("        sd.check_in AS raw_in,\n");
    	 qry.append("        sd.check_out AS raw_out,\n");
    	 qry.append("        hd.holiday_reason\n");
    	 qry.append("    FROM Calendar c\n");
    	 qry.append("    LEFT JOIN ShiftDurations sd ON c.work_date = sd.work_date\n");
    	 qry.append("    LEFT JOIN EmployeeData ed ON ed.emp_code = sd.emp_code AND ed.work_date = c.work_date\n");
    	 qry.append("    LEFT JOIN HolidayData hd ON c.work_date = hd.holiday_date\n");
    	 qry.append("),\n");
    	 qry.append("\n");
    	 qry.append("FinalOutput AS (\n");
    	 qry.append("    SELECT\n");
    	 qry.append("        work_date,\n");
    	 qry.append("        emp_code,\n");
    	 qry.append("        first_name,\n");
    	 qry.append("        area_name,\n");
    	 qry.append("        position_name,\n");
    	 qry.append("        site_name,\n");
    	 qry.append("        shift_type,\n");
    	 qry.append("        FORMAT(raw_in, 'yyyy-MM-dd HH:mm') AS check_in,\n");
    	 qry.append("        FORMAT(raw_out, 'yyyy-MM-dd HH:mm') AS check_out,\n");
    	 qry.append("        CASE \n");
    	 qry.append("            WHEN raw_in IS NOT NULL AND raw_out IS NOT NULL AND raw_out > raw_in THEN DATEDIFF(SECOND, raw_in, raw_out)\n");
    	 qry.append("            ELSE 0\n");
    	 qry.append("        END AS total_seconds,\n");
    	 qry.append("        holiday_reason\n");
    	 qry.append("    FROM Combined\n");
    	 qry.append("),\n");
    	 qry.append("\n");
    	 qry.append("WithRemarks AS (\n");
    	 qry.append("    SELECT\n");
    	 qry.append("        f.work_date,\n");
    	 qry.append("        f.emp_code,\n");
    	 qry.append("        f.first_name,\n");
    	 qry.append("        f.area_name,\n");
    	 qry.append("        f.position_name,\n");
    	 qry.append("        f.site_name,\n");
    	 qry.append("        f.shift_type,\n");
    	 qry.append("        f.check_in,\n");
    	 qry.append("        f.check_out,\n");
    	 qry.append("        f.total_seconds / 3600 AS total_hours,\n");
    	 qry.append("        (f.total_seconds % 3600) / 60 AS total_minutes,\n");
    	 qry.append("        CASE \n");
    	 qry.append("            WHEN f.check_in IS NULL AND f.check_out IS NULL THEN 'Absent'\n");
    	 qry.append("            WHEN f.total_seconds <= 3600 AND f.work_date = CAST(GETDATE() AS DATE) THEN 'Present'\n");
    	 qry.append("            WHEN f.total_seconds <= 3600 THEN 'Missed OUT'\n");
    	 qry.append("            ELSE 'OK'\n");
    	 qry.append("        END AS attendance_status,\n");
    	 qry.append("        CASE \n");
    	 qry.append("            WHEN f.total_seconds > 28800 THEN (f.total_seconds - 28800) / 3600\n");
    	 qry.append("            ELSE 0\n");
    	 qry.append("        END AS overtime_hours,\n");
    	 qry.append("        CASE \n");
    	 qry.append("            WHEN f.total_seconds > 28800 THEN ((f.total_seconds - 28800) % 3600) / 60\n");
    	 qry.append("            ELSE 0\n");
    	 qry.append("        END AS overtime_minutes,\n");
    	 qry.append("        ISNULL(f.holiday_reason, '') AS holiday_reason,\n");
    	 qry.append("        CASE WHEN ISNULL(f.holiday_reason, '') <> '' THEN 1 ELSE 0 END AS is_holiday\n");
    	 qry.append("    FROM FinalOutput f\n");
    	 qry.append(")\n");
    	 qry.append("\n");
    	 qry.append("SELECT * FROM WithRemarks \n");
    	 qry.append("ORDER BY work_date DESC;\n");
         // MERGE to update or insert
       
        return qry;
    }

    private StringBuilder buildMergeQuery() {
        StringBuilder qry = new StringBuilder();

        qry.append("MERGE att_attendanceRe AS target\n");
        qry.append("USING (VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)) \n"); // 17 parameters
        qry.append("AS source (emp_code, employee_name, position_name, area_name, site_name, work_date, \n");
        qry.append("           day_start, day_end, shift_type, total_working_hours, total_hours, \n");
        qry.append("           total_minutes, overtime_hours, overtime_minutes, attendance_status, \n");
        qry.append("           is_holiday, holiday_reason)\n");
        
        // Join condition also ensures we do NOT match records that are already regularised
        qry.append("ON target.emp_code = source.emp_code \n");
        qry.append("   AND target.work_date = source.work_date \n");

        qry.append("WHEN MATCHED AND ISNULL(target.is_regularised, 0) != 1 THEN UPDATE SET\n");
        qry.append("    employee_name = source.employee_name,\n");
        qry.append("    position_name = source.position_name,\n");
        qry.append("    area_name = source.area_name,\n");
        qry.append("    site_name = source.site_name,\n");
        qry.append("    day_start = source.day_start,\n");
        qry.append("    day_end = source.day_end,\n");
        qry.append("    shift_type = source.shift_type,\n");
        qry.append("    total_working_hours = source.total_working_hours,\n");
        qry.append("    total_hours = source.total_hours,\n");
        qry.append("    total_minutes = source.total_minutes,\n");
        qry.append("    overtime_hours = source.overtime_hours,\n");
        qry.append("    overtime_minutes = source.overtime_minutes,\n");
        qry.append("    attendance_status = source.attendance_status,\n");
        qry.append("    is_holiday = source.is_holiday,\n");
        qry.append("    holiday_reason = source.holiday_reason\n");

        qry.append("WHEN NOT MATCHED BY TARGET THEN INSERT (\n");
        qry.append("    emp_code, employee_name, position_name, area_name, site_name, work_date,\n");
        qry.append("    day_start, day_end, shift_type, total_working_hours,\n");
        qry.append("    total_hours, total_minutes, overtime_hours, overtime_minutes,\n");
        qry.append("    attendance_status, is_holiday, holiday_reason)\n");
        qry.append("VALUES (\n");
        qry.append("    source.emp_code, source.employee_name, source.position_name, source.area_name, source.site_name, source.work_date,\n");
        qry.append("    source.day_start, source.day_end, source.shift_type, source.total_working_hours,\n");
        qry.append("    source.total_hours, source.total_minutes, source.overtime_hours, source.overtime_minutes,\n");
        qry.append("    source.attendance_status, source.is_holiday, source.holiday_reason\n");
        qry.append(");");

        return qry;
    }


    private void setMergeParameters(PreparedStatement stmt, AttendanceRecord record) throws SQLException {
        int paramIndex = 1;
        stmt.setString(paramIndex++, record.getEmpCode());
        stmt.setString(paramIndex++, record.getEmployeeName());
        stmt.setString(paramIndex++, record.getPositionName());
        stmt.setString(paramIndex++, record.getAreaName());
        stmt.setString(paramIndex++, record.getSiteName());
        stmt.setString(paramIndex++, record.getWorkDate());
        stmt.setString(paramIndex++, record.getDayStart());
        stmt.setString(paramIndex++, record.getDayEnd());

        // ✅ Fix: Add shift_type explicitly (default 'Regular')
        stmt.setString(paramIndex++, record.getShiftType());

        stmt.setBigDecimal(paramIndex++, BigDecimal.valueOf(
            record.getTotalHours() + record.getTotalMinutes() / 60.0));
        stmt.setInt(paramIndex++, record.getTotalHours());
        stmt.setInt(paramIndex++, record.getTotalMinutes());
        stmt.setInt(paramIndex++, record.getOvertimeHours());
        stmt.setInt(paramIndex++, record.getOvertimeMinutes());
        stmt.setString(paramIndex++, record.getAttendanceStatus());
        stmt.setBoolean(paramIndex++, record.isHoliday());
        stmt.setString(paramIndex++, record.getHolidayReason());
    }


    @Override
    public List<AttendanceDto> findMissedPunches( String empCode, 
    		Date fromDate, 
    		Date toDate, String areaAlias, 
            boolean onlyMissed) {
        List<AttendanceDto> results = new ArrayList<>();
        String sql = "SELECT a.emp_code, e.first_name, e.last_name, " +
                     "a.work_date, a.day_start, a.day_end, " +
                     "a.total_working_hours, a.attendance_status, a.holiday_reason " +
                     "FROM [INOPSETPDB].[dbo].[att_attendanceRe] a JOIN [INOPSETPDB].[dbo].[personnel_employee] e ON a.emp_code = e.emp_code " +
                     "WHERE (? IS NULL OR a.work_date >= ?) " +
                     "AND (? IS NULL OR a.work_date <= ?) " +
                     "AND (a.day_start IS NULL OR a.day_end IS NULL "
                     + "" +
                     "OR a.attendance_status = 'Absent' OR a.attendance_status = 'Missed OUT') "
                     + "and ( UPPER([position_name]) LIKE '%PICKER%'\r\n"
                     + "   OR UPPER([position_name]) LIKE '%DRIVER%'\r\n"
                     + "   OR UPPER([position_name]) LIKE '%WELDER%'\r\n"
                     + "   OR UPPER([position_name]) LIKE '%GARDENER%'\r\n"
                     + "   OR UPPER([position_name]) LIKE '%WORKER%'\r\n"
                     + "   OR UPPER([position_name]) LIKE '%OFFICE ASSISTANT%'\r\n"
                    // + "   OR UPPER([position_name]) LIKE '%MARKETING%'\r\n"
                     + "   OR UPPER([position_name]) LIKE '%VEHCLE SUPERVISOUR%'\r\n"
                     + ")";

        try (Connection conn = dataSource.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            // Set parameters
            stmt.setDate(1, fromDate);
            stmt.setDate(2, fromDate);
            stmt.setDate(3, toDate);
            stmt.setDate(4, toDate);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    AttendanceDto dto = new AttendanceDto();
                    dto.setEmpCode(rs.getString("emp_code"));
                    dto.setEmployeeName(rs.getString("first_name"));
                    dto.setWorkDate(rs.getString("work_date"));
                    dto.setCheckIn(rs.getString("day_start"));
                    dto.setCheckOut(rs.getString("day_end"));
                    dto.setTotalHours(rs.getString("total_working_hours"));
                    dto.setAttendanceStatus(rs.getString("attendance_status"));
                    dto.setHolidayReason(rs.getString("holiday_reason"));
                    
                    results.add(dto);
                }
            }
        } catch (SQLException e) {
        	e.printStackTrace();
            throw new RuntimeException("Error fetching missed punches", e);
        }
        return results;
    }


    @Override
    public Object regularizeAttendance(AttendanceRegularizationDTO data, String userId) {
        String updateSql = "UPDATE [INOPSETPDB].[dbo].[att_attendanceRe] " +
                "SET day_start = ?, " +
                "    day_end = ?, " +
                "    shift_type = ?, " +
                "    total_working_hours = ?, " +
                "    total_hours = ?, " +
                "    total_minutes = ?, " +
                "    overtime_hours = ?, " +
                "    overtime_minutes = ?, " +
                "    is_regularised = 1 ,remarks = 'Missed Punch Out' , action_by = ? ,attendance_status = 'ok (Regularized)' " +
                "WHERE emp_code = ? AND work_date = ?";

        try (Connection conn = dataSource.getConnection();
             PreparedStatement stmt = conn.prepareStatement(updateSql)) {

            String checkIn = data.getCheckIn().replace('T', ' ');
            String checkOut = data.getCheckOut().replace('T', ' ');

            // Parse datetime values
            LocalDateTime start = LocalDateTime.parse(checkIn, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));
            LocalDateTime end = LocalDateTime.parse(checkOut, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));

            if (end.isBefore(start)) {
                throw new IllegalArgumentException("Check-Out must be after Check-In.");
            }

            Duration duration = Duration.between(start, end);
            long totalSeconds = duration.getSeconds();
            int totalHours = (int) (totalSeconds / 3600);
            int totalMinutes = (int) ((totalSeconds % 3600) / 60);
            double totalWorkingHours = totalHours + (totalMinutes / 60.0);

            int overtimeHours = 0;
            int overtimeMinutes = 0;
            if (totalSeconds > 28800) { // > 8 hours
                long otSeconds = totalSeconds - 28800;
                overtimeHours = (int) (otSeconds / 3600);
                overtimeMinutes = (int) ((otSeconds % 3600) / 60);
            }

            // Detect shift
            String shiftType;
            LocalTime checkInTime = start.toLocalTime();
            if (checkInTime.isAfter(LocalTime.of(3, 44)) && checkInTime.isBefore(LocalTime.of(8, 45))) {
                shiftType = "Shift A";
            } else if (checkInTime.isBefore(LocalTime.of(12, 45))) {
                shiftType = "General Shift";
            } else if (checkInTime.isBefore(LocalTime.of(21, 15))) {
                shiftType = "Shift B";
            } else {
                shiftType = "Shift C";
            }

            // Set parameters
            stmt.setString(1, checkIn);
            stmt.setString(2, checkOut);
            stmt.setString(3, shiftType);
            stmt.setBigDecimal(4, BigDecimal.valueOf(totalWorkingHours));
            stmt.setInt(5, totalHours);
            stmt.setInt(6, totalMinutes);
            stmt.setInt(7, overtimeHours);
            stmt.setInt(8, overtimeMinutes);
            stmt.setString(9, userId);
            stmt.setString(10, data.getEmpCode());
            stmt.setDate(11, java.sql.Date.valueOf(data.getWorkDate())); // ensure this is yyyy-MM-dd

            int rows = stmt.executeUpdate();
            if (rows > 0) {
                return "Attendance regularized successfully.";
            } else {
                return "No attendance record found for the given employee and date.";
            }

        } catch (Exception e) {
            e.printStackTrace();
            return "Error during regularization: " + e.getMessage();
        }
    }


    @Override
    public Object applyLeave(AttendanceLeaveDTO dto, String userId) {
        // Step 1: Fetch employee details
        String fetchSql = """
            SELECT TOP 1 area_name, position_name, employee_name
            FROM att_attendanceRe
            WHERE emp_code = ?
            ORDER BY work_date DESC
        """;

        Map<String, Object> empInfo = jdbcTemplate.queryForMap(fetchSql, dto.getEmpCode());

        if (empInfo == null || empInfo.isEmpty()) {
            throw new RuntimeException("No employee info found for code: " + dto.getEmpCode());
        }

        String area = (String) empInfo.get("area_name");
        String position = (String) empInfo.get("position_name");
        String name = (String) empInfo.get("employee_name");

        // Step 2: Insert leave entry
        String insertSql = """
            INSERT INTO att_attendanceRe (
                area_name, position_name, emp_code, employee_name, 
                work_date, attendance_status, is_leave, leave_reason, 
                is_regularised, action_by, remarks
            ) VALUES (?, ?, ?, ?, ?, 'Leave', 1, ?, 1, ?, ?)
        """;

        return jdbcTemplate.update(
            insertSql,
            area, position, dto.getEmpCode(), name,
            dto.getWorkDate(),
            dto.getLeaveType(),
            userId,
            dto.getRemarks()
        );
    }
    
    @Override
    @Transactional(isolation = Isolation.READ_COMMITTED, propagation = Propagation.REQUIRED)
    public String v2ApplyLeave(AttendanceLeaveDTO dto, String userId) {
        if (dto.isHalfDay()) {
        	if (StringUtils.isBlank(dto.getHalfDaySlot())) {
        		throw new IllegalArgumentException("Specify half day slot: First Half, Second Half");
        	}
        	
        	boolean isFirstHalfSlot = dto.getHalfDaySlot().equals("FIRST");
        	
        	if (StringUtils.isBlank(dto.getCheckIn())) {
        		throw new IllegalArgumentException(
        				String.format("Specify work check-in hour %s", (isFirstHalfSlot ? "after First Half Leave" : "before Second Half Leave"))
				);
        	}
        	
        	if (StringUtils.isBlank(dto.getCheckOut())) {
        		throw new IllegalArgumentException(
        				String.format("Specify work check-out hour %s", (isFirstHalfSlot ? "after First Half Leave" : "before Second Half Leave"))
				);
        	}
        }
        
        String attendanceStatus = "Leave";
        String isLeave = "1";
        String isRegularised = "1";
        String leaveDuration = dto.isHalfDay() ? "HALF" : "FULL";
        String leaveHalfSlot = dto.isHalfDay() ? dto.getHalfDaySlot() : null;

        // 1️. Build full date list in ISO_DATE (yyyy-mm-dd)
        List<String> days = dto.isMultiple()
                ? DateParser.expandRange(dto.getFromDate(), dto.getToDate())
                : DateParser.expandRange(dto.getWorkDate(), dto.getWorkDate());
        
        // 2. Pull existing records for update them all
        Map<String, AttendanceDuration> indexedAttendanceDurationMap = new HashMap<>();

        // Key: work_date, Value: List<Records>
        Map<String, List<AttendanceRe>> existingWorkDateRecords = getExistingEmployeeAttendanceRecordsByWorkDates(dto.getEmpCode(), days)
        		.stream()
        		.map(existingRecord -> {

        			AttendanceDuration calculatedDuration = null;
        			if (dto.isHalfDay()) {

        				//  If Half day Leave already for a SLOT applied for a Date, again applying for Half Day, to complete Full day, show error: Apply for FULL-DAY Leave
        				if ("HALF".equals(existingRecord.getLeaveDuration())) {
        					throw new IllegalStateException(
        							String.format(
        									"Apply for Full Leave, already half day leave is there for the date %s with %s half slot.",
        									existingRecord.getWorkDate(),
        									existingRecord.getLeaveHalfSlot()
									)
							);
        				}
        				
        				
        				// Full Leave already applied for a Date, again applying for Half Day, update the existing Record accordingly with cal.
        				if ("FULL".equals(existingRecord.getLeaveDuration())) {
        					calculatedDuration = computeAttendanceDuration(true, dto.getCheckIn(), dto.getCheckOut());
        				}
        				
        			} else {
        				// If Half day Leave already for a SLOT applied for a Date, again applying for Full Day, update existing record accordingly with cal.
        				if ("HALF".equals(existingRecord.getLeaveDuration())) {
        					calculatedDuration = AttendanceDuration.buildEmpty();
        				}
        				
        				// If Full day Leave already applied throw error
        				if ("FULL".equals(existingRecord.getLeaveDuration())) {
        					throw new IllegalStateException(
        							String.format("Full day leave already applied for %s", existingRecord.getWorkDate())
							);
        				}
        			}
        			
        			if (null == calculatedDuration) {
    					calculatedDuration = AttendanceDuration.buildEmpty();
        			}
        			
   					existingRecord.setLeaveDuration(leaveDuration);
					existingRecord.setLeaveHalfSlot(leaveHalfSlot);
					existingRecord.setAttendanceStatus(attendanceStatus);
					existingRecord.setLeave(isLeave);
					existingRecord.setLeaveReason(dto.getLeaveType());
					existingRecord.setRegularised(isRegularised);
					existingRecord.setRemarks(dto.getRemarks());
        			
        			indexedAttendanceDurationMap.put(existingRecord.getWorkDate(), calculatedDuration);
        			
        			return existingRecord;
        		})
        		.collect(Collectors.groupingBy(AttendanceRe::getWorkDate));

        // 3. Update existing records
        if (!existingWorkDateRecords.isEmpty()) {
            List<AttendanceRe> recordsToUpdate = existingWorkDateRecords.values()
                    .stream()
                    .flatMap(Collection::stream)
                    .collect(Collectors.toCollection(ArrayList::new));

            String updateQuery = """
                            UPDATE [INOPSETPDB].[dbo].[att_attendanceRe] SET
                            day_start = ?,
                            day_end = ?,
                            shift_type = ?,
                            total_working_hours = ?,
                            total_hours = ?,
                            total_minutes = ?,
                            overtime_hours = ?,
                            overtime_minutes = ?,
                            attendance_status = ?,
                            is_regularised = ?,
                            action_by = ?,
                            is_leave = ?,
                            leave_reason = ?,
                            remarks = ?,
                            leave_duration = ?,
                            leave_half_slot = ?
                            WHERE sl_no = ?
                    """;

            try {
                jdbcTemplate.batchUpdate(updateQuery, new BatchPreparedStatementSetter() {
                    public void setValues(PreparedStatement ps, int i) throws SQLException {
                        AttendanceRe entity = recordsToUpdate.get(i);
                        AttendanceDuration duration = indexedAttendanceDurationMap.getOrDefault(entity.getWorkDate(), AttendanceDuration.buildEmpty());

                        ps.setString(1, toSafeDBDateString(duration.clockInAsString())); // day_start
                        ps.setString(2, toSafeDBDateString(duration.clockOutAsString())); // day_end
                        ps.setString(3, duration.shiftType()); // shift_type
                        ps.setString(4, String.valueOf(duration.totalWorkHours())); // total_working_hours
                        ps.setString(5, String.valueOf(duration.totalHours())); // total_hours
                        ps.setString(6, String.valueOf(duration.totalMinutes())); // total_minutes
                        ps.setString(7, String.valueOf(duration.overtimeHours())); // overtime_hours
                        ps.setString(8, String.valueOf(duration.overtimeMinutes())); // overtime_minutes
                        ps.setString(9, entity.getAttendanceStatus()); // attendance_status
                        ps.setString(10, entity.getRegularised()); // is_regularised
                        ps.setString(11, userId); // action_by
                        ps.setString(12, entity.getLeave()); // is_leave
                        ps.setString(13, entity.getLeaveReason()); // leave_reason
                        ps.setString(14, entity.getRemarks()); // remarks
                        ps.setString(15, entity.getLeaveDuration()); // leave_duration
                        ps.setString(16, entity.getLeaveHalfSlot()); // leave_half_slot
                        ps.setString(17, String.valueOf(entity.getSlNo())); // sl_no
                    }

                    public int getBatchSize() {
                        return recordsToUpdate.size();
                    }
                });
            } catch (Exception exception) {
                throw new IllegalStateException("Something went wrong while modifying existing records for leave");
            } finally {
                indexedAttendanceDurationMap.clear();
            }
        }

        // 4. Insert records if not exists
        List<String> recordsToInsert = days.stream()
                .filter(appliedLeaveDate -> !existingWorkDateRecords.containsKey(appliedLeaveDate))
                .distinct()
                .map(appliedLeaveDate -> {

                    AttendanceDuration calculatedDuration;
                    if (dto.isHalfDay()) {
                        calculatedDuration = computeAttendanceDuration(true, dto.getCheckIn(), dto.getCheckOut());
                    } else {
                        calculatedDuration = AttendanceDuration.buildEmpty();
                    }

                    indexedAttendanceDurationMap.put(appliedLeaveDate, calculatedDuration);

                    return appliedLeaveDate;
                })
                .toList();

        if (!recordsToInsert.isEmpty()) {
            // Fetch employee metadata while inserting
            EmployeeMeta employeeMeta = fetchEmployeeMeta(dto.getEmpCode())
                    .orElseThrow(() -> new IllegalArgumentException("Unknown employee with " + dto.getEmpCode() + " code"));

            int totalInsertionColumnSize = 26;
            String insertQuery = """
                     INSERT INTO att_attendanceRe (
                         emp_code,
                         employee_name,
                         position_name,
                         area_name,
                         site_name,
                         work_date,
                         day_start,
                         day_end,
                         shift_type,
                         total_working_hours,
                         total_hours,
                         total_minutes,
                         overtime_hours,
                         overtime_minutes,
                         attendance_status,
                         is_holiday,
                         holiday_reason,
                         is_regularised,
                         action_by,
                         regularise_reason,
                         is_leave,
                         leave_reason,
                         final_OT,
                         remarks,
                         leave_duration,
                         leave_half_slot
                    ) VALUES (""" + String.join(",", Collections.nCopies(totalInsertionColumnSize, "?")) + """
                        )
                    """;

            try {
                jdbcTemplate.batchUpdate(insertQuery, new BatchPreparedStatementSetter() {
                    public void setValues(PreparedStatement ps, int i) throws SQLException {
                        String workDate = recordsToInsert.get(i);
                        AttendanceDuration duration = indexedAttendanceDurationMap.getOrDefault(workDate, AttendanceDuration.buildEmpty());

                        ps.setString(1, employeeMeta.employeeCode()); // emp_code
                        ps.setString(2, employeeMeta.employeeName()); // employee_name
                        ps.setString(3, employeeMeta.positionName()); // position_name
                        ps.setString(4, employeeMeta.areaName()); // area_name
                        ps.setString(5, null); // site_name
                        ps.setString(6, workDate); // work_date
                        ps.setString(7, toSafeDBDateString(duration.clockInAsString())); // day_start
                        ps.setString(8, toSafeDBDateString(duration.clockOutAsString())); // day_end
                        ps.setString(9, duration.shiftType()); // shift_type
                        ps.setString(10, String.valueOf(duration.totalWorkHours())); // total_working_hours
                        ps.setString(11, String.valueOf(duration.totalHours())); // total_hours
                        ps.setString(12, String.valueOf(duration.totalMinutes())); // total_minutes
                        ps.setString(13, String.valueOf(duration.overtimeHours())); // overtime_hours
                        ps.setString(14, String.valueOf(duration.overtimeMinutes())); // overtime_minutes
                        ps.setString(15, attendanceStatus); // attendance_status
                        ps.setString(16, null); // is_holiday
                        ps.setString(17, null); // holiday_reason
                        ps.setString(18, isRegularised); // is_regularised
                        ps.setString(19, userId); // action_by
                        ps.setString(20, null); // regularise_reason
                        ps.setString(21, isLeave); // is_leave
                        ps.setString(22, dto.getLeaveType()); // leave_reason
                        ps.setString(23, null); // final_OT
                        ps.setString(24, dto.getRemarks()); // remarks
                        ps.setString(25, leaveDuration); // leave_duration
                        ps.setString(26, leaveHalfSlot); // leave_half_slot
                    }

                    public int getBatchSize() {
                        return recordsToInsert.size();
                    }
                });
            } catch (Exception exception) {
                throw new IllegalStateException("Something went wrong while inserting new records for leave");
            }
        }

        return String.format(
                "%s leave applied for (%s)",
                dto.isMultiple() ? "Multiple days" : dto.isHalfDay() ? "Half-day" : "Full-day",
                String.join(", ", days)
        );
    }
    
    public String determineShiftByTime(String timePart) {
        String shift;
        if (timePart.compareTo("03:45:00") >= 0 && timePart.compareTo("08:45:00") < 0) {
        	shift = "Shift A";
        } else if (timePart.compareTo("08:45:00") >= 0 && timePart.compareTo("12:45:00") < 0) {
        	shift = "General Shift";
        } else if (timePart.compareTo("12:45:00") >= 0 && timePart.compareTo("21:15:00") < 0) {
        	shift = "Shift B";
        } else {
        	shift = "Shift C";
        }
        return shift;
    }
    
    public String extractTimePartByRawString(String rawDateTimeString) {
    	return rawDateTimeString.split("T")[1];
    }
    
    public String extractTimePartByDateTimeString(String dateTimeString) {
    	return dateTimeString.split(" ")[1];
    }
    
    public AttendanceDuration computeAttendanceDuration(boolean raw, String clockInAsString, String clockOutAsString) {
    	// Parse CLOCK_IN, CLOCK_OUT
    	LocalDateTime clockIn = toLocalDateTime(clockInAsString);
    	LocalDateTime clockOut = toLocalDateTime(clockOutAsString);
    	
        // Compute Attendance Duration and OT
        long totalSeconds = Duration.between(clockIn, clockOut).getSeconds();
        int totalHours = (int) (totalSeconds / 3600);
        int totalMinutes = (int) ((totalSeconds % 3600) / 60);
        Integer overtimeHours = Math.max(totalHours - 8, 0);
        Double totalWorkHours = totalHours + (totalMinutes / 60.0);

        // Determine Shift Type
        String clockInTimePart = raw ? extractTimePartByRawString(clockInAsString) : extractTimePartByDateTimeString(clockInAsString);
        String shiftType = determineShiftByTime(clockInTimePart);
        
        return new AttendanceDuration(
        		clockIn,
        		clockOut,
        		clockInAsString,
        		clockOutAsString,
        		totalSeconds,
        		totalHours,
        		totalMinutes,
        		overtimeHours,
                0,
        		totalWorkHours,
        		clockInTimePart,
        		shiftType
		);
    }
    
    public LocalDateTime toLocalDateTime(String rawDateTimeString) {
        return LocalDateTime.parse(
                toSafeDBDateString(rawDateTimeString),
        		DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm")
		);
    }

    public String toSafeDBDateString(String rawDateTimeString) {
        return StringUtils.isNotBlank(rawDateTimeString) ? rawDateTimeString.replace("T", " ") : null;
    }

    public List<AttendanceRe> getExistingEmployeeAttendanceRecordsByWorkDates(String empCode, List<String> days) {
        if (days.isEmpty()) {
            return Collections.emptyList();
        }

        String inClause = String.join(",", Collections.nCopies(days.size(), "?"));
        String query = """
            SELECT *
            FROM att_attendanceRe
            WHERE emp_code = ?
            AND work_date IN (%s)
            AND is_leave = 1
        """;

        List<Object> args = new ArrayList<>(days.size() + 1);
        args.add(empCode);
        args.addAll(days);

        return jdbcTemplate.query(
                String.format(query, inClause),
                args.toArray(),
                (rs, i) -> new AttendanceRe(
                        rs.getLong("sl_no"),
                        rs.getString("emp_code"),
                        rs.getString("employee_name"),
                        rs.getString("position_name"),
                        rs.getString("area_name"),
                        rs.getString("site_name"),
                        rs.getString("work_date"),
                        rs.getString("day_start"),
                        rs.getString("day_end"),
                        rs.getString("shift_type"),
                        rs.getString("total_working_hours"),
                        rs.getString("total_hours"),
                        rs.getString("total_minutes"),
                        rs.getString("overtime_hours"),
                        rs.getString("overtime_minutes"),
                        rs.getString("attendance_status"),
                        rs.getString("is_holiday"),
                        rs.getString("holiday_reason"),
                        rs.getString("is_regularised"),
                        rs.getString("action_by"),
                        rs.getString("regularise_reason"),
                        rs.getString("is_leave"),
                        rs.getString("leave_reason"),
                        rs.getString("final_OT"),
                        rs.getString("remarks"),
                        rs.getString("leave_duration"),
                        rs.getString("leave_half_slot")
                )
        );
	}


	public Optional<EmployeeMeta> fetchEmployeeMeta(String employeeCode) {
        String query = """
            SELECT TOP 1 area_name, position_name, employee_name
            FROM att_attendanceRe WHERE emp_code = ?
            ORDER BY work_date DESC
            """;

        return jdbcTemplate.query(
                query,
                (rs, i) -> new EmployeeMeta(
                    employeeCode,
                    rs.getString("employee_name"),
                    rs.getString("area_name"),
                    rs.getString("position_name")
                ),
                employeeCode
        ).stream()
        .findFirst();
    }


    @Override
    public Object addAttendance(AttendanceDto data, String userId) {
        // Fetch employee details from existing attendance table
        String fetchSql = """
            SELECT TOP 1 employee_name, position_name, area_name, site_name
            FROM att_attendanceRe
            WHERE emp_code = ?
            ORDER BY work_date DESC
        """;

        Map<String, Object> empInfo = jdbcTemplate.queryForMap(fetchSql, data.getEmpCode());

        String empName = (String) empInfo.get("employee_name");
        String position = (String) empInfo.get("position_name");
        String area = (String) empInfo.get("area_name");
        String site = (String) empInfo.get("site_name");

        // Prepare insert SQL
        String insertSql = """
            INSERT INTO att_attendanceRe (
                emp_code, employee_name, position_name, area_name, site_name,
                work_date, day_start, day_end, shift_type,
                total_working_hours, total_hours, total_minutes,
                overtime_hours, overtime_minutes,
                attendance_status,
                remarks, is_regularised, action_by
            ) VALUES (
                ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 'OK', ?, 1, ?
            )
        """;

        // Parse Check-In and Check-Out datetime using correct format
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");

        LocalDateTime in = LocalDateTime.parse(data.getCheckIn().replace("T", " "), formatter);
        LocalDateTime out = LocalDateTime.parse(data.getCheckOut().replace("T", " "), formatter);

        // Duration and OT Calculation
        long seconds = Duration.between(in, out).getSeconds();
        int totalHours = (int) (seconds / 3600);
        int totalMinutes = (int) ((seconds % 3600) / 60);
        int overtimeHours = Math.max(totalHours - 8, 0);
        double totalWorkHrs = totalHours + (totalMinutes / 60.0);

        // Shift logic
        String timePart = data.getCheckIn().split("T")[1];
        String shift = "-";
        if (timePart.compareTo("03:45:00") >= 0 && timePart.compareTo("08:45:00") < 0) shift = "Shift A";
        else if (timePart.compareTo("08:45:00") >= 0 && timePart.compareTo("12:45:00") < 0) shift = "General Shift";
        else if (timePart.compareTo("12:45:00") >= 0 && timePart.compareTo("21:15:00") < 0) shift = "Shift B";
        else shift = "Shift C";

        return jdbcTemplate.update(insertSql,
            data.getEmpCode(), empName, position, area, site,
            in.toLocalDate(),                                // work_date
            data.getCheckIn().replace("T", " "),             // day_start
            data.getCheckOut().replace("T", " "),            // day_end
            shift,
            totalWorkHrs, totalHours, totalMinutes,
            overtimeHours, 0,                                // OT minutes set to 0
            data.getRemarks(), userId
        );
    }



	@Override
	public List<EmployeeDto> getEligibleEmployees() {
		 StringBuilder sql = new StringBuilder();
		    sql.append("SELECT DISTINCT emp_code, employee_name ")
		       .append("FROM att_attendanceRe ")
		       .append("WHERE emp_code IS NOT NULL AND employee_name IS NOT NULL ")
		       .append("AND ( ")
		       .append("    UPPER(position_name) LIKE '%PICKER%' ")
		       .append("    OR UPPER(position_name) LIKE '%DRIVER%' ")
		       .append("    OR UPPER(position_name) LIKE '%WELDER%' ")
		       .append("    OR UPPER(position_name) LIKE '%GARDENER%' ")
		       .append("    OR UPPER(position_name) LIKE '%WORKER%' ")
		       .append("    OR UPPER(position_name) LIKE '%OFFICE ASSISTANT%' ")
		      // .append("    OR UPPER(position_name) LIKE '%MARKETING%' ")
		       .append("    OR UPPER(position_name) LIKE '%VEHCLE SUPERVISOUR%' ")
		       .append(")");

		    return jdbcTemplate.query(sql.toString(), (rs, rowNum) -> {
		        EmployeeDto dto = new EmployeeDto();
		        dto.setEmpCode(rs.getString("emp_code"));
		        dto.setEmployeeName(rs.getString("employee_name"));
		        return dto;
		    });
	}


	@Override
	public List<AttendanceExportDTO> getExportData(String fromDate, String toDate) {
		String sql = """
SELECT
    ar.emp_code,
    ar.employee_name,
    ar.work_date,
    ar.day_start AS in_time,
    ar.day_end AS out_time,
    ar.total_working_hours AS worked_hours,
    ar.overtime_hours AS ot_hours,
    ISNULL(ar.attendance_status, 'Absent') AS status,
    ISNULL(ar.leave_reason, '') AS leave_type
FROM att_attendanceRe ar
WHERE ar.work_date BETWEEN ? AND ?
  AND (ar.attendance_status IS NOT NULL OR ar.is_leave = '1')
  AND (
   UPPER(ar.position_name) LIKE '%PICKER%' OR
   UPPER(ar.position_name) LIKE '%DRIVER%' OR
   UPPER(ar.position_name) LIKE '%WELDER%' OR
   UPPER(ar.position_name) LIKE '%GARDENER%' OR
   UPPER(ar.position_name) LIKE '%WORKER%' OR
   UPPER(ar.position_name) LIKE '%OFFICE ASSISTANT%' OR
   UPPER(ar.position_name) LIKE '%VEHCLE SUPERVISOUR%'
)

ORDER BY ar.emp_code, ar.work_date;

			""";


		return jdbcTemplate.query(sql, new Object[]{fromDate, toDate}, (rs, rowNum) -> {
		    AttendanceExportDTO dto = new AttendanceExportDTO();
		    dto.setEmpCode(rs.getString("emp_code"));
		    dto.setEmployeeName(rs.getString("employee_name"));
		    dto.setWorkDate(rs.getDate("work_date").toLocalDate());
		    
		 // Only extract time part from datetime string
		    dto.setInTime(rs.getString("in_time"));  // e.g., "05:09"
		    dto.setOutTime(rs.getString("out_time"));
		    dto.setTotalWorkingHours(rs.getString("worked_hours"));

		    // Replace raw float-like "11.016..." with clean hh:mm
		    String ot = rs.getString("ot_hours");
		    dto.setOtHours((ot == null || ot.isEmpty()) ? "0" : ot);                 // Corrected
		    dto.setAttendanceStatus(rs.getString("status"));             // Corrected
		    dto.setLeaveReason(rs.getString("leave_type"));              // Corrected
		    
		    return dto;
		});

	}


	

}
