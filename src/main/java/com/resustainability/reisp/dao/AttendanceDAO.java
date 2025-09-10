package com.resustainability.reisp.dao;

import java.sql.Date;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;
import java.util.Set;

import com.resustainability.reisp.dto.EmployeeMeta;
import com.resustainability.reisp.model.AttendanceDto;
import com.resustainability.reisp.model.AttendanceExportDTO;
import com.resustainability.reisp.model.AttendanceLeaveDTO;
import com.resustainability.reisp.model.AttendanceRegularizationDTO;
import com.resustainability.reisp.model.EmployeeDto;

public interface AttendanceDAO {
	List<AttendanceDto> fetchPaginatedAttendance(String empCode, String fromDate, String toDate, int start, int length, String searchValue);
    int fetchTotalAttendanceCount(String empCode, String fromDate, String toDate, String searchValue);
    List<EmployeeDto> fetchDistinctEmployees();
    void executeAttendanceReloadInsert(String fromDate, String toDate, String areaAlias) throws SQLException;
    List<AttendanceDto> findMissedPunches(String empCode, Date fromDate, Date toDate, String areaAlias, boolean onlyMissed);
    Object regularizeAttendance(AttendanceRegularizationDTO data, String userId);
    
	Object applyLeave(AttendanceLeaveDTO dto, String userId);
	String v2ApplyLeave(AttendanceLeaveDTO dto, String userId);

	Object addAttendance(AttendanceDto data, String userId);
	List<EmployeeDto> getEligibleEmployees();
	List<AttendanceExportDTO> getExportData(String localDate, String localDate2);

}
