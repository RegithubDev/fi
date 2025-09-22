package com.resustainability.reisp.controller;

import java.io.File;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.http.ResponseEntity;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.resustainability.reisp.common.DateForUser;
import com.resustainability.reisp.common.FileUploads;
import com.resustainability.reisp.constants.CommonConstants;
import com.resustainability.reisp.constants.PageConstants;
import com.resustainability.reisp.model.inventoryContribution;
import com.resustainability.reisp.model.EsiContribution;
import com.resustainability.reisp.model.User;
import com.resustainability.reisp.service.ContributionService;
import com.resustainability.reisp.service.EsiContributionService;
import com.resustainability.reisp.service.InventoryContributionService;


@RestController
public class InventoryContributionController {

	@InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(String.class, new StringTrimmerEditor(true));
    } 
	Logger logger = Logger.getLogger(InventoryContributionController.class);
	 @Autowired
	    private InventoryContributionService contributionService;
 
	 @Autowired
	    private EsiContributionService contributionService1;
	 
	 @RequestMapping(value = "/inventory", method = {RequestMethod.POST, RequestMethod.GET})
		public ModelAndView department(@ModelAttribute inventoryContribution user, HttpSession session) {
			ModelAndView model = new ModelAndView(PageConstants.inventory);
			try {
				String role = (String) session.getAttribute("ROLE");
				String pc = (String) session.getAttribute("PC");
				User usr = new User();
				usr.setRole(role);
				List<EsiContribution> eList = contributionService1.geteList();
				model.addObject("eList", eList);
				usr.setProfit_center_code(pc);
				List<EsiContribution> pList = contributionService1.getpList();
				model.addObject("profitCenterList", pList);
				
				List<inventoryContribution> inventoryList = contributionService.getinventoryContributions(user.getMonth_year(), user.getEntity_code(), user.getProfit_center_code(),usr);
				model.addObject("inventoryList", inventoryList);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return model;
		}
	

		@RequestMapping(value = "/inventory/add", method = {RequestMethod.GET,RequestMethod.POST})
		public ModelAndView addinventoryContribution(@ModelAttribute inventoryContribution inventoryContribution, MultipartFile file, RedirectAttributes attributes,HttpSession session) {
			boolean flag = false;
			String userId = null;
			String userName = null;
			ModelAndView model = new ModelAndView();
			try {
				model.setViewName("redirect:/inventory");
				userId = (String) session.getAttribute("USER_ID");
				userName = (String) session.getAttribute("USER_NAME");
				DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd"); 
			    String dt = formatter.format(new Date());
				String endDate = DateForUser.date();
				inventoryContribution.setCreated_by(userId);
				if(!StringUtils.isEmpty(inventoryContribution.getMediaList())) {
					MultipartFile multipartFile = inventoryContribution.getMediaList();
					if (null != multipartFile && !multipartFile.isEmpty()) {
						String saveDirectory = CommonConstants.SAFETY_FILE_SAVING_PATH + "inventory" + File.separator;
						String fileName = multipartFile.getOriginalFilename();
						inventoryContribution.setUpload_file(fileName);
						//obj.setCreated_date(DateParser.parse(date));
						if (null != multipartFile && !multipartFile.isEmpty()) {
							FileUploads.singleFileSaving(multipartFile, saveDirectory, fileName);
						}
					}
				
				}
				flag = contributionService.addinventoryContribution(inventoryContribution);
				if(flag == true) {
					attributes.addFlashAttribute("success", "inventory Contribution Added Succesfully.");

				}
				else {
					attributes.addFlashAttribute("error","Adding inventory Contribution is failed. Try again.");
				}
			} catch (Exception e) {
				attributes.addFlashAttribute("error","Adding inventory Contribution is failed. Try again.");
				e.printStackTrace();
			}
			return model;
		}
	    @RequestMapping(value = "/inventory/update", method = {RequestMethod.GET,RequestMethod.POST})
		public ModelAndView updateinventoryContribution(@ModelAttribute inventoryContribution inventoryContribution,RedirectAttributes attributes,HttpSession session) {
	    	boolean flag = false;
			String userId = null;
			String userName = null;
			ModelAndView model = new ModelAndView();
			try {
				model.setViewName("redirect:/inventory");
				userId = (String) session.getAttribute("USER_ID");
				userName = (String) session.getAttribute("USER_NAME");
				DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd"); 
			    String dt = formatter.format(new Date());
				String endDate = DateForUser.date();
				if(!StringUtils.isEmpty(inventoryContribution.getMediaList())) {
					MultipartFile multipartFile = inventoryContribution.getMediaList();
					if (null != multipartFile && !multipartFile.isEmpty()) {
						String saveDirectory = CommonConstants.SAFETY_FILE_SAVING_PATH + "inventory" + File.separator;
						String fileName = multipartFile.getOriginalFilename();
						inventoryContribution.setUpload_file(fileName);
						//obj.setCreated_date(DateParser.parse(date));
						if (null != multipartFile && !multipartFile.isEmpty()) {
							FileUploads.singleFileSaving(multipartFile, saveDirectory, fileName);
						}
					}
				
				}
				
				
				flag = contributionService.updateinventoryContribution(inventoryContribution);
				if(flag == true) {
					attributes.addFlashAttribute("success", "inventory Contribution updated Succesfully.");
				}
				else {
					attributes.addFlashAttribute("error","updating inventory Contribution is failed. Try again.");
				}
			} catch (Exception e) {
				attributes.addFlashAttribute("error","updating inventory Contribution is failed. Try again.");
				e.printStackTrace();
			}
			return model;
	    }
}
