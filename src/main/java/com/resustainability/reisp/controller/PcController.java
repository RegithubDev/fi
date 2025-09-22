package com.resustainability.reisp.controller;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.resustainability.reisp.model.Pc;
import com.resustainability.reisp.model.PcPaginationObject;
import com.resustainability.reisp.service.PcService;
import com.resustainability.reisp.constants.PageConstants;
import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFColor;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Controller
public class PcController {

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(String.class, new StringTrimmerEditor(true));
    }

    Logger logger = Logger.getLogger(PcController.class);

    @Autowired
    PcService service;

    @Value("${common.error.message}")
    public String commonError;

    @Value("${record.dataexport.success}")
    public String dataExportSuccess;

    @Value("${record.dataexport.invalid.directory}")
    public String dataExportInvalid;

    @Value("${record.dataexport.error}")
    public String dataExportError;

    @Value("${record.dataexport.nodata}")
    public String dataExportNoData;

    @RequestMapping(value = "/pc", method = {RequestMethod.POST, RequestMethod.GET})
    public ModelAndView pc(@ModelAttribute Pc pc, HttpSession session) {
        ModelAndView model = new ModelAndView(PageConstants.pc);
        try {
            String userId = (String) session.getAttribute("USER_ID");
            String userName = (String) session.getAttribute("USER_NAME");
            if (userId == null || userName == null) {
                throw new Exception("User session expired or invalid.");
            }
            List<Pc> pcList = service.getPcList(null, 0, Integer.MAX_VALUE, null);
            model.addObject("pcList", pcList);
        } catch (Exception e) {
            logger.error("pc : User Id - " + session.getAttribute("USER_ID") + " - User Name - " + session.getAttribute("USER_NAME") + " - " + e.getMessage());
            model.addObject("error", "Access denied or session expired.");
        }
        return model;
    }

    @RequestMapping(value = "/ajax/getPcList", method = {RequestMethod.POST, RequestMethod.GET})
    public void getPcList(@ModelAttribute Pc obj, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws IOException {
        PrintWriter pw = null;
        String json2 = null;
        try {
            String userId = (String) session.getAttribute("USER_ID");
            String userName = (String) session.getAttribute("USER_NAME");
            if (userId == null || userName == null) {
                throw new Exception("User session expired or invalid.");
            }
            pw = response.getWriter();
            Integer pageNumber = 0;
            Integer pageDisplayLength = 0;
            if (null != request.getParameter("iDisplayStart")) {
                pageDisplayLength = Integer.valueOf(request.getParameter("iDisplayLength"));
                pageNumber = (Integer.valueOf(request.getParameter("iDisplayStart")) / pageDisplayLength) + 1;
            }
            String searchParameter = request.getParameter("sSearch");

            List<Pc> pcList = new ArrayList<>();
            int startIndex = 0;
            int offset = pageDisplayLength;

            if (pageNumber == 1) {
                startIndex = 0;
                offset = pageDisplayLength;
                pcList = service.getPcList(obj, startIndex, offset, searchParameter);
            } else {
                startIndex = (pageNumber * offset) - offset;
                offset = pageDisplayLength;
                pcList = service.getPcList(obj, startIndex, offset, searchParameter);
            }

            int totalRecords = service.getTotalRecords(obj, searchParameter);

            PcPaginationObject pcJsonObject = new PcPaginationObject();
            pcJsonObject.setiTotalDisplayRecords(totalRecords);
            pcJsonObject.setiTotalRecords(totalRecords);
            pcJsonObject.setAaData(pcList);

            Gson gson = new GsonBuilder().setPrettyPrinting().create();
            json2 = gson.toJson(pcJsonObject);
        } catch (Exception e) {
            logger.error("getPcList : User Id - " + session.getAttribute("USER_ID") + " - User Name - " + session.getAttribute("USER_NAME") + " - " + e.getMessage());
            response.setStatus(HttpServletResponse.SC_FORBIDDEN);
            json2 = "{\"error\": \"Access denied or session expired.\"}";
        }
        pw.println(json2);
    }

    public int getTotalRecords(Pc obj, String searchParameter) {
        int totalRecords = 0;
        try {
            totalRecords = service.getTotalRecords(obj, searchParameter);
        } catch (Exception e) {
            logger.error("getTotalRecords : " + e.getMessage());
        }
        return totalRecords;
    }

    public List<Pc> createPaginationData(int startIndex, int offset, Pc obj, String searchParameter) {
        List<Pc> pcList = new ArrayList<>();
        try {
            pcList = service.getPcList(obj, startIndex, offset, searchParameter);
        } catch (Exception e) {
            logger.error("createPaginationData : " + e.getMessage());
        }
        return pcList;
    }

    @RequestMapping(value = "/addPc", method = RequestMethod.POST)
    public String addPc(@ModelAttribute Pc pc, RedirectAttributes redirectAttributes, HttpSession session) {
        try {
            String userId = (String) session.getAttribute("USER_ID");
            if (userId == null) {
                throw new Exception("Session expired");
            }
            // Optional: Set createdDate, createdBy, etc.
            pc.setCreatedDate(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
            pc.setCreatedBy(userId);
            service.addPc(pc);  // Implement in PcService (e.g., insert into DB)
            redirectAttributes.addFlashAttribute("success", "Profit Center added successfully");
        } catch (Exception e) {
            logger.error("addPc : User Id - " + session.getAttribute("USER_ID") + " - " + e.getMessage());
            redirectAttributes.addFlashAttribute("error", commonError);
        }
        return "redirect:/pc";
    }

    @RequestMapping(value = "/updatePc", method = RequestMethod.POST)
    public String updatePc(@ModelAttribute Pc pc, RedirectAttributes redirectAttributes, HttpSession session) {
        try {
            String userId = (String) session.getAttribute("USER_ID");
            if (userId == null) {
                throw new Exception("Session expired");
            }
            // Optional: Set modifiedDate, modifiedBy, etc.
            pc.setModifiedDate(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
            pc.setModifiedBy(userId);
            service.updatePc(pc);  // Implement in PcService (e.g., update DB by id)
            redirectAttributes.addFlashAttribute("success", "Profit Center updated successfully");
        } catch (Exception e) {
            logger.error("updatePc : User Id - " + session.getAttribute("USER_ID") + " - " + e.getMessage());
            redirectAttributes.addFlashAttribute("error", commonError);
        }
        return "redirect:/pc";
    }

    @RequestMapping(value = "/deletePc", method = RequestMethod.POST)
    public String deletePc(@ModelAttribute Pc pc, RedirectAttributes redirectAttributes, HttpSession session) {
        try {
            String userId = (String) session.getAttribute("USER_ID");
            if (userId == null) {
                throw new Exception("Session expired");
            }
            service.deletePc(pc);  // Implement in PcService (e.g., delete from DB by id)
            redirectAttributes.addFlashAttribute("success", "Profit Center deleted successfully");
        } catch (Exception e) {
            logger.error("deletePc : User Id - " + session.getAttribute("USER_ID") + " - " + e.getMessage());
            redirectAttributes.addFlashAttribute("error", commonError);
        }
        return "redirect:/pc";
    }

    @RequestMapping(value = "/exportPc", method = RequestMethod.POST)
    public ResponseEntity<byte[]> exportPc(HttpSession session) {
        try {
            String userId = (String) session.getAttribute("USER_ID");
            if (userId == null) {
                throw new Exception("Session expired");
            }
            List<Pc> pcList = service.getPcList(null, 0, Integer.MAX_VALUE, null);
            if (pcList.isEmpty()) {
                // Handle no data (return empty or error)
                byte[] empty = dataExportNoData.getBytes();
                return new ResponseEntity<>(empty, HttpStatus.OK);
            }

            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            XSSFWorkbook workbook = new XSSFWorkbook();
            XSSFSheet sheet = workbook.createSheet("Profit Centers");

            // Header row
            Row headerRow = sheet.createRow(0);
            String[] headers = {"Entity Code", "Entity Name", "Profit Center Code", "Profit Center Name", "SBU", "Employee ID", "Employee Name", "Email", "Created Date", "Modified Date", "Status"};
            for (int i = 0; i < headers.length; i++) {
                Cell cell = headerRow.createCell(i);
                cell.setCellValue(headers[i]);
            }

            // Data rows
            int rowNum = 1;
            for (Pc pc : pcList) {
                Row row = sheet.createRow(rowNum++);
                row.createCell(0).setCellValue(pc.getEntityCode() != null ? pc.getEntityCode() : "");
                row.createCell(1).setCellValue(pc.getEntityName() != null ? pc.getEntityName() : "");
                row.createCell(2).setCellValue(pc.getProfitCenterCode() != null ? pc.getProfitCenterCode() : "");
                row.createCell(3).setCellValue(pc.getProfitCenterName() != null ? pc.getProfitCenterName() : "");
                row.createCell(4).setCellValue(pc.getSbu() != null ? pc.getSbu() : "");
                row.createCell(5).setCellValue(pc.getEmpId() != null ? pc.getEmpId() : "");
                row.createCell(6).setCellValue(pc.getEmpName() != null ? pc.getEmpName() : "");
                row.createCell(7).setCellValue(pc.getEmailId() != null ? pc.getEmailId() : "");
                row.createCell(8).setCellValue(pc.getCreatedDate() != null ? pc.getCreatedDate() : "");
                row.createCell(9).setCellValue(pc.getModifiedDate() != null ? pc.getModifiedDate() : "");
                row.createCell(10).setCellValue(pc.getStatus() != null ? pc.getStatus() : "");
            }

            workbook.write(baos);
            workbook.close();

            byte[] bytes = baos.toByteArray();

            HttpHeaders headersResponse = new HttpHeaders();
            headersResponse.setContentType(MediaType.APPLICATION_OCTET_STREAM);
            headersResponse.setContentDispositionFormData("attachment", "profit_centers.xlsx");

            return new ResponseEntity<>(bytes, headersResponse, HttpStatus.OK);
        } catch (Exception e) {
            logger.error("exportPc : User Id - " + session.getAttribute("USER_ID") + " - " + e.getMessage());
            return new ResponseEntity<>(dataExportError.getBytes(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    // If you have cellFormating or donePc methods, keep them as-is.
}