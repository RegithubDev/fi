package com.resustainability.reisp.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.resustainability.reisp.common.DateForUser;
import com.resustainability.reisp.constants.PageConstants;
import com.resustainability.reisp.model.EsiContribution;
import com.resustainability.reisp.model.User;
import com.resustainability.reisp.service.ContributionService;
import com.resustainability.reisp.service.EsiContributionService;

@RestController
public class ESIContributionController {

	@InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(String.class, new StringTrimmerEditor(true));
    } 
	Logger logger = Logger.getLogger(ESIContributionController.class);
	 @Autowired
	    private EsiContributionService contributionService;
 
	 @RequestMapping(value = "/esi", method = {RequestMethod.POST, RequestMethod.GET})
		public ModelAndView department(@ModelAttribute EsiContribution user, HttpSession session) {
			ModelAndView model = new ModelAndView(PageConstants.esi);
			try {
				String role = (String) session.getAttribute("ROLE");
				String pc = (String) session.getAttribute("PC");
				User usr = new User();
				usr.setRole(role);
				List<EsiContribution> eList = contributionService.geteList();
				model.addObject("eList", eList);
				usr.setProfit_center_code(pc);
				List<EsiContribution> pList = contributionService.getpList();
				model.addObject("profitCenterList", pList);
				
				List<EsiContribution> esiList = contributionService.getEsiContributions(user.getMonth_year(), user.getEntity_code(), user.getProfit_center_code(),usr);
				model.addObject("esiList", esiList);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return model;
		}
	

		@RequestMapping(value = "/add-esi", method = {RequestMethod.GET,RequestMethod.POST})
		public ModelAndView addEsiContribution(@ModelAttribute EsiContribution esiContribution,RedirectAttributes attributes,HttpSession session) {
			boolean flag = false;
			String userId = null;
			String userName = null;
			ModelAndView model = new ModelAndView();
			try {
				model.setViewName("redirect:/esi");
				userId = (String) session.getAttribute("USER_ID");
				userName = (String) session.getAttribute("USER_NAME");
				DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd"); 
			    String dt = formatter.format(new Date());
				String endDate = DateForUser.date();
				esiContribution.setCreated_by(userId);
				flag = contributionService.addEsiContribution(esiContribution);
				if(flag == true) {
					attributes.addFlashAttribute("success", "PF Contribution Added Succesfully.");
				}
				else {
					attributes.addFlashAttribute("error","Adding PF Contribution is failed. Try again.");
				}
			} catch (Exception e) {
				attributes.addFlashAttribute("error","Adding PF Contribution is failed. Try again.");
				e.printStackTrace();
			}
			return model;
		}
	    @RequestMapping(value = "/update-esi", method = {RequestMethod.GET,RequestMethod.POST})
		public ModelAndView updateEsiContribution(@ModelAttribute EsiContribution esiContribution,RedirectAttributes attributes,HttpSession session) {
	    	boolean flag = false;
			String userId = null;
			String userName = null;
			ModelAndView model = new ModelAndView();
			try {
				model.setViewName("redirect:/esi");
				userId = (String) session.getAttribute("USER_ID");
				userName = (String) session.getAttribute("USER_NAME");
				DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd"); 
			    String dt = formatter.format(new Date());
				String endDate = DateForUser.date();
				
				flag = contributionService.updateEsiContribution(esiContribution);
				if(flag == true) {
					attributes.addFlashAttribute("success", "PF Contribution updated Succesfully.");
				}
				else {
					attributes.addFlashAttribute("error","updating PF Contribution is failed. Try again.");
				}
			} catch (Exception e) {
				attributes.addFlashAttribute("error","updating PF Contribution is failed. Try again.");
				e.printStackTrace();
			}
			return model;
	    }
}
