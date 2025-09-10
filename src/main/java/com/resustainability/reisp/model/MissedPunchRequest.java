package com.resustainability.reisp.model;

public class MissedPunchRequest {
	 private String empCode;
	    private String fromDate;
	    private String toDate;
	    private String areaAlias;
		public String getEmpCode() {
			return empCode;
		}
		public void setEmpCode(String empCode) {
			this.empCode = empCode;
		}
		public String getFromDate() {
			return fromDate;
		}
		public void setFromDate(String fromDate) {
			this.fromDate = fromDate;
		}
		public String getToDate() {
			return toDate;
		}
		public void setToDate(String toDate) {
			this.toDate = toDate;
		}
		public String getAreaAlias() {
			return areaAlias;
		}
		public void setAreaAlias(String areaAlias) {
			this.areaAlias = areaAlias;
		}
	    
}
