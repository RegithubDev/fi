package com.resustainability.reisp.model;

import java.time.LocalDateTime;

public class PunchRecord {
	public int id;
	public String empCode;
       public LocalDateTime punchTime;
       public String punchState;
       // add other fields as needed
       
       public PunchRecord(int id, String empCode, LocalDateTime punchTime, String punchState) {
           this.id = id;
           this.empCode = empCode;
           this.punchTime = punchTime;
           this.punchState = punchState;
       }
       public PunchRecord() {
       }

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getEmpCode() {
		return empCode;
	}

	public void setEmpCode(String empCode) {
		this.empCode = empCode;
	}

	public LocalDateTime getPunchTime() {
		return punchTime;
	}

	public void setPunchTime(LocalDateTime punchTime) {
		this.punchTime = punchTime;
	}

	public String getPunchState() {
		return punchState;
	}

	public void setPunchState(String punchState) {
		this.punchState = punchState;
	}
}

