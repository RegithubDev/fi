package com.resustainability.reisp.model;

import java.util.List;

public class DataTableResponse {
    private int draw;
    private int recordsTotal;
    private int recordsFiltered;
    private List<AttendanceDto> data;
    // Getters and setters
	public int getDraw() {
		return draw;
	}
	public void setDraw(int draw) {
		this.draw = draw;
	}
	public int getRecordsTotal() {
		return recordsTotal;
	}
	public void setRecordsTotal(int recordsTotal) {
		this.recordsTotal = recordsTotal;
	}
	public int getRecordsFiltered() {
		return recordsFiltered;
	}
	public void setRecordsFiltered(int recordsFiltered) {
		this.recordsFiltered = recordsFiltered;
	}
	public List<AttendanceDto> getData() {
		return data;
	}
	public void setData(List<AttendanceDto> data) {
		this.data = data;
	}
    
}
