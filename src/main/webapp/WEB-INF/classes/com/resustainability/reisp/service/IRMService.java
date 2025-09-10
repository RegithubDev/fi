package com.resustainability.reisp.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.resustainability.reisp.dao.IRMDao;
import com.resustainability.reisp.model.Att;
import com.resustainability.reisp.model.IRM;
import com.resustainability.reisp.model.PunchRecord;
import com.resustainability.reisp.model.RawPunch;
import com.resustainability.reisp.model.User;


@Service
public class IRMService {

	@Autowired
	IRMDao dao;

	public List<Att> getEmployeeAttendance(Att obj, String fromDate, String toDate, String empCode, String areaName) throws Exception {
		return dao.getEmployeeAttendance(obj, fromDate, toDate, empCode, areaName);
	}

	public List<PunchRecord> getRawPunches(String from_date, String to_date, String emp_code, String area_name) throws Exception {
		return dao.getRawPunches(from_date, to_date, emp_code, area_name);
	}
	public List<Att> getEmployeeAttendance1(Att obj, String from_date, String to_date, String emp_code,
			String area_name) throws Exception  {
		return dao.getEmployeeAttendance1(obj, from_date, to_date, emp_code, area_name);
	}
	public boolean regularizeAction(List<Map<String, String>> attendanceList, Att obj)throws Exception {
		return dao.regularizeAction(attendanceList,obj);
	}


	
}
