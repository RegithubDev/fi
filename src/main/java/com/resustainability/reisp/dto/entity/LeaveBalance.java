package com.resustainability.reisp.dto.entity;

import java.math.BigDecimal;

public class LeaveBalance {
    private Long id;
    private String empCode;
    private String empName;
    private String hireDate;
    private BigDecimal sickLeave;
    private BigDecimal casualLeave;
    private BigDecimal earnedLeave;
    private BigDecimal maternityLeave;
    private BigDecimal paternityLeave;

    public LeaveBalance() {}
    public LeaveBalance(Long id, String empCode, String empName, String hireDate, BigDecimal sickLeave, BigDecimal casualLeave, BigDecimal earnedLeave, BigDecimal maternityLeave, BigDecimal paternityLeave) {
        this.id = id;
        this.empCode = empCode;
        this.empName = empName;
        this.hireDate = hireDate;
        this.sickLeave = sickLeave;
        this.casualLeave = casualLeave;
        this.earnedLeave = earnedLeave;
        this.maternityLeave = maternityLeave;
        this.paternityLeave = paternityLeave;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getEmpCode() {
        return empCode;
    }

    public void setEmpCode(String empCode) {
        this.empCode = empCode;
    }

    public String getEmpName() {
        return empName;
    }

    public void setEmpName(String empName) {
        this.empName = empName;
    }

    public String getHireDate() {
        return hireDate;
    }

    public void setHireDate(String hireDate) {
        this.hireDate = hireDate;
    }

    public BigDecimal getSickLeave() {
        return sickLeave;
    }

    public void setSickLeave(BigDecimal sickLeave) {
        this.sickLeave = sickLeave;
    }

    public BigDecimal getCasualLeave() {
        return casualLeave;
    }

    public void setCasualLeave(BigDecimal casualLeave) {
        this.casualLeave = casualLeave;
    }

    public BigDecimal getEarnedLeave() {
        return earnedLeave;
    }

    public void setEarnedLeave(BigDecimal earnedLeave) {
        this.earnedLeave = earnedLeave;
    }

    public BigDecimal getMaternityLeave() {
        return maternityLeave;
    }

    public void setMaternityLeave(BigDecimal maternityLeave) {
        this.maternityLeave = maternityLeave;
    }

    public BigDecimal getPaternityLeave() {
        return paternityLeave;
    }

    public void setPaternityLeave(BigDecimal paternityLeave) {
        this.paternityLeave = paternityLeave;
    }
}
