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
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
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

@Controller
public class FarController {

    private static final Logger logger = Logger.getLogger(FarController.class);

    @Autowired
    private FarContributionService contributionService;

    @Autowired
    private EsiContributionService contributionService1;

    private Gson gson = new Gson();

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

            // === CHANGE: Trim the PC string to avoid space-related mismatches ===
            if (pc != null) {
                pc = pc.trim();
            }

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
                    filter.getEntity_code(),
                    filter.getProfit_center_code(),
                    usr
            );
            model.addObject("farList", farList);

        } catch (Exception e) {
            logger.error("Error loading FAR page", e);
            e.printStackTrace();
        }
        return model;
    }

    // ========== NEW ENDPOINTS FOR EDIT FUNCTIONALITY ==========

    @RequestMapping(value = "/far/get/{id}", method = RequestMethod.GET)
    @ResponseBody
    public String getFarById(@PathVariable Long id) {
        try {
            logger.info("Fetching FAR record with ID: " + id);

            FarContribution farRecord = contributionService.getFarById(id);

            if (farRecord != null) {
                logger.info("Found FAR record: " + farRecord.getFar_id());
                return gson.toJson(new Response(true, "Record found", farRecord));
            } else {
                logger.warn("No FAR record found with ID: " + id);
                return gson.toJson(new Response(false, "Record not found", null));
            }

        } catch (Exception e) {
            logger.error("Error fetching FAR record by ID: " + id, e);
            return gson.toJson(new Response(false, "Error fetching record: " + e.getMessage(), null));
        }
    }

    @RequestMapping(value = "/far/delete/{id}", method = RequestMethod.DELETE)
    @ResponseBody
    public String deleteFarById(@PathVariable String id, HttpSession session) {
        try {
            logger.info("Deleting FAR record with ID: " + id);

            if (StringUtils.isEmpty(id)) {
                return gson.toJson(new Response(false, "Invalid ID provided", null));
            }

            String role = (String) session.getAttribute("ROLE");
            if (!"Admin".equals(role) && !"SA".equals(role)) {
                return gson.toJson(new Response(false, "Unauthorized: Only Admin or SA can delete records", null));
            }

            boolean isDeleted = contributionService.deleteFarById(id);

            if (isDeleted) {
                logger.info("Successfully deleted FAR record with ID: " + id);
                return gson.toJson(new Response(true, "Record deleted successfully", null));
            } else {
                logger.warn("Failed to delete FAR record with ID: " + id);
                return gson.toJson(new Response(false, "Failed to delete record", null));
            }

        } catch (Exception e) {
            logger.error("Error deleting FAR record by ID: " + id, e);
            return gson.toJson(new Response(false, "Error deleting record: " + e.getMessage(), null));
        }
    }

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
                    "has not been submitted for your Profit Center <b>" + in.getProfit_center_name() + "</b>.<br><br>" +
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
    public ModelAndView addFarContribution(@ModelAttribute FarContribution FarContribution, MultipartFile file, RedirectAttributes attributes, HttpSession session) {
        boolean flag = false;
        String userId = null;
        String userName = null;
        ModelAndView model = new ModelAndView();
        try {
            model.setViewName("redirect:/far");
            userId = (String) session.getAttribute("USER_ID");
            userName = (String) session.getAttribute("USER_NAME");
            DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
            String dt = formatter.format(new Date());
            String endDate = DateForUser.date();
            FarContribution.setCreated_by(userId);

            // === CHANGE: Trim profit_center_code before saving ===
            if (FarContribution.getProfit_center_code() != null) {
                FarContribution.setProfit_center_code(FarContribution.getProfit_center_code().trim());
            }

            String file_name = "";
            if(!StringUtils.isEmpty(FarContribution.getMediaList())) {
                for (int i = 0; i < (FarContribution.getMediaList().length); i++) {
                    MultipartFile multipartFile = FarContribution.getMediaList()[i];
                    if (null != multipartFile && !multipartFile.isEmpty()) {
                        String saveDirectory = CommonConstants.SAFETY_FILE_SAVING_PATH + "far" + File.separator;
                        String fileName = multipartFile.getOriginalFilename();
                        if (null != multipartFile && !multipartFile.isEmpty()) {
                            FileUploads.singleFileSaving(multipartFile, saveDirectory, fileName);
                        }
                        file_name = file_name + fileName + ",";
                    }
                }
                if (!StringUtils.isEmpty(file_name)) {
                    FarContribution.setUploads(file_name.substring(0, file_name.length() - 1));
                }
            }

            flag = contributionService.addfarContribution(FarContribution);
            if(flag == true) {
                attributes.addFlashAttribute("success", "FAR Contribution Added Successfully.");
            } else {
                attributes.addFlashAttribute("error", "Adding FAR Contribution failed. Try again.");
            }
        } catch (Exception e) {
            attributes.addFlashAttribute("error", "Adding FAR Contribution failed. Try again.");
            logger.error("Error adding FAR contribution", e);
        }
        return model;
    }

    // Update existing FAR contribution
    @RequestMapping(value = "/far/update", method = {RequestMethod.GET, RequestMethod.POST})
    public ModelAndView updateFarContribution(@ModelAttribute FarContribution FarContribution, RedirectAttributes attributes, HttpSession session) {
        boolean flag = false;
        String userId = null;
        String userName = null;
        ModelAndView model = new ModelAndView();
        try {
            model.setViewName("redirect:/far");
            userId = (String) session.getAttribute("USER_ID");
            userName = (String) session.getAttribute("USER_NAME");
            DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
            String dt = formatter.format(new Date());
            String endDate = DateForUser.date();

            // === CHANGE: Trim profit_center_code before updating ===
            if (FarContribution.getProfit_center_code() != null) {
                FarContribution.setProfit_center_code(FarContribution.getProfit_center_code().trim());
            }

            String file_name = "";
            if(!StringUtils.isEmpty(FarContribution.getMediaList())) {
                for (int i = 0; i < (FarContribution.getMediaList().length); i++) {
                    MultipartFile multipartFile = FarContribution.getMediaList()[i];
                    if (null != multipartFile && !multipartFile.isEmpty()) {
                        String saveDirectory = CommonConstants.SAFETY_FILE_SAVING_PATH + "far" + File.separator;
                        String fileName = multipartFile.getOriginalFilename();
                        if (null != multipartFile && !multipartFile.isEmpty()) {
                            FileUploads.singleFileSaving(multipartFile, saveDirectory, fileName);
                        }
                        file_name = file_name + fileName + ",";
                    }
                }
                if (!StringUtils.isEmpty(file_name)) {
                    String existingFiles = FarContribution.getUploads();
                    if (!StringUtils.isEmpty(existingFiles)) {
                        file_name = existingFiles + "," + file_name;
                    }
                    FarContribution.setUploads(file_name.substring(0, file_name.length() - 1));
                }
            }

            flag = contributionService.updatefarContribution(FarContribution);
            if(flag == true) {
                attributes.addFlashAttribute("success", "FAR Contribution Updated Successfully.");
            } else {
                attributes.addFlashAttribute("error", "Updating FAR Contribution failed. Try again.");
            }
        } catch (Exception e) {
            attributes.addFlashAttribute("error", "Updating FAR Contribution failed. Try again.");
            logger.error("Error updating FAR contribution", e);
        }
        return model;
    }

    // ========== HELPER CLASSES ==========

    class Response {
        private boolean success;
        private String message;
        private Object data;

        public Response(boolean success, String message, Object data) {
            this.success = success;
            this.message = message;
            this.data = data;
        }

        public boolean isSuccess() { return success; }
        public void setSuccess(boolean success) { this.success = success; }

        public String getMessage() { return message; }
        public void setMessage(String message) { this.message = message; }

        public Object getData() { return data; }
        public void setData(Object data) { this.data = data; }
    }
}