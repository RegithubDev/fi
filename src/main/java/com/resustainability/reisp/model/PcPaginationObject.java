package com.resustainability.reisp.model;

import java.util.List;

public class PcPaginationObject {
    private int iTotalRecords;
    private int iTotalDisplayRecords;
    private List<Pc> aaData;

    public int getiTotalRecords() {
        return iTotalRecords;
    }

    public void setiTotalRecords(int iTotalRecords) {
        this.iTotalRecords = iTotalRecords;
    }

    public int getiTotalDisplayRecords() {
        return iTotalDisplayRecords;
    }

    public void setiTotalDisplayRecords(int iTotalDisplayRecords) {
        this.iTotalDisplayRecords = iTotalDisplayRecords;
    }

    public List<Pc> getAaData() {
        return aaData;
    }

    public void setAaData(List<Pc> aaData) {
        this.aaData = aaData;
    }
}