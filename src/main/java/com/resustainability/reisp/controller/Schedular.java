package com.resustainability.reisp.controller;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.YearMonth;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.resustainability.reisp.common.EMailSender;
import com.resustainability.reisp.common.Mail;
import com.resustainability.reisp.model.EsiContribution;
import com.resustainability.reisp.model.IRM;
import com.resustainability.reisp.model.Pc;
import com.resustainability.reisp.service.EsiContributionService;
import com.resustainability.reisp.service.IRMService;
import com.resustainability.reisp.service.InventoryContributionService;


@Controller
public class Schedular {
	@InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(String.class, new StringTrimmerEditor(true));
    } 
	public static Logger logger = Logger.getLogger(Schedular.class);
	
	@Autowired
	LoginController loginController;
	
	@Autowired
	@Value("${common.error.message}")
	public String commonError;
	
	@Value("${run.cron.jobs}")
	public boolean is_cron_jobs_enabled;
	
	@Value("${run.cron.jobs.in.qa}")
	public boolean is_cron_jobs_enabled_in_qa;
	;
	 @Autowired
	  private InventoryContributionService inventoryService;
	 
	 
	 @Autowired
	    private EsiContributionService contributionService1;
	 
	 
	 @Scheduled(cron = "0 30 7 * * *")
	public void userLoginTimeout(){ if(is_cron_jobs_enabled || is_cron_jobs_enabled_in_qa) {
	  try { System.out.println("cronJob Called!!!!"); 
	  
	     LocalDate today = LocalDate.now();

	        // Only run after 4th of quarter start months (Jan, Apr, Jul, Oct)
	        if (!isQuarterReminderPeriod(today)) {
	        	System.out.println("not");
	            return;
	        }

	        YearMonth lastQuarter = getLastQuarter(YearMonth.from(today));
	        
	        List<EsiContribution> pcs = contributionService1.getUList();
	        int i = 0;
	        EMailSender emailSender = new EMailSender();
			 Mail mail = new Mail();
	        for (EsiContribution pc : pcs) {
	            boolean updated = inventoryService.isInventoryUpdatedForQuarter(pc.getProfit_center_code(), lastQuarter);
	            
	            		if (!updated) {
	            			System.out.println(lastQuarter);
	            			
	            			 String[] months = {"2025-03", "2025-06", "2025-09", "2025-12"};

	            		        if (pc.getResult().equalsIgnoreCase("No")) {
	            		            // Add your logic here for each month
	            		        
	            				mail.setMailTo(pc.getEmail_id());
		            			mail.setMailSubject("Finance | Gentle Reminder | Re Sustainability");
		            			String body = "Dear User,<br><br>" +
		            				    "This is a kind reminder from <b>Re Sustainability Finance Team</b>.<br><br>" +
		            				    "Our records indicate that the <b>Inventory data for " + pc.getMonth_year() + " (Quarter " + pc.getMonth_year() + ")</b> " +
		            				    "has not been submitted for your Profit Center <b>" + pc.getProfit_center_name() + "</b>.<br><br>" +
		            				    "As per the reporting guidelines, it is mandatory to complete the inventory update by the due date.<br>" +
		            				    "Please update the records at the earliest to avoid any compliance issues.<br><br>" +
		            				    "You can update your inventory using the <a href='https://appmint.resustainability.com/fi/' target='_blank'>Finance App</a>.<br><br>" +
		            				    "<b>Next Reminder:</b> A reminder email will continue to be sent daily at 8:00 AM until the submission is complete.<br><br>" +
		            				    "If you have already submitted the data, kindly ignore this message.<br><br>" +
		            				    "Thanks & Regards,<br>" +
		            				    "<b>Finance Team</b><br>" +
		            				    "<b>Re Sustainability</b>";


		            			String subject = "Acknowledgment!";
		            			emailSender.sendAlerts(mail.getMailTo(), mail.getMailSubject(), body,null,subject);
	            		        }
	            		
	            }
	        }} catch (Exception e) {
	  e.printStackTrace(); logger.error("userLoginTimeout() : "+e.getMessage()); }
	  } }
	 
	 private boolean isQuarterReminderPeriod(LocalDate today) {
		    int month = today.getMonthValue();
		    int day = today.getDayOfMonth();

		    // Quarter start months = Jan, Apr, Jul, Oct
		    if (month == 1 || month == 4 || month == 7 || month == 10) {
		        return day >= 4; // Run only from 4th day onwards
		    }
		    return false; // Do not run in other months
		}

	    private YearMonth getLastQuarter(YearMonth now) {
	        int month = now.getMonthValue();
	        if (month >= 1 && month <= 3) return YearMonth.of(now.getYear() - 1, 10); // Last Q3
	        else if (month >= 4 && month <= 6) return YearMonth.of(now.getYear(), 1);  // Last Q4
	        else if (month >= 7 && month <= 9) return YearMonth.of(now.getYear(), 4);  // Last Q1
	        else return YearMonth.of(now.getYear(), 7);                                // Last Q2
	    }
}
