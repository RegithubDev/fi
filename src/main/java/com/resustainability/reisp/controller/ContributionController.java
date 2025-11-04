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
import com.resustainability.reisp.common.EMailSender;
import com.resustainability.reisp.common.FileUploads;
import com.resustainability.reisp.common.Mail;
import com.resustainability.reisp.constants.CommonConstants;
import com.resustainability.reisp.constants.PageConstants;
import com.resustainability.reisp.model.EMail;
import com.resustainability.reisp.model.EsiContribution;
import com.resustainability.reisp.model.PfContribution;
import com.resustainability.reisp.model.User;
import com.resustainability.reisp.service.ContributionService;

@RestController
public class ContributionController {
	 
		@InitBinder
	    public void initBinder(WebDataBinder binder) {
	        binder.registerCustomEditor(String.class, new StringTrimmerEditor(true));
	    } 
		Logger logger = Logger.getLogger(ContributionController.class);
	
	 @Autowired
	    private ContributionService contributionService;

	 @RequestMapping(value = "/pf", method = {RequestMethod.POST, RequestMethod.GET})
		public ModelAndView department(@ModelAttribute PfContribution user, HttpSession session) {
			ModelAndView model = new ModelAndView(PageConstants.pf);
			try {
				String role = (String) session.getAttribute("ROLE");
				String pc = (String) session.getAttribute("PC");
				User usr = new User();
				usr.setRole(role);
				List<PfContribution> eList = contributionService.geteList();
				model.addObject("eList", eList);
				usr.setProfit_center_code(pc);
				List<PfContribution> pList = contributionService.getpList();
				model.addObject("profitCenterList", pList);
				
				List<PfContribution> pfList = contributionService.getPfContributions(user.getMonth_year(), user.getEntity_code(), user.getProfit_center_code(),usr);
				model.addObject("pfList", pfList);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return model;
		}
	
	 @RequestMapping(value = "/appealRecord", method = RequestMethod.GET)
	 public ModelAndView appealRecord(@RequestParam("period") String period,@RequestParam("pcn") String pcn,
			 EMail email,RedirectAttributes attributes,HttpSession session,@RequestParam("admin") String admin,@RequestParam("msg") String msg) {
		 	boolean flag = false;
			String userId = null;
			String userName = null;
			ModelAndView model = new ModelAndView();
		 try {	
				model.setViewName("redirect:/inventory");
			 String emailTo = (String) session.getAttribute("USER_EMAIL");
			 	userId = (String) session.getAttribute("USER_ID");
				userName = (String) session.getAttribute("USER_EMAIL");
				DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd"); 
			 EMailSender emailSender = new EMailSender();
			 Mail mail = new Mail();
			mail.setMailTo(admin);
			mail.setMailSubject("Finance | Appeal chnage Request | Re Sustainability");
			String body = "Dear Admin,<br><br>"
				    + "Greetings from <b>Re Sustainability</b>.<br><br>"
				    + "User <b>" + userName + "</b> has submitted an <b>Appeal Request</b> for the period <b>" + period + "</b> "
				    + "related to <b>" + pcn + "</b>.<br><br>"
				    + "<b>Appeal Message:</b><br>"
				    + "<blockquote style='border-left:3px solid #ccc; margin:10px 0; padding:10px; background:#f9f9f9;'>"
				    + msg
				    + "</blockquote><br>"
				    + "We kindly request you to review and complete this request at the earliest.<br><br>"
				    + "Thank you,<br><br>"
				    + "<p style='color:red; font-weight:bold; margin:0;'>Finance Team</p>"
				    + "<b>Re Sustainability</b>";

			String subject = "Acknowledgment!";
			emailSender.send(mail.getMailTo(), mail.getMailSubject(), body,email,subject);
		} catch (Exception e) {
			// TODO: handle exception
		}
		 
	     return model; // Redirect after processing
	 }
		@RequestMapping(value = "/add-pf", method = {RequestMethod.GET,RequestMethod.POST})
		public ModelAndView addPfContribution(@ModelAttribute PfContribution pfContribution,RedirectAttributes attributes,HttpSession session) {
			boolean flag = false;
			String userId = null;
			String userName = null;
			ModelAndView model = new ModelAndView();
			try {
				model.setViewName("redirect:/pf");
				userId = (String) session.getAttribute("USER_ID");
				userName = (String) session.getAttribute("USER_NAME");
				DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd"); 
			    String dt = formatter.format(new Date());
				String endDate = DateForUser.date();
				pfContribution.setCreated_by(userId);
				String file_name = "";
				if(!StringUtils.isEmpty(pfContribution.getMediaList())) {
					for (int i = 0; i < (pfContribution.getMediaList().length); i++) {
						MultipartFile multipartFile = pfContribution.getMediaList()[i];
						if (null != multipartFile && !multipartFile.isEmpty()) {
							String saveDirectory = CommonConstants.SAFETY_FILE_SAVING_PATH + "pf" + File.separator;
							String fileName = multipartFile.getOriginalFilename();
							pfContribution.setUpload_file(fileName);
							if (null != multipartFile && !multipartFile.isEmpty()) {
								FileUploads.singleFileSaving(multipartFile, saveDirectory, fileName);
							}
							file_name = file_name+ fileName+",";
							pfContribution.setUpload_file(file_name);
						}
					}
				}
				
				
				
				flag = contributionService.addPfContribution(pfContribution);
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
	    @RequestMapping(value = "/update-pf", method = {RequestMethod.GET,RequestMethod.POST})
		public ModelAndView updatePfContribution(@ModelAttribute PfContribution pfContribution,RedirectAttributes attributes,HttpSession session) {
	    	boolean flag = false;
			String userId = null;
			String userName = null;
			ModelAndView model = new ModelAndView();
			try {
				model.setViewName("redirect:/pf");
				userId = (String) session.getAttribute("USER_ID");
				userName = (String) session.getAttribute("USER_NAME");
				DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd"); 
			    String dt = formatter.format(new Date());
				String endDate = DateForUser.date();
				String file_name = "";
				if(!StringUtils.isEmpty(pfContribution.getMediaList())) {
					for (int i = 0; i < (pfContribution.getMediaList().length); i++) {
						MultipartFile multipartFile = pfContribution.getMediaList()[i];
						if (null != multipartFile && !multipartFile.isEmpty()) {
							String saveDirectory = CommonConstants.SAFETY_FILE_SAVING_PATH + "pf" + File.separator;
							String fileName = multipartFile.getOriginalFilename();
							pfContribution.setUpload_file(fileName);
							if (null != multipartFile && !multipartFile.isEmpty()) {
								FileUploads.singleFileSaving(multipartFile, saveDirectory, fileName);
							}
							file_name = file_name+ fileName+",";
							pfContribution.setUpload_file(file_name);
						}
					}
				}
				
				
				flag = contributionService.updatePfContribution(pfContribution);
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
