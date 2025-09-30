package com.resustainability.reisp.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.resustainability.reisp.constants.PageConstants;
import com.resustainability.reisp.model.EsiContribution;
import com.resustainability.reisp.model.Pc;
import com.resustainability.reisp.service.EsiContributionService;
import com.resustainability.reisp.service.InventoryContributionService;
@Controller
public class MissedInputController {

	

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(String.class, new StringTrimmerEditor(true));
    }

    Logger logger = Logger.getLogger(MissedInputController.class);
    
	 @Autowired
	    private EsiContributionService contributionService1;
	 
    
    @RequestMapping(value = "/mo", method = {RequestMethod.POST, RequestMethod.GET})
    public ModelAndView pc(@ModelAttribute Pc pc, HttpSession session) {
        ModelAndView model = new ModelAndView(PageConstants.MO);
        try {
        	 List<EsiContribution> pcs = contributionService1.getUList();
             model.addObject("inventoryList", pcs);
        } catch (Exception e) {
            logger.error("pc : User Id - " + session.getAttribute("USER_ID") + " - User Name - " + session.getAttribute("USER_NAME") + " - " + e.getMessage());
            model.addObject("error", "Access denied or session expired.");
        }
        return model;
    }
    
    
}
