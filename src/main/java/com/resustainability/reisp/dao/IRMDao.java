package com.resustainability.reisp.dao;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.attribute.PosixFilePermission;
import java.nio.file.attribute.PosixFilePermissions;
import java.sql.Array;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Calendar;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;
import java.util.stream.Collectors;
import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BatchPreparedStatementSetter;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.BeanPropertySqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;
import java.util.function.Function;

import com.resustainability.reisp.common.DBConnectionHandler;
import com.resustainability.reisp.common.DateParser;
import com.resustainability.reisp.common.EMailSender;
import com.resustainability.reisp.common.FileUploads;
import com.resustainability.reisp.common.Mail;
import com.resustainability.reisp.common.OSValidator;
import com.resustainability.reisp.common.UrlGenerator;
import com.resustainability.reisp.constants.CommonConstants;
import com.resustainability.reisp.model.Att;
import com.resustainability.reisp.model.IRM;
import com.resustainability.reisp.model.PunchRecord;
import com.resustainability.reisp.model.RawPunch;
import com.resustainability.reisp.model.User;
import com.resustainability.reisp.common.CommonMethods;




@Repository
public class IRMDao {

	@Autowired
	JdbcTemplate jdbcTemplate;
	
	@Autowired
	DataSource dataSource;

	@Autowired
	DataSourceTransactionManager transactionManager;

	

	public List<Att> getEmployeeAttendance(Att obj, String fromDate, String toDate, String empCode, String areaName) throws SQLException {
	    List<Att> menuList = null;
	    try {
	        StringBuilder qry = new StringBuilder();

	        qry.append("WITH RawPunches AS ( ");
	        qry.append("    SELECT ");
	        qry.append("        it.emp_code, ");
	        qry.append("        it.emp_id, ");
	        qry.append("        pe.first_name, pee.position_name, ");
	        qry.append("        pa.area_name, ");
	        qry.append("        ssd.site_name, ");
	        qry.append("        CAST(it.punch_time AS DATE) AS work_date, ");
	        qry.append("        it.punch_time, ");
	        qry.append("        it.punch_state ");
	        qry.append("    FROM [INOPSETPDB].[dbo].[iclock_transaction] it ");
	        qry.append("    INNER JOIN [INOPSETPDB].[dbo].[personnel_area] pa ON UPPER(it.area_alias) = UPPER(pa.area_code) ");
	        qry.append("    INNER JOIN [INOPSETPDB].[dbo].[personnel_employee] pe ON it.emp_id = pe.id ");
	        qry.append("    LEFT JOIN [INOPSETPDB].[dbo].[site_shift_details_re] ssd ON UPPER(ssd.site_name) = UPPER(it.area_alias) ");
	        qry.append("    LEFT JOIN personnel_position pee ON pe.position_id = pee.id ");
	        qry.append("    WHERE 1=1 ");

	        if (areaName != null && !areaName.isEmpty()) {
	            qry.append(" AND pa.area_name = ? ");
	        } else {
	            qry.append(" AND pa.area_name = 'BMW-MEML-ISNAPUR' ");
	        }

	        if (fromDate != null && toDate != null) {
	            qry.append(" AND it.punch_time >= CAST(? AS DATE) ");
	            qry.append(" AND it.punch_time < DATEADD(DAY, 1, CAST(? AS DATE)) ");
	        } else {
	            qry.append(" AND it.punch_time >= DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()), 0) ");
	            qry.append(" AND it.punch_time < DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()) + 1, 0) ");
	        }

	        if (empCode != null && !empCode.isEmpty()) {
	            qry.append(" AND it.emp_code = ? ");
	        }

	        qry.append(" AND ssd.site_name IS NOT NULL AND ssd.site_name <> '' ");
	        qry.append("), ");

	        qry.append("ManualOuts AS ( ");
	        qry.append("    SELECT ");
	        qry.append("        ml.employee_id, ");
	        qry.append("        CAST(ml.punch_time AS DATE) AS work_date, ");
	        qry.append("        MAX(ml.punch_time) AS manual_out_time ");
	        qry.append("    FROM [INOPSETPDB].[dbo].[att_manuallog] ml ");
	        qry.append("    WHERE ml.punch_state = 1 ");
	        qry.append("    GROUP BY ml.employee_id, CAST(ml.punch_time AS DATE) ");
	        qry.append("), ");

	        qry.append("Punches AS ( ");
	        qry.append("    SELECT ");
	        qry.append("        rp.emp_code, ");
	        qry.append("        rp.first_name, rp.position_name, ");
	        qry.append("        rp.area_name, rp.site_name, rp.work_date, ");
	        qry.append("        MIN(CASE WHEN rp.punch_state = 0 THEN rp.punch_time ELSE NULL END) AS first_check_in, ");
	        qry.append("        MAX(CASE WHEN rp.punch_state = 1 THEN rp.punch_time ELSE NULL END) AS last_check_out, ");
	        qry.append("        MIN(rp.punch_time) AS fallback_check_in, ");
	        qry.append("        MAX(rp.punch_time) AS fallback_check_out, ");
	        qry.append("        mo.manual_out_time ");
	        qry.append("    FROM RawPunches rp ");
	        qry.append("    LEFT JOIN ManualOuts mo ON mo.employee_id = rp.emp_id AND mo.work_date = rp.work_date ");
	        qry.append("    GROUP BY rp.emp_code, rp.first_name, rp.position_name, rp.area_name, rp.site_name, rp.work_date, mo.manual_out_time ");
	        qry.append("), ");

	        qry.append("FinalResult AS ( ");
	        qry.append("    SELECT ");
	        qry.append("        emp_code, ");
	        qry.append("        first_name, position_name, area_name, site_name, work_date, ");
	        qry.append("        ISNULL(first_check_in, fallback_check_in) AS first_check_in, ");
	        qry.append("        ISNULL(");
	        qry.append("            CASE ");
	        qry.append("                WHEN first_check_in = last_check_out THEN manual_out_time ");
	        qry.append("                ELSE last_check_out ");
	        qry.append("            END, fallback_check_out) AS last_check_out, ");
	        qry.append("        DATEDIFF(SECOND, ISNULL(first_check_in, fallback_check_in), ");
	        qry.append("            ISNULL(CASE WHEN first_check_in = last_check_out THEN manual_out_time ELSE last_check_out END, fallback_check_out)) AS total_seconds, ");
	        qry.append("        FORMAT(ISNULL(first_check_in, fallback_check_in), 'HH:mm') AS day_start, ");
	        qry.append("        FORMAT(ISNULL(CASE WHEN first_check_in = last_check_out THEN manual_out_time ELSE last_check_out END, fallback_check_out), 'HH:mm') AS day_end, ");
	        qry.append("        CASE ");
	        qry.append("            WHEN CAST(ISNULL(first_check_in, fallback_check_in) AS TIME) >= '03:45:00' AND CAST(ISNULL(first_check_in, fallback_check_in) AS TIME) < '08:45:00' THEN 'Shift A' ");
	        qry.append("            WHEN CAST(ISNULL(first_check_in, fallback_check_in) AS TIME) >= '08:45:00' AND CAST(ISNULL(first_check_in, fallback_check_in) AS TIME) < '12:45:00' THEN 'General Shift' ");
	        qry.append("            WHEN CAST(ISNULL(first_check_in, fallback_check_in) AS TIME) >= '12:45:00' AND CAST(ISNULL(first_check_in, fallback_check_in) AS TIME) < '21:15:00' THEN 'Shift B' ");
	        qry.append("            ELSE 'Shift C' ");
	        qry.append("        END AS shift_type, ");
	        qry.append("        FORMAT(DATEADD(SECOND, DATEDIFF(SECOND, ISNULL(first_check_in, fallback_check_in), ");
	        qry.append("            ISNULL(CASE WHEN first_check_in = last_check_out THEN manual_out_time ELSE last_check_out END, fallback_check_out)), 0), 'HH:mm:ss') AS total_working_hours, ");
	        qry.append("        CASE ");
	        qry.append("            WHEN DATEDIFF(SECOND, ISNULL(first_check_in, fallback_check_in), ");
	        qry.append("                ISNULL(CASE WHEN first_check_in = last_check_out THEN manual_out_time ELSE last_check_out END, fallback_check_out)) > 28800 ");
	        qry.append("            THEN DATEDIFF(SECOND, ISNULL(first_check_in, fallback_check_in), ");
	        qry.append("                ISNULL(CASE WHEN first_check_in = last_check_out THEN manual_out_time ELSE last_check_out END, fallback_check_out)) - 28800 ");
	        qry.append("            ELSE 0 ");
	        qry.append("        END AS overtime_seconds, ");
	        qry.append("        CASE ");
	        qry.append("            WHEN ISNULL(first_check_in, fallback_check_in) = ISNULL(last_check_out, fallback_check_out) THEN ");
	        qry.append("                CASE ");
	        qry.append("                    WHEN CAST(work_date AS DATE) = CAST(GETDATE() AS DATE) ");
	        qry.append("                         AND DATEDIFF(SECOND, fallback_check_in, fallback_check_out) < 3600 THEN 'Present' ");
	        qry.append("                    ELSE 'Missing Punch' ");
	        qry.append("                END ");
	        qry.append("            WHEN DATEDIFF(SECOND, fallback_check_in, fallback_check_out) < 14400 THEN ");
	        qry.append("                CASE ");
	        qry.append("                    WHEN DATEDIFF(SECOND, fallback_check_in, fallback_check_out) > 3600 THEN 'Partial Day' ");
	        qry.append("                    ELSE 'Present' ");
	        qry.append("                END ");
	        qry.append("            WHEN DATEDIFF(SECOND, fallback_check_in, fallback_check_out) <= 18000 THEN 'Half Day' ");
	        qry.append("            WHEN DATEDIFF(SECOND, fallback_check_in, fallback_check_out) < 28800 AND DATEDIFF(SECOND, fallback_check_in, fallback_check_out) > 18000 THEN 'Incomplete Shift' ");
	        qry.append("            WHEN DATEDIFF(SECOND, fallback_check_in, fallback_check_out) = 28800 THEN 'Full Day (No OT)' ");
	        qry.append("            ELSE 'Full Day with OT' ");
	        qry.append("        END AS attendance_status ");
	        qry.append("    FROM Punches ");
	        qry.append("), ");

	        qry.append("WithHoliday AS ( ");
	        qry.append("    SELECT fr.*, h.alias AS holiday_reason, ");
	        qry.append("        CASE WHEN h.alias IS NOT NULL THEN 'Yes' ELSE 'No' END AS is_holiday ");
	        qry.append("    FROM FinalResult fr ");
	        qry.append("    LEFT JOIN [INOPSETPDB].[dbo].[att_holiday] h ");
	        qry.append("        ON CAST(fr.work_date AS DATE) = CAST(h.start_date AS DATE) ");
	        qry.append(") ");

	        qry.append("SELECT ");
	        qry.append("    ROW_NUMBER() OVER (ORDER BY work_date DESC, emp_code) AS sl_no, ");
	        qry.append("    emp_code, ");
	        qry.append("    first_name AS employee_name, position_name, ");
	        qry.append("    area_name, site_name, ");
	        qry.append("    work_date, ");
	        qry.append("    day_start, day_end, shift_type, total_working_hours, ");
	        qry.append("    total_seconds / 3600 AS total_hours, ");
	        qry.append("    (CAST(total_seconds AS INT) % 3600) / 60 AS total_minutes, ");
	        qry.append("    overtime_seconds / 3600 AS overtime_hours, ");
	        qry.append("    (CAST(overtime_seconds AS INT) % 3600) / 60 AS overtime_minutes, ");
	        qry.append("    attendance_status, is_holiday, ");
	        qry.append("    ISNULL(holiday_reason, 'N/A') AS holiday_reason ");
	        qry.append("FROM WithHoliday ");
	        qry.append("ORDER BY work_date DESC ");


	        // Prepare parameter list dynamically
	        List<Object> params = new ArrayList<>();

	        if (areaName != null && !areaName.isEmpty()) {
	            params.add(areaName);
	        }

	        if (fromDate != null && toDate != null) {
	            params.add(fromDate);
	            params.add(toDate);
	        }

	        if (empCode != null && !empCode.isEmpty()) {
	            params.add(empCode);
	        }
	        menuList = jdbcTemplate.query(qry.toString(), params.toArray(), new BeanPropertyRowMapper<>(Att.class));

	        List<Att> filterList = getFilterList( fromDate,  toDate,  empCode,  areaName);
	     // Convert filterList to a Map<emp_code + work_date, Att> for fast lookup
	        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MMMM dd, yyyy");
	        Map<String, Att> filterMap = filterList.stream()
	        	    .collect(Collectors.toMap(
	        	        att -> att.getEmp_code().trim() + "|" + att.getWork_date().trim(),
	        	        Function.identity(),
	        	        (a, b) -> b // If duplicate key, keep latest
	        	    ));

	        	// Update matching records in menuList
	        	menuList = menuList.stream()
	        	    .map(original -> {
	        	        String key = original.getEmp_code().trim() + "|" + original.getWork_date().trim();
	        	        if (filterMap.containsKey(key)) {
	        	            Att updated = filterMap.get(key);

	        	            // Update fields from filterList
	        	            original.setDay_start(updated.getDay_start());
	        	            original.setDay_end(updated.getDay_end());
	        	            original.setShift_type(updated.getShift_type());
	        	            original.setTotal_working_hours(updated.getTotal_working_hours());
	        	            original.setTotal_hours(updated.getTotal_hours());
	        	            original.setTotal_minutes(updated.getTotal_minutes());
	        	            original.setOvertime_hours(updated.getOvertime_hours());
	        	            original.setOvertime_minutes(updated.getOvertime_minutes());
	        	            original.setAttendance_status(updated.getAttendance_status());
	        	            original.setIs_holiday(updated.getIs_holiday());
	        	            original.setHoliday_reason(updated.getHoliday_reason());
	        	        }
	        	        return original; // Return updated or unchanged original
	        	    })
	        	    .collect(Collectors.toList());
	        
	        if (menuList != null && !menuList.isEmpty()) {
	            List<Att> finalMenuList = menuList; // effectively final for use inside inner class

	            String mergeSql = "MERGE INTO att_attendanceRe AS target " +
	                    "USING (SELECT ? AS emp_code, ? AS employee_name, ? AS position_name, ? AS area_name, ? AS site_name, " +
	                    "              ? AS work_date, ? AS day_start, ? AS day_end, ? AS shift_type, ? AS total_working_hours, " +
	                    "              ? AS total_hours, ? AS total_minutes, ? AS overtime_hours, ? AS overtime_minutes, " +
	                    "              ? AS attendance_status, ? AS is_holiday, ? AS holiday_reason) AS source " +
	                    "ON (target.emp_code = source.emp_code AND target.work_date = source.work_date) " +
	                    "WHEN MATCHED THEN " +
	                    "  UPDATE SET employee_name = source.employee_name, position_name = source.position_name, " +
	                    "             area_name = source.area_name, site_name = source.site_name, day_start = source.day_start, " +
	                    "             day_end = source.day_end, shift_type = source.shift_type, total_working_hours = source.total_working_hours, " +
	                    "             total_hours = source.total_hours, total_minutes = source.total_minutes, " +
	                    "             overtime_hours = source.overtime_hours, overtime_minutes = source.overtime_minutes, " +
	                    "             attendance_status = source.attendance_status, is_holiday = source.is_holiday, holiday_reason = source.holiday_reason " +
	                    "WHEN NOT MATCHED THEN " +
	                    "  INSERT (emp_code, employee_name, position_name, area_name, site_name, work_date, day_start, day_end, shift_type, " +
	                    "          total_working_hours, total_hours, total_minutes, overtime_hours, overtime_minutes, " +
	                    "          attendance_status, is_holiday, holiday_reason) " +
	                    "  VALUES (source.emp_code, source.employee_name, source.position_name, source.area_name, source.site_name, " +
	                    "          source.work_date, source.day_start, source.day_end, source.shift_type, source.total_working_hours, " +
	                    "          source.total_hours, source.total_minutes, source.overtime_hours, source.overtime_minutes, " +
	                    "          source.attendance_status, source.is_holiday, source.holiday_reason);";

	            	jdbcTemplate.batchUpdate(mergeSql, new BatchPreparedStatementSetter() {
	            	    public void setValues(PreparedStatement ps, int i) throws SQLException {
	            	        Att att = finalMenuList.get(i);

	            	        ps.setString(1, att.getEmp_code());
	            	        ps.setString(2, att.getEmployee_name());
	            	        ps.setString(3, att.getPosition_name());
	            	        ps.setString(4, att.getArea_name());
	            	        ps.setString(5, att.getSite_name());

	            	        ps.setString(6, att.getWork_date());

	            	        ps.setString(7, att.getDay_start());
	            	        ps.setString(8, att.getDay_end());
	            	        ps.setString(9, att.getShift_type());
	            	        ps.setString(10, att.getTotal_working_hours());
	            	        ps.setString(11, att.getTotal_hours());
	            	        ps.setString(12, att.getTotal_minutes());
	            	        ps.setString(13, att.getOvertime_hours());
	            	        ps.setString(14, att.getOvertime_minutes());
	            	        ps.setString(15, att.getAttendance_status());
	            	        ps.setBoolean(16, "Yes".equalsIgnoreCase(att.getIs_holiday()));
	            	        ps.setString(17, att.getHoliday_reason());
	            	    }

	            	    public int getBatchSize() {
	            	        return finalMenuList.size();
	            	    }
	            });
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	        throw new SQLException(e.getMessage());
	    }
	    return menuList;
	}

	private List<Att> getFilterList(String fromDate, String toDate, String empCode, String areaName) throws SQLException {
	    List<Att> menuList = null;
	    try {
	        StringBuilder qry = new StringBuilder();
	        List<Object> params = new ArrayList<>();

	        qry.append("WITH RawPunches AS (\n")
	           .append("    SELECT it.emp_code, pe.id AS employee_id, pe.first_name, pa.area_name, pee.position_name,\n")
	           .append("           ssd.site_name,\n")
	           .append("           CASE WHEN DATEPART(HOUR, it.punch_time) < 3 THEN DATEADD(DAY, -1, CAST(it.punch_time AS DATE))\n")
	           .append("                ELSE CAST(it.punch_time AS DATE) END AS work_date,\n")
	           .append("           it.punch_time, it.punch_state\n")
	           .append("    FROM [INOPSETPDB].[dbo].[iclock_transaction] it\n")
	           .append("    INNER JOIN [INOPSETPDB].[dbo].[personnel_area] pa ON UPPER(it.area_alias) = UPPER(pa.area_code)\n")
	           .append("    INNER JOIN [INOPSETPDB].[dbo].[personnel_employee] pe ON  it.emp_id = pe.id \n")
	           .append("    LEFT JOIN [INOPSETPDB].[dbo].[site_shift_details_re] ssd ON UPPER(ssd.site_name) = UPPER(it.area_alias)\n")
	           .append("    LEFT JOIN [INOPSETPDB].[dbo].[personnel_position] pee ON pe.position_id = pee.id\n")
	           .append("    WHERE ssd.site_name IS NOT NULL AND ssd.site_name <> ''\n");

	        if (areaName != null && !areaName.isEmpty()) {
	            qry.append(" AND pa.area_name = ?\n");
	            params.add(areaName);
	        } else {
	            qry.append(" AND pa.area_name = 'BMW-MEML-ISNAPUR'\n");
	        }

	        if (fromDate != null && toDate != null) {
	            qry.append(" AND it.punch_time >= CAST(? AS DATE) AND it.punch_time < DATEADD(DAY, 1, CAST(? AS DATE)) \n");
	            params.add(fromDate);
	            params.add(toDate);
	        } else {
	            qry.append(" AND it.punch_time >= DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()), 0)\n")
	               .append(" AND it.punch_time < DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()) + 1, 0)\n");
	        }

	        if (empCode != null && !empCode.isEmpty()) {
	            qry.append(" AND it.emp_code = ?\n");
	            params.add(empCode);
	        }

	        qry.append("), PunchWithGap AS (\n")
	           .append("    SELECT *, LAG(punch_time) OVER (PARTITION BY emp_code ORDER BY punch_time) AS prev_punch\n")
	           .append("    FROM RawPunches\n")
	           .append("), PunchWithFlags AS (\n")
	           .append("    SELECT *,\n")
	           .append("        CASE \n")
	           .append("            WHEN prev_punch IS NULL THEN 1\n")
	           .append("            WHEN DATEDIFF(SECOND, prev_punch, punch_time) > 36000 THEN 1\n")
	           .append("            WHEN DATEPART(HOUR, punch_time) < 6 AND DATEPART(HOUR, prev_punch) >= 18 THEN 1\n")
	           .append("            ELSE 0\n")
	           .append("        END AS new_shift_flag\n")
	           .append("    FROM PunchWithGap\n")
	           .append("), ShiftGroups AS (\n")
	           .append("    SELECT *,\n")
	           .append("        SUM(new_shift_flag) OVER (PARTITION BY emp_code ORDER BY punch_time ROWS UNBOUNDED PRECEDING) AS shift_group\n")
	           .append("    FROM PunchWithFlags\n")
	           .append("), GroupedPunches AS (\n")
	           .append("    SELECT emp_code, employee_id, first_name, area_name, position_name, site_name,\n")
	           .append("           MIN(punch_time) AS first_punch, MAX(punch_time) AS last_punch,\n")
	           .append("           MIN(work_date) AS work_date\n")
	           .append("    FROM ShiftGroups\n")
	           .append("    GROUP BY emp_code, employee_id, first_name, area_name, position_name, site_name, shift_group\n")
	           .append("), ManualOutPunches AS (\n")
	           .append("    SELECT ml.employee_id, CAST(ml.punch_time AS DATE) AS work_date, MAX(ml.punch_time) AS manual_punch_out\n")
	           .append("    FROM [INOPSETPDB].[dbo].[att_manuallog] ml\n")
	           .append("    WHERE ml.punch_state = 1\n");

	        if (fromDate != null && toDate != null) {
	            qry.append(" AND ml.punch_time >= CAST(? AS DATE) AND ml.punch_time < DATEADD(DAY, 1, CAST(? AS DATE))\n");
	            params.add(fromDate);
	            params.add(toDate);
	        }

	        qry.append("    GROUP BY ml.employee_id, CAST(ml.punch_time AS DATE)\n")
	           .append("), FinalWithManualOut AS (\n")
	           .append("    SELECT gp.*,\n")
	           .append("           gp.first_punch AS day_start_time,\n")
	           .append("           CASE WHEN gp.first_punch = gp.last_punch THEN ISNULL(m.manual_punch_out, gp.last_punch) ELSE gp.last_punch END AS day_end_time\n")
	           .append("    FROM GroupedPunches gp\n")
	           .append("    LEFT JOIN ManualOutPunches m ON gp.employee_id = m.employee_id AND gp.work_date = m.work_date\n")
	           .append("), FilteredFinal AS (\n")
	           .append("    SELECT *, DATEDIFF(SECOND, day_start_time, day_end_time) AS total_seconds\n")
	           .append("    FROM FinalWithManualOut\n")
	           .append("    WHERE DATEDIFF(SECOND, day_start_time, day_end_time) <= 54000\n")
	           .append(")\n")
	           .append("SELECT\n")
	           .append("    ROW_NUMBER() OVER (ORDER BY f.work_date DESC, f.emp_code) AS sl_no,\n")
	           .append("    f.emp_code, f.first_name AS employee_name, f.position_name, f.area_name, f.site_name,\n")
	           .append("    FORMAT(f.work_date, 'MMMM dd, yyyy') AS work_date,\n")
	           .append("    FORMAT(f.day_start_time, 'MMMM dd - HH:mm:ss') AS day_start,\n")
	           .append("    FORMAT(f.day_end_time, 'MMMM dd - HH:mm:ss') AS day_end,\n")
	           .append("    CASE\n")
	           .append("        WHEN CAST(f.day_start_time AS TIME) >= '05:10:00' AND CAST(f.day_start_time AS TIME) < '08:45:00' THEN 'Shift A'\n")
	           .append("        WHEN CAST(f.day_start_time AS TIME) >= '08:45:00' AND CAST(f.day_start_time AS TIME) < '12:45:00' THEN 'General Shift'\n")
	           .append("        WHEN CAST(f.day_start_time AS TIME) >= '12:45:00' AND CAST(f.day_start_time AS TIME) < '21:15:00' THEN 'Shift B'\n")
	           .append("        ELSE 'Shift C'\n")
	           .append("    END AS shift_type,\n")
	           .append("    FORMAT(DATEADD(SECOND, f.total_seconds, 0), 'HH:mm:ss') AS total_working_hours,\n")
	           .append("    f.total_seconds / 3600 AS total_hours,\n")
	           .append("    (f.total_seconds % 3600) / 60 AS total_minutes,\n")
	           .append("    CASE WHEN f.total_seconds > 28800 THEN (f.total_seconds - 28800) / 3600 ELSE 0 END AS overtime_hours,\n")
	           .append("    CASE WHEN f.total_seconds > 28800 THEN (f.total_seconds - 28800) % 3600 / 60 ELSE 0 END AS overtime_minutes,\n")
	           .append("    CASE\n")
	           .append("        WHEN f.day_start_time = f.day_end_time THEN 'Missing Punch'\n")
	           .append("        WHEN f.total_seconds <= 3600 AND CAST(f.work_date AS date) = CAST(GETDATE() AS date) THEN 'Present'\n")
	           .append("        WHEN f.total_seconds <= 3600 THEN 'Missing Punch'\n")
	           .append("        WHEN f.total_seconds <= 18000 THEN 'Half Day'\n")
	           .append("        WHEN f.total_seconds < 28800 THEN 'Incomplete Shift'\n")
	           .append("        WHEN f.total_seconds = 28800 THEN 'Full Day (No OT)'\n")
	           .append("        ELSE 'Full Day with OT'\n")
	           .append("    END AS attendance_status\n")
	           .append("FROM FilteredFinal f\n")
	           .append("ORDER BY f.work_date DESC;");

	        menuList = jdbcTemplate.query(qry.toString(), params.toArray(), new BeanPropertyRowMapper<>(Att.class));
	    } catch (Exception e) {
	        e.printStackTrace();
	        throw new SQLException(e.getMessage());
	    }
	    return menuList;
	}
	
	
	public List<PunchRecord> getRawPunches(String fromDate, String toDate, String empCode, String areaName) throws SQLException {
	    List<PunchRecord> punches = new ArrayList<>();
	    try {
	        StringBuilder qry = new StringBuilder();
	        qry.append("SELECT [id], [emp_code], [punch_time], [punch_state], [verify_type], \r\n"
	        		+ "       [work_code], [terminal_sn], [terminal_alias], [area_alias]\r\n"
	        		+ "FROM INOPSETPDB.[dbo].[iclock_transaction]\r\n"
	        		+ "WHERE emp_code = '4999' \r\n"
	        		+ "  AND area_alias = 'BMW-MEML-ISNAPUR'\r\n"
	        		+ "  AND punch_time >= '2025-05-05 00:00:00' \r\n"
	        		+ "  AND punch_time < '2025-05-16 00:00:00'\r\n"
	        		+ "ORDER BY punch_time ASC\r\n"
	        		+ " ");
	         //   params.add(empCode);
	       // }

	        punches = jdbcTemplate.query(qry.toString(), new BeanPropertyRowMapper<>(PunchRecord.class));

	    } catch (Exception e) {
	        e.printStackTrace();
	        throw new SQLException(e.getMessage());
	    }
	    return punches;
	}
	public List<Att> getEmployeeAttendance1(Att obj, String fromDate, String toDate, String empCode,
			String areaName) throws SQLException {
		 List<Att> menuList = null;
		    try {

		        StringBuilder sql = new StringBuilder();
		        List<Object> params = new ArrayList<>();

		        sql.append("SELECT [sl_no], [emp_code], [employee_name], [position_name], [area_name], [site_name],\n")
		           .append("       [work_date], [day_start], [day_end], [shift_type], [total_working_hours],\n")
		           .append("       [total_hours], [total_minutes], [overtime_hours],is_holiday, [overtime_minutes],\n")
		           .append("       [attendance_status], [is_holiday], [holiday_reason],final_OT\n")
		           .append("FROM [INOPSETPDB].[dbo].[att_attendanceRe]\n")
		           .append("WHERE 1 = 1\n");

		        // Convert work_date to DATE from its formatted string value like "May 25, 2025"
		        if (fromDate != null && toDate != null) {
		            sql.append("  AND TRY_CAST(work_date AS DATE) >= ? AND TRY_CAST(work_date AS DATE) <= ?\n");
		            params.add(fromDate);
		            params.add(toDate);
		        } else {
		            sql.append("  AND TRY_CAST(work_date AS DATE) >= DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()), 0)\n");
		            sql.append("  AND TRY_CAST(work_date AS DATE) < DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()) + 1, 0)\n");
		        }

		        if (areaName != null && !areaName.isEmpty()) {
		            sql.append("  AND area_name = ?\n");
		            params.add(areaName);
		        }

		        if (empCode != null && !empCode.isEmpty()) {
		            sql.append("  AND emp_code = ?\n");
		            params.add(empCode);
		        }

		        sql.append("ORDER BY TRY_CAST(work_date AS DATE) DESC, emp_code;");


		        menuList = jdbcTemplate.query(sql.toString(), params.toArray(), new BeanPropertyRowMapper<>(Att.class));
		    } catch (Exception e) {
		        e.printStackTrace();
		        throw new SQLException(e.getMessage());
		    }
		    return menuList;
	}
	public boolean regularizeAction(List<Map<String, String>> attendanceList, Att obj) throws Exception {
	    boolean flag = false;
	    int count = 0;

	    TransactionDefinition def = new DefaultTransactionDefinition();
	    TransactionStatus status = transactionManager.getTransaction(def);

	    try {
	        NamedParameterJdbcTemplate namedParamJdbcTemplate = new NamedParameterJdbcTemplate(dataSource);

	        StringBuilder qry = new StringBuilder();

	        qry.append("MERGE INTO att_attendanceRe AS target ");
	        qry.append("USING (SELECT :emp_code AS emp_code, :work_date AS work_date) AS source ");
	        qry.append("ON target.emp_code = source.emp_code AND target.work_date = source.work_date ");
	        qry.append("WHEN MATCHED THEN UPDATE SET ");
	        qry.append("day_start = :day_start, ");
	        qry.append("day_end = :day_end, ");
	        qry.append("shift_type = :shift_type, ");
	        qry.append("total_working_hours = :total_working_hours, ");
	        qry.append("total_hours = :total_hours, ");
	        qry.append("total_minutes = :total_minutes, ");
	        qry.append("overtime_hours = :overtime_hours, ");
	        qry.append("overtime_minutes = :overtime_minutes, ");
	        qry.append("attendance_status = :attendance_status ");
	        qry.append("WHEN NOT MATCHED THEN ");
	        qry.append("INSERT (emp_code, work_date, day_start, day_end, shift_type, ");
	        qry.append("total_working_hours, total_hours, total_minutes, ");
	        qry.append("overtime_hours, overtime_minutes, attendance_status) ");
	        qry.append("VALUES (:emp_code, :work_date, :day_start, :day_end, :shift_type, ");
	        qry.append(":total_working_hours, :total_hours, :total_minutes, ");
	        qry.append(":overtime_hours, :overtime_minutes, :attendance_status);");

	        String rewardQry = "INSERT INTO regularizeAudit (action, reward_points, user_id, created_date) " +
	                           "VALUES (:action, 10, :action_by, GETDATE());";

	        for (Map<String, String> map : attendanceList) {
	            Att aa = new Att();
	            aa.setEmp_code(map.get("emp_code"));
	            aa.setWork_date(DateParser.parse(map.get("work_date"))); // Adjust format if needed
	            aa.setDay_start(DateParser.parse(map.get("day_start")));
	            aa.setDay_end(DateParser.parse(map.get("day_end")));
	            aa.setShift_type(map.getOrDefault("shift_type", "General"));
	            aa.setTotal_working_hours(map.get("total_working_hours"));
	            aa.setTotal_hours(map.get("total_hours"));
	            aa.setTotal_minutes(map.get("total_minutes"));
	            aa.setOvertime_hours(map.get("overtime_hours"));
	            aa.setOvertime_minutes(map.get("overtime_minutes"));
	            aa.setAttendance_status(map.get("attendance_status"));
	            aa.setIs_regularised("Yes");
	            aa.setAction_by(obj.getUser_id());
	            if(attendanceList.size() > 1) {
	            	 aa.setRemarks("Bulk Regularize");
	            }
	            BeanPropertySqlParameterSource paramSource = new BeanPropertySqlParameterSource(aa);

	            int affected = namedParamJdbcTemplate.update(qry.toString(), paramSource);

	            if (affected > 0) {
	                namedParamJdbcTemplate.update(rewardQry, paramSource);
	                count++;
	            }
	        }

	        transactionManager.commit(status);
	        flag = count > 0;
	    } catch (Exception e) {
	        transactionManager.rollback(status);
	        e.printStackTrace();
	        throw new Exception("Error while processing attendance records", e);
	    }

	    return flag;
	}

	public List<User> getIRMLAzyList(User obj, int startIndex, int offset, String searchParameter) throws SQLException {
		List<User> menuList = null;
		try{  
			String qry = "SELECT  it.id\r\n"
					+ "      ,it.emp_code\r\n, pe.first_name as user_name"
					+ "      ,punch_time\r\n"
					+ "      ,punch_state\r\n"
					+ "      ,verify_type\r\n"
					+ "      ,work_code\r\n"
					+ "      ,terminal_sn\r\n"
					+ "      ,terminal_alias\r\n"
					+ "      ,it.area_alias\r\n"
					+ "      ,longitude\r\n"
					+ "      ,latitude\r\n"
					+ "      ,gps_location\r\n"
					+ "      ,it.mobile\r\n"
					+ "      ,source\r\n"
					+ "      ,purpose\r\n"
					+ "      ,crc\r\n"
					+ "      ,is_attendance\r\n"
					+ "      ,reserved\r\n"
					+ "      ,upload_time\r\n"
					+ "      ,sync_status\r\n"
					+ "      ,sync_time\r\n"
					+ "      ,emp_id\r\n"
					+ "      ,terminal_id\r\n"
					+ "      ,it.company_id\r\n"
					+ "      ,mask_flag\r\n"
					+ "      ,temperature\r\n"
					+ "      ,last_insert_narella_id\r\n"
					+ "      ,generated_by  FROM [INOPSETPDB].[dbo].[iclock_transaction] it\r\n"
				    + "    INNER JOIN [INOPSETPDB].[dbo].[personnel_area] pa ON UPPER(it.area_alias) = UPPER(pa.area_code) "
				    +   "    INNER JOIN [INOPSETPDB].[dbo].[personnel_employee] pe ON  it.emp_id = pe.id  ";
			int arrSize = 0;
			if(!StringUtils.isEmpty(searchParameter)) {
				qry = qry + " and (c.emp_code like ? or pe.first_name like ? or it.area_alias like ?)";
				arrSize++;
				arrSize++;
				arrSize++;
				
			}	
			if(!StringUtils.isEmpty(startIndex) && !StringUtils.isEmpty(offset)) {
				qry = qry + " order by FORMAT(punch_time, 'dd-MMM-yy') desc  offset ? rows  fetch next ? rows only  ";
				arrSize++;
				arrSize++;
			}
			menuList = jdbcTemplate.query( qry, new BeanPropertyRowMapper<User>(User.class));
			
		}catch(Exception e){ 
			e.printStackTrace();
			throw new SQLException(e.getMessage());
		}
		return menuList;
	}


}
