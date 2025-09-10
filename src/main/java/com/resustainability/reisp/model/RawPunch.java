package com.resustainability.reisp.model;

import java.sql.Timestamp;

public class RawPunch {
    private String empCode;
    private String firstName;
    private String areaName;
    private String siteName;
    private Timestamp punchTime;
    private int punchState;
	public String getEmpCode() {
		return empCode;
	}
	public void setEmpCode(String empCode) {
		this.empCode = empCode;
	}
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getAreaName() {
		return areaName;
	}
	public void setAreaName(String areaName) {
		this.areaName = areaName;
	}
	public String getSiteName() {
		return siteName;
	}
	public void setSiteName(String siteName) {
		this.siteName = siteName;
	}
	public Timestamp getPunchTime() {
		return punchTime;
	}
	public void setPunchTime(Timestamp punchTime) {
		this.punchTime = punchTime;
	}
	public int getPunchState() {
		return punchState;
	}
	public void setPunchState(int punchState) {
		this.punchState = punchState;
	}
    
    
    
}
