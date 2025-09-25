package com.resustainability.reisp.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.resustainability.reisp.common.CommonMethods;
import com.resustainability.reisp.common.DateForUser;
import com.resustainability.reisp.constants.PageConstants;
import com.resustainability.reisp.model.PfContribution;
import com.resustainability.reisp.model.User;
import com.resustainability.reisp.service.ContributionService;
import com.resustainability.reisp.service.UserService;
import com.resustainability.reisp.controller.LoginController;
import com.resustainability.reisp.dao.UserDao;
@Controller
public class LoginController {
	@InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(String.class, new StringTrimmerEditor(true));
    } 
	Logger logger = Logger.getLogger(LoginController.class);
	@Autowired
	UserService service;
	
	@Autowired
	UserService service2;
	
	
	@Value("${Logout.Message}")
	private String logOutMessage;
	
	@Value("${Login.Form.Invalid}")
	public String invalidUserName;
	
	
	@Value("${common.error.message}")
	public String commonError;
	
	
	 @Autowired
	    private ContributionService contributionService;
	 
	@RequestMapping(value = "/", method = {RequestMethod.POST, RequestMethod.GET})
	public ModelAndView basePage(@ModelAttribute User user, HttpSession session,HttpServletRequest request) {
		ModelAndView model = new ModelAndView(PageConstants.login);
		try {
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return model;
	}
	@RequestMapping(value = "/proxy", method = {RequestMethod.POST, RequestMethod.GET})
	public ModelAndView proxy(@ModelAttribute User user, HttpSession session,HttpServletRequest request) {
		return new ModelAndView(PageConstants.proxy);
	}
	
	@RequestMapping(value = "/login", method = {RequestMethod.POST, RequestMethod.GET})
	public ModelAndView login(@ModelAttribute User user, HttpSession session,HttpServletRequest request,RedirectAttributes attributes) {
		ModelAndView model = new ModelAndView(PageConstants.login);
		User userDetails = null;
		try {
			if(!StringUtils.isEmpty(user) && !StringUtils.isEmpty(user.getEmail_id())){
				userDetails = service.validateUser(user);
				if(!StringUtils.isEmpty(userDetails)) {
					//if((userDetails.getSession_count()) == 0) {
						model.setViewName("redirect:/fi-d26827851841284wjvwunfuqwhfbwqr7212hfu");
				//		User permisions = service.getAllPermissions(userDetails.getBase_role());
						/// USER PERMISISONS
					
						session.setAttribute("user", userDetails);
						session.setAttribute("ID", userDetails.getId());
						session.setAttribute("USER_ID", userDetails.getUser_id());
						session.setAttribute("USER_EMAIL", userDetails.getEmail_id());
						session.setAttribute("ROLE", userDetails.getRole());
						session.setAttribute("PC", userDetails.getProfit_center_code());
						session.setAttribute("SBU", userDetails.getEntity_code());
						session.setAttribute("PCN", userDetails.getProfit_center_name());
					
					//	List<User> menuList = service.getMenuList();
						//session.setAttribute("menuList", menuList);
						attributes.addFlashAttribute("welcome", "welcome ");
					//}else {
						//session.invalidate();
						//model.addObject("multipleLoginFound","Multiple Login found! You have been Logged out from all Devices");
						//model.setViewName(PageConstants.login); 
					//}
				}else {
					List<PfContribution> pList = contributionService.getpList();
					model.addObject("profitCenterList", pList);
					model.addObject("email", user.getEmail_id());
					model.setViewName(PageConstants.newUserLogin);
				}
			}else {
				model.addObject("message", "");
				model.setViewName(PageConstants.login);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return model; 
	}
	
	@RequestMapping(value = "/add-new-user-form", method = {RequestMethod.GET,RequestMethod.POST})
	public ModelAndView addUserForm(@ModelAttribute User obj,RedirectAttributes attributes,HttpSession session) {
		boolean flag = false;
		String userId = null;
		String userName = null;
		ModelAndView model = new ModelAndView();
		try {
			model.setViewName(PageConstants.newUserLogin);
			
			
			List<User> userList = service.getUserFilterList(null);
			model.addObject("userList", userList);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return model;
	}
	
	@RequestMapping(value = "/add-new-user", method = {RequestMethod.GET,RequestMethod.POST})
	public ModelAndView addUserFormMaster(@ModelAttribute User obj,RedirectAttributes attributes,HttpSession session) {
		boolean flag = false;
		String userId = null;
		String userName = null;
		User userDetails = null;
		ModelAndView model = new ModelAndView();
		try {
			model.setViewName("redirect:/login");
			userId = (String) session.getAttribute("USER_ID");
			userName = (String) session.getAttribute("USER_NAME");
			obj.setStatus("Active");
			obj.setRole("User");
			DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd"); 
		    String dt = formatter.format(new Date());
			String endDate = DateForUser.date();
			flag = service.addUser(obj);
			if(flag == true) {
				//attributes.addFlashAttribute("success", "User Added Succesfully.");
				userDetails = service.validateUser(obj);
				if(!StringUtils.isEmpty(userDetails)) {
					//if((userDetails.getSession_count()) == 0) {
						model.setViewName("redirect:/fi-d26827851841284wjvwunfuqwhfbwqr7212hfu");
						session.setAttribute("user", userDetails);
						session.setAttribute("ID", userDetails.getId());
						session.setAttribute("USER_ID", userDetails.getUser_id());
						session.setAttribute("USER_EMAIL", userDetails.getEmail_id());
						session.setAttribute("ROLE", userDetails.getRole());
						session.setAttribute("PC", userDetails.getProfit_center_code());
						session.setAttribute("PCN", userDetails.getProfit_center_name());
					//}else {
						//session.invalidate();
						//model.addObject("multipleLoginFound","Multiple Login found! You have been Logged out from all Devices");
						//model.setViewName(PageConstants.login); 
					//}
				}else{
					model.addObject("invalidEmail",invalidUserName);
					model.setViewName(PageConstants.newUserLogin);
				}
				
			}
			else {
				attributes.addFlashAttribute("error","Adding User is failed. Try again.");
			}
		} catch (Exception e) {
			attributes.addFlashAttribute("error","Adding User is failed. Try again.");
			e.printStackTrace();
		}
		return model;
	}
	
	@RequestMapping(value = "/logout", method = {RequestMethod.GET,RequestMethod.POST})
	public ModelAndView logout(HttpSession session,HttpServletRequest request,HttpServletResponse response,RedirectAttributes attributes){
		ModelAndView model = new ModelAndView();
		User user = new User();
		try {
			user.setUser_id((String) session.getAttribute("USER_ID"));
			user.setId((String) session.getAttribute("ID"));
			//service.UserLogOutActions(user);
			session.invalidate();
			//model.addObject("success", logOutMessage);
			model.setViewName("redirect:/login");
		} catch (Exception e) {
			logger.fatal("logut() : "+e.getMessage());
		}
		return model;
	}
	
		
}
