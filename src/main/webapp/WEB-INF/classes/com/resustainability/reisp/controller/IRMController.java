package com.resustainability.reisp.controller;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Set;
import java.util.TreeMap;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.ss.util.WorkbookUtil;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFColor;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.http.MediaType;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.resustainability.reisp.common.DateParser;
import com.resustainability.reisp.constants.PageConstants;
import com.resustainability.reisp.dao.IRMDao;
import com.resustainability.reisp.model.Att;
import com.resustainability.reisp.model.IRM;
import com.resustainability.reisp.model.IRMPaginationObject;
import com.resustainability.reisp.model.PunchRecord;
import com.resustainability.reisp.model.RawPunch;
import com.resustainability.reisp.model.Shift;
import com.resustainability.reisp.model.User;
import com.resustainability.reisp.model.UserPaginationObject;
import com.resustainability.reisp.service.IRMService;
import com.resustainability.reisp.service.IRMService;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.InputStream;
@RestController
public class IRMController {

	@InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(String.class, new StringTrimmerEditor(true));
    }
	Logger logger = Logger.getLogger(IRMController.class);
	
	@Autowired
	IRMService service;
	
	@Value("${common.error.message}")
	public String commonError;
	
	@Value("${record.dataexport.success}")
	public String dataExportSucess;
	
	@Value("${record.dataexport.invalid.directory}")
	public String dataExportInvalid;
	
	@Value("${record.dataexport.error}")
	public String dataExportError;
	
	@Value("${record.dataexport.nodata}")
	public String dataExportNoData;
	
	@Value("${template.upload.common.error}")
	public String uploadCommonError;
	
	@Value("${template.upload.formatError}")
	public String uploadformatError;
	
	
	@RequestMapping(value = "/att", method = {RequestMethod.POST, RequestMethod.GET})
	public ModelAndView irm(@ModelAttribute User user,IRM obj, HttpSession session) {
		ModelAndView model = new ModelAndView(PageConstants.irmMain);
		String userId = null;
		String userName = null;
		String role = null;
		try {
			userId = (String) session.getAttribute("USER_ID");
			userName = (String) session.getAttribute("USER_NAME");
			role = (String) session.getAttribute("BASE_ROLE");
			obj.setUser(userId);
			obj.setRole(role);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return model;
	}
	
	@RequestMapping(value = "/api/regularisePunch", method = {RequestMethod.POST, RequestMethod.GET})
	public ModelAndView regularisePunch(@ModelAttribute List<Att> attendanceList, RedirectAttributes attributes,HttpSession session) {
		boolean flag = false;
		String userId = null;
		String userName = null;
		ModelAndView model = new ModelAndView();
		try {
			model.setViewName("redirect:/att");
			userId = (String) session.getAttribute("USER_ID");
			userName = (String) session.getAttribute("USER_NAME");
			Att obj = new Att();
			obj.setUser_id(userId);
			obj.setUser_name(userName);
			obj.setAction_by(userId);
			//flag = service.regularizeAction(attendanceList,obj);
			if(flag == true) {
				attributes.addFlashAttribute("success", "Action Succesfully Executed!.");
			}
			else {
				attributes.addFlashAttribute("error"," Action is failed. Try again.");
			}
		} catch (Exception e) {
			attributes.addFlashAttribute("error"," Action is failed. Try again.");
			e.printStackTrace();
		}
		return model;
	}
	
	
	@RequestMapping(value = "/ajax/getEmployeeAttendance", method = {RequestMethod.GET,RequestMethod.POST},produces=MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public List<Att> getEmployeeAttendance(@ModelAttribute Att obj,HttpSession session) {
		List<Att> companiesList = null;
		String userId = null;
		String userName = null;
		String role = null;
		try {
			userId = (String) session.getAttribute("USER_ID");
			userName = (String) session.getAttribute("USER_NAME");
			role = (String) session.getAttribute("BASE_ROLE");
			obj.setUser(userId);
			obj.setRole(role);
			obj.setFrom_date(DateParser.parse(obj.getFrom_date()));
			obj.setTo_date(DateParser.parse(obj.getTo_date()));
			companiesList = service.getEmployeeAttendance1(obj, obj.getFrom_date(), obj.getTo_date(), obj.getEmp_code(), obj.getArea_name());

		//companiesList = service.getEmployeeAttendance(obj, obj.getFrom_date(), obj.getTo_date(), obj.getEmp_code(), obj.getArea_name());
			 // Step 1: Fetch raw data from DB
		  //  List<PunchRecord> rawPunches = service.getRawPunches(obj.getFrom_date(), obj.getTo_date(), obj.getEmp_code(), obj.getArea_name());

		  //  processPunches(rawPunches);
		}catch (Exception e) {
			e.printStackTrace();
			logger.error("getIRMList : " + e.getMessage());
		}
		return companiesList;
	}
	
	@RequestMapping(value = "/upload-excel", method = {RequestMethod.GET,RequestMethod.POST},produces=MediaType.APPLICATION_JSON_VALUE)
    public String handleExcelUpload(@RequestParam("file") MultipartFile file,HttpSession session) {

		List<Map<String, String>> attendanceList = new ArrayList<>();
		   String userId = null;
   			String userName = null;
           userId = (String) session.getAttribute("USER_ID");
			userName = (String) session.getAttribute("USER_NAME");
			Att obj = new Att();
			obj.setUser_id(userId);
			obj.setUser_name(userName);
			obj.setAction_by(userId);
	    try (InputStream is = file.getInputStream(); Workbook workbook = new XSSFWorkbook(is)) {
	        Sheet sheet = workbook.getSheetAt(0);

	        for (int i = 2; i <= sheet.getLastRowNum(); i++) { // Start from row 3
	            Row row = sheet.getRow(i);
	            if (row == null) continue;

	            Map<String, String> data = new HashMap<>();
	            data.put("emp_code", getCellValue(row.getCell(0)));
	            data.put("employee_name", getCellValue(row.getCell(1)));
	            data.put("position_name", getCellValue(row.getCell(2)));
	            data.put("area_name", getCellValue(row.getCell(3)));
	            data.put("work_date", getCellValue(row.getCell(4)));
	            data.put("day_start", getCellValue(row.getCell(5)));
	            data.put("day_end", getCellValue(row.getCell(6)));
	            data.put("attendance_status", getCellValue(row.getCell(7)));
	            data.put("total_working_hours", getCellValue(row.getCell(8)));
	            data.put("total_minutes", getCellValue(row.getCell(9)));
	            data.put("total_hours", getCellValue(row.getCell(10)));
	            data.put("overtime_hours", getCellValue(row.getCell(11)));
	            data.put("overtime_minutes", getCellValue(row.getCell(12)));

	            // Add default fields
	            data.put("site_name",  getCellValue(row.getCell(3)));
	            data.put("is_holiday", "0");
	            data.put("holiday_reason", "");
	            data.put("action_by", userId);
	

	            attendanceList.add(data);
	        }
             
                service.regularizeAction(attendanceList,obj);
        } catch (Exception e) {
            e.printStackTrace();
            return "Error";
        }
			return "Success";
    }
	
	private String getCellValue(Cell cell) {
	    if (cell == null) return "";
	    cell.setCellType(CellType.STRING);
	    return cell.getStringCellValue().trim();
	}
	
	@RequestMapping(value = "/export-irm", method = {RequestMethod.GET,RequestMethod.POST})
	public void exportIRM(HttpServletRequest request, HttpServletResponse response,HttpSession session,@ModelAttribute IRM obj,RedirectAttributes attributes){
		ModelAndView view = new ModelAndView(PageConstants.irmMain);
		List<IRM> dataList = new ArrayList<IRM>();
		String userId = null;String userName = null;
		try {
			userId = (String) session.getAttribute("USER_ID");userName = (String) session.getAttribute("USER_NAME");
			view.setViewName("redirect:/irm");
			if(!StringUtils.isEmpty(obj.getFrom_and_to())) {
				if(obj.getFrom_and_to().contains("to")) {
					String [] dates = obj.getFrom_and_to().split("to");
					obj.setFrom_date(dates[0].trim());
					obj.setTo_date(dates[1].trim());
				}else {
					obj.setFrom_date(obj.getFrom_and_to());
				}
			}
			//dataList = service.getIRMList(obj); 
			if(dataList != null && dataList.size() > 0){
	            XSSFWorkbook  workBook = new XSSFWorkbook ();
	            XSSFSheet sheet = workBook.createSheet(WorkbookUtil.createSafeSheetName("IRM"));
		        workBook.setSheetOrder(sheet.getSheetName(), 0);
		        
		        byte[] blueRGB = new byte[]{(byte)0, (byte)176, (byte)240};
		        byte[] yellowRGB = new byte[]{(byte)255, (byte)192, (byte)0};
		        byte[] greenRGB = new byte[]{(byte)146, (byte)208, (byte)80};
		        byte[] redRGB = new byte[]{(byte)255, (byte)0, (byte)0};
		        byte[] whiteRGB = new byte[]{(byte)255, (byte)255, (byte)255};
		        
		        boolean isWrapText = true;boolean isBoldText = true;boolean isItalicText = false; int fontSize = 11;String fontName = "Times New Roman";
		        CellStyle blueStyle = cellFormating(workBook,blueRGB,HorizontalAlignment.CENTER,VerticalAlignment.CENTER,isWrapText,isBoldText,isItalicText,fontSize,fontName);
		        CellStyle yellowStyle = cellFormating(workBook,yellowRGB,HorizontalAlignment.CENTER,VerticalAlignment.CENTER,isWrapText,isBoldText,isItalicText,fontSize,fontName);
		        CellStyle greenStyle = cellFormating(workBook,greenRGB,HorizontalAlignment.CENTER,VerticalAlignment.CENTER,isWrapText,isBoldText,isItalicText,fontSize,fontName);
		        CellStyle redStyle = cellFormating(workBook,redRGB,HorizontalAlignment.CENTER,VerticalAlignment.CENTER,isWrapText,isBoldText,isItalicText,fontSize,fontName);
		        CellStyle whiteStyle = cellFormating(workBook,whiteRGB,HorizontalAlignment.CENTER,VerticalAlignment.CENTER,isWrapText,isBoldText,isItalicText,fontSize,fontName);
		        
		        CellStyle indexWhiteStyle = cellFormating(workBook,whiteRGB,HorizontalAlignment.LEFT,VerticalAlignment.CENTER,isWrapText,isBoldText,isItalicText,fontSize,fontName);
		        
		        isWrapText = true;isBoldText = false;isItalicText = false; fontSize = 9;fontName = "Times New Roman";
		        CellStyle sectionStyle = cellFormating(workBook,whiteRGB,HorizontalAlignment.LEFT,VerticalAlignment.CENTER,isWrapText,isBoldText,isItalicText,fontSize,fontName);
		        
		        
	            XSSFRow headingRow = sheet.createRow(0);
	        	String headerString = "Incident Code,SBU,Project,Department,Description,Level,Status,Risk,Date,Raised By" + 
	    				"";
	            String[] firstHeaderStringArr = headerString.split("\\,");
	            
	            for (int i = 0; i < firstHeaderStringArr.length; i++) {		        	
		        	Cell cell = headingRow.createCell(i);
			        cell.setCellStyle(greenStyle);
					cell.setCellValue(firstHeaderStringArr[i]);
				}
	            
	            short rowNo = 1;
	            for (IRM obj1 : dataList) {
	                XSSFRow row = sheet.createRow(rowNo);
	                int c = 0;
	            
	                Cell cell = row.createCell(c++);
					cell.setCellStyle(sectionStyle);
					cell.setCellValue(obj1.getDocument_code());
					
	                cell = row.createCell(c++);
					cell.setCellStyle(sectionStyle);
					cell.setCellValue (obj1.getSbu_code()+" - "+obj1.getSbu_name());
					
					cell = row.createCell(c++);
					cell.setCellStyle(sectionStyle);
					cell.setCellValue (obj1.getProject_code()+" - "+obj1.getProject_name());
					
					cell = row.createCell(c++);
					cell.setCellStyle(sectionStyle);
					cell.setCellValue (obj1.getDepartment_code()+" - "+obj1.getDepartment_name());
					
					cell = row.createCell(c++);
					cell.setCellStyle(sectionStyle);
					cell.setCellValue (obj1.getDescription());
					
					cell = row.createCell(c++);
					cell.setCellStyle(sectionStyle);
					cell.setCellValue (obj1.getApprover_type());
					
					cell = row.createCell(c++);
					cell.setCellStyle(sectionStyle);
					cell.setCellValue (obj1.getStatus());
					
					cell = row.createCell(c++);
					cell.setCellStyle(sectionStyle);
					cell.setCellValue (obj1.getRisk_type());
					
					cell = row.createCell(c++);
					cell.setCellStyle(sectionStyle);
					cell.setCellValue (obj1.getCreated_date());
					
					cell = row.createCell(c++);
					cell.setCellStyle(sectionStyle);
					cell.setCellValue (obj1.getCreated_by()+" - "+obj1.getUser_name());
					
	                rowNo++;
	            }
	            for(int columnIndex = 0; columnIndex < firstHeaderStringArr.length; columnIndex++) {
	        		sheet.setColumnWidth(columnIndex, 25 * 200);
	        		sheet.setColumnWidth(4, 100 * 200);
				}
                DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd-HHmmss");
                Date date = new Date();
                String fileName = "IRM_"+dateFormat.format(date);
                
	            try{
	                /*FileOutputStream fos = new FileOutputStream(fileDirectory +fileName+".xls");
	                workBook.write(fos);
	                fos.flush();*/
	            	
	               response.setContentType("application/.csv");
	 			   response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
	 			   response.setContentType("application/vnd.ms-excel");
	 			   // add response header
	 			   response.addHeader("Content-Disposition", "attachment; filename=" + fileName+".xlsx");
	 			   
	 			    //copies all bytes from a file to an output stream
	 			   workBook.write(response.getOutputStream()); // Write workbook to response.
		           workBook.close();
	 			    //flushes output stream
	 			    response.getOutputStream().flush();
	            	
	                
	                attributes.addFlashAttribute("success",dataExportSucess);
	            	//response.setContentType("application/vnd.ms-excel");
	            	//response.setHeader("Content-Disposition", "attachment; filename=filename.xls");
	            	//XSSFWorkbook  workbook = new XSSFWorkbook ();
	            	// ...
	            	// Now populate workbook the usual way.
	            	// ...
	            	//workbook.write(response.getOutputStream()); // Write workbook to response.
	            	//workbook.close();
	            }catch(FileNotFoundException e){
	                //e.printStackTrace();
	                attributes.addFlashAttribute("error",dataExportInvalid);
	            }catch(IOException e){
	                //e.printStackTrace();
	                attributes.addFlashAttribute("error",dataExportError);
	            }
         }else{
        	 attributes.addFlashAttribute("error",dataExportNoData);
         }
		}catch(Exception e){	
			e.printStackTrace();
			logger.error("exportCompany : : User Id - "+userId+" - User Name - "+userName+" - "+e.getMessage());
			attributes.addFlashAttribute("error", commonError);			
		}
		//return view;
	}
	

	private CellStyle cellFormating(XSSFWorkbook workBook,byte[] rgb,HorizontalAlignment hAllign, VerticalAlignment vAllign, boolean isWrapText,boolean isBoldText,boolean isItalicText,int fontSize,String fontName) {
		CellStyle style = workBook.createCellStyle();
		//Setting Background color  
		//style.setFillBackgroundColor(IndexedColors.AQUA.getIndex());
		style.setFillPattern(FillPatternType.SOLID_FOREGROUND);
		
		if (style instanceof XSSFCellStyle) {
		   XSSFCellStyle xssfcellcolorstyle = (XSSFCellStyle)style;
		   xssfcellcolorstyle.setFillForegroundColor(new XSSFColor(rgb, null));
		}
		//style.setFillPattern(FillPatternType.ALT_BARS);
		style.setBorderBottom(BorderStyle.MEDIUM);
		style.setBorderTop(BorderStyle.MEDIUM);
		style.setBorderLeft(BorderStyle.MEDIUM);
		style.setBorderRight(BorderStyle.MEDIUM);
		style.setAlignment(hAllign);
		style.setVerticalAlignment(vAllign);
		style.setWrapText(isWrapText);
		
		Font font = workBook.createFont();
        //font.setColor(HSSFColor.HSSFColorPredefined.WHITE.getIndex());
        font.setFontHeightInPoints((short)fontSize);  
        font.setFontName(fontName);  //"Times New Roman"
        
        font.setItalic(isItalicText); 
        font.setBold(isBoldText);
        // Applying font to the style  
        style.setFont(font); 
        
        return style;
	}
}
