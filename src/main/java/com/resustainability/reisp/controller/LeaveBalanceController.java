package com.resustainability.reisp.controller;

import com.resustainability.reisp.constants.PageConstants;
import com.resustainability.reisp.dto.commons.Pager;
import com.resustainability.reisp.dto.entity.LeaveBalance;
import com.resustainability.reisp.service.LeaveBalanceService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;


@Controller
public class LeaveBalanceController {

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(String.class, new StringTrimmerEditor(true));
    }

    private final LeaveBalanceService leaveBalanceService;

    @Autowired
    public LeaveBalanceController(LeaveBalanceService leaveBalanceService) {
        this.leaveBalanceService = leaveBalanceService;
    }

    @RequestMapping(
            value = "/leave-balance",
            method = {
                    RequestMethod.POST,
                    RequestMethod.GET
            }
    )
    public ModelAndView defaultPage() {
        return new ModelAndView(PageConstants.leaveBalance);
    }

    @RequestMapping(
            value = "/api/v1/leave/list",
            method = {
                    RequestMethod.GET
            }
    )
    @ResponseBody
    public Pager<LeaveBalance> list(
            HttpSession session,
            @RequestParam(value = "page", defaultValue = "0")  int  page,
            @RequestParam(value = "size", defaultValue = "10") int  size,
            @RequestParam(value = "sort", defaultValue = "id") String sort,
            @RequestParam(value = "direction", defaultValue = "asc") String direction,
            @RequestParam(value = "q", required = false) String searchTerm
    ) {
         return leaveBalanceService.list(page, size, sort, direction, searchTerm);
    }
}
