package com.resustainability.reisp.service;

import com.resustainability.reisp.dao.LeaveBalanceDao;
import com.resustainability.reisp.dto.commons.Pager;
import com.resustainability.reisp.dto.entity.LeaveBalance;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LeaveBalanceService {

    private final LeaveBalanceDao leaveBalanceDao;

    @Autowired
    public LeaveBalanceService(LeaveBalanceDao leaveBalanceDao) {
        this.leaveBalanceDao = leaveBalanceDao;
    }

    public Pager<LeaveBalance> list(int page, int size, String sort, String direction, String searchTerm) {
        return leaveBalanceDao.fetchPage(page, size, sort, direction, searchTerm);
    }
}
