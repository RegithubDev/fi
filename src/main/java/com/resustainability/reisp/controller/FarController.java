package com.resustainability.reisp.controller;

import java.io.File;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.stereotype.Controller;  // Changed from @RestController
import org.springframework.util.StringUtils;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.resustainability.reisp.common.DateForUser;
import com.resustainability.reisp.common.EMailSender;
import com.resustainability.reisp.common.FileUploads;
import com.resustainability.reisp.common.Mail;
import com.resustainability.reisp.constants.CommonConstants;
import com.resustainability.reisp.constants.PageConstants;
import com.resustainability.reisp.model.EsiContribution;
import com.resustainability.reisp.model.User;
import com.resustainability.reisp.model.FarContribution;
import com.resustainability.reisp.service.EsiContributionService;
import com.resustainability.reisp.service.FarContributionService;

@Controller  // Important: Use @Controller, not @RestController
public class FarController {

    private static final Logger logger = Logger.getLogger(FarController.class);

    @Autowired
    private FarContributionService contributionService;

    @Autowired
    private EsiContributionService contributionService1;

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(String.class, new StringTrimmerEditor(true));
    }

    // Main FAR page - GET/POST
    @RequestMapping(value = "/far", method = {RequestMethod.GET, RequestMethod.POST})
    public ModelAndView farPage(@ModelAttribute FarContribution filter, HttpSession session) {
        ModelAndView model = new ModelAndView(PageConstants.far);

        try {
            String role = (String) session.getAttribute("ROLE");
            String pc = (String) session.getAttribute("PC");

            User usr = new User();
            usr.setRole(role);
            usr.setProfit_center_code(pc);

            // Dropdown data
            List<EsiContribution> entityList = contributionService1.geteList();
            List<EsiContribution> profitCenterList = contributionService1.getpList();

            model.addObject("eList", entityList);
            model.addObject("profitCenterList", profitCenterList);

            // FAR data list based on filters
            List<FarContribution> farList = contributionService.getFarContributions(
                    filter.getMonth_year(),
                    filter.getEntity_Code(),
                    filter.getProfit_Center_Code(),
                    usr
            );
            model.addObject("farList", farList);

        } catch (Exception e) {
            logger.error("Error loading FAR page", e);
            e.printStackTrace();
        }
        return model;
    }

    // Trigger email alert
    @RequestMapping(value = "/triggerAlertfar", method = RequestMethod.GET)
    public ModelAndView triggerAlertfar(HttpServletRequest request, @ModelAttribute FarContribution in, HttpSession session) {
        ModelAndView model = new ModelAndView("redirect:/far");

        try {
            String emailTo = in.getEmail_id();
            if (StringUtils.isEmpty(emailTo)) {
                return model;
            }

            EMailSender emailSender = new EMailSender();
            Mail mail = new Mail();
            mail.setMailTo(emailTo);
            mail.setMailSubject("Finance | Gentle Reminder | Re Sustainability");

            String msg = "";
            if (!StringUtils.isEmpty(in.getMessage())) {
                msg = "<b>Appeal Message:</b><br>" +
                      "<blockquote style='border-left:3px solid #ccc; margin:10px 0; padding:10px; background:#f9f9f9;'>" +
                      in.getMessage() + "</blockquote><br>";
            }

            String body = "Dear User,<br><br>" +
                    "This is a kind reminder from <b>Re Sustainability Finance Team</b>.<br><br>" +
                    "Our records indicate that the <b>FAR data for " + in.getMonth_year() + "</b> " +
                    "has not been submitted for your Profit Center <b>" + in.getProfit_Center_Name() + "</b>.<br><br>" +
                    "As per the reporting guidelines, it is mandatory to complete the FAR update by the due date.<br>" +
                    "Please update the records at the earliest to avoid any compliance issues.<br><br>" +
                    "You can update your FAR using the <a href='https://appmint.resustainability.com/fi/far' target='_blank'>Finance App</a>.<br><br>" +
                    msg +
                    "If you have already submitted the data, kindly ignore this message.<br><br>" +
                    "Thanks & Regards,<br>" +
                    "<b>Finance Team</b><br>" +
                    "<b>Re Sustainability</b>";

            emailSender.sendAlertSingle(emailTo, mail.getMailSubject(), body, emailTo, "Acknowledgment!");
        } catch (Exception e) {
            logger.error("Error sending FAR alert email", e);
        }

        return model;
    }

    // Add new FAR contribution
    @RequestMapping(value = "/far/add", method = {RequestMethod.GET, RequestMethod.POST})
    public ModelAndView addfarContribution(@ModelAttribute FarContribution farContribution,
                                           RedirectAttributes attributes,
                                           HttpSession session) {
        ModelAndView model = new ModelAndView("redirect:/far");

        try {
            String userId = (String) session.getAttribute("USER_ID");
            String userName = (String) session.getAttribute("USER_NAME");

            farContribution.setCreated_by(userId);

            // Handle multiple file uploads
            handleFileUploads(farContribution);

            boolean flag = contributionService.addfarContribution(farContribution);

            if (flag) {
                attributes.addFlashAttribute("success", "FAR Contribution Added Successfully.");
            } else {
                attributes.addFlashAttribute("error", "Adding FAR Contribution failed. Try again.");
            }
        } catch (Exception e) {
            logger.error("Error adding FAR contribution", e);
            attributes.addFlashAttribute("error", "Adding FAR Contribution failed. Try again.");
        }
        return model;
    }

    // Update existing FAR contribution
    @RequestMapping(value = "/far/update", method = {RequestMethod.GET, RequestMethod.POST})
    public ModelAndView updatefarContribution(@ModelAttribute FarContribution farContribution,
                                              RedirectAttributes attributes,
                                              HttpSession session) {
        ModelAndView model = new ModelAndView("redirect:/far");

        try {
            String userId = (String) session.getAttribute("USER_ID");
            farContribution.setModified_by(userId);

            // Handle file uploads during update
            handleFileUploads(farContribution);

            boolean flag = contributionService.updatefarContribution(farContribution);

            if (flag) {
                attributes.addFlashAttribute("success", "FAR Contribution Updated Successfully.");
            } else {
                attributes.addFlashAttribute("error", "Updating FAR Contribution failed. Try again.");
            }
        } catch (Exception e) {
            logger.error("Error updating FAR contribution", e);
            attributes.addFlashAttribute("error", "Updating FAR Contribution failed. Try again.");
        }
        return model;
    }

    // Helper method to handle multiple file uploads
    private void handleFileUploads(FarContribution farContribution) {
        if (farContribution.getMediaList() == null || farContribution.getMediaList().length == 0) {
            return;
        }

        StringBuilder fileNames = new StringBuilder();
        String saveDirectory = CommonConstants.SAFETY_FILE_SAVING_PATH + "far" + File.separator;

        for (MultipartFile file : farContribution.getMediaList()) {
            if (file != null && !file.isEmpty()) {
                String fileName = file.getOriginalFilename();
                try {
                    FileUploads.singleFileSaving(file, saveDirectory, fileName);
                    if (fileNames.length() > 0) fileNames.append(",");
                    fileNames.append(fileName);
                } catch (Exception e) {
                    logger.error("Error saving file: " + fileName, e);
                }
            }
        }

        if (fileNames.length() > 0) {
            farContribution.setUploads(fileNames.toString());
        }
    }
}