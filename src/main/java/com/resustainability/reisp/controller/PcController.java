package com.resustainability.reisp.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
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
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.resustainability.reisp.common.DateForUser;
import com.resustainability.reisp.constants.PageConstants;
import com.resustainability.reisp.model.Pc;
import com.resustainability.reisp.model.UserPaginationObject;
import com.resustainability.reisp.service.PcService;

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
            List<Pc> pcList = service.getPcList(null);
            model.addObject("pcList", pcList);
        } catch (Exception e) {
            logger.error("pc : User Id - " + session.getAttribute("USER_ID") + " - User Name - " + session.getAttribute("USER_NAME") + " - " + e.getMessage());
            e.printStackTrace();
        }
        return model;
    }

    @RequestMapping(value = "/addPc", method = {RequestMethod.GET, RequestMethod.POST})
    public ModelAndView addPc(@ModelAttribute Pc obj, RedirectAttributes attributes, HttpSession session) {
        ModelAndView model = new ModelAndView();
        try {
            model.setViewName("redirect:/done-pc");
            String userId = (String) session.getAttribute("USER_ID");
            String userName = (String) session.getAttribute("USER_NAME");
            DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
            String dt = formatter.format(new Date());
            obj.setCreatedDate(dt);
            boolean flag = service.addPc(obj);
            if (flag) {
                attributes.addFlashAttribute("success", "Profit Center Added Successfully.");
            } else {
                attributes.addFlashAttribute("error", "Adding Profit Center failed. Try again.");
            }
        } catch (Exception e) {
            attributes.addFlashAttribute("error", "Adding Profit Center failed. Try again.");
            logger.error("addPc : User Id - " + session.getAttribute("USER_ID") + " - User Name - " + session.getAttribute("USER_NAME") + " - " + e.getMessage());
            e.printStackTrace();
        }
        return model;
    }

    @RequestMapping(value = "/updatePc", method = {RequestMethod.GET, RequestMethod.POST})
    public ModelAndView updatePc(@ModelAttribute Pc obj, RedirectAttributes attributes, HttpSession session) {
        ModelAndView model = new ModelAndView();
        try {
            model.setViewName("redirect:/done-pc");
            String userId = (String) session.getAttribute("USER_ID");
            String userName = (String) session.getAttribute("USER_NAME");
            DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
            String dt = formatter.format(new Date());
            obj.setModifiedDate(dt);
            boolean flag = service.updatePc(obj);
            if (flag) {
                attributes.addFlashAttribute("success", "Profit Center Updated Successfully.");
            } else {
                attributes.addFlashAttribute("error", "Updating Profit Center failed. Try again.");
            }
        } catch (Exception e) {
            attributes.addFlashAttribute("error", "Updating Profit Center failed. Try again.");
            logger.error("updatePc : User Id - " + session.getAttribute("USER_ID") + " - User Name - " + session.getAttribute("USER_NAME") + " - " + e.getMessage());
            e.printStackTrace();
        }
        return model;
    }

    @RequestMapping(value = "/deletePc", method = {RequestMethod.GET, RequestMethod.POST})
    public ModelAndView deletePc(@ModelAttribute Pc obj, RedirectAttributes attributes, HttpSession session) {
        ModelAndView model = new ModelAndView();
        try {
            model.setViewName("redirect:/done-pc");
            String userId = (String) session.getAttribute("USER_ID");
            String userName = (String) session.getAttribute("USER_NAME");
            boolean flag = service.deletePc(obj);
            if (flag) {
                attributes.addFlashAttribute("success", "Profit Center Deleted Successfully.");
            } else {
                attributes.addFlashAttribute("error", "Deleting Profit Center failed. Try again.");
            }
        } catch (Exception e) {
            attributes.addFlashAttribute("error", "Deleting Profit Center failed. Try again.");
            logger.error("deletePc : User Id - " + session.getAttribute("USER_ID") + " - User Name - " + session.getAttribute("USER_NAME") + " - " + e.getMessage());
            e.printStackTrace();
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
            pw = response.getWriter();
            Integer pageNumber = 0;
            Integer pageDisplayLength = 0;
            if (null != request.getParameter("iDisplayStart")) {
                pageDisplayLength = Integer.valueOf(request.getParameter("iDisplayLength"));
                pageNumber = (Integer.valueOf(request.getParameter("iDisplayStart")) / pageDisplayLength) + 1;
            }
            String searchParameter = request.getParameter("sSearch");
            pageDisplayLength = Integer.valueOf(request.getParameter("iDisplayLength"));

            List<Pc> pcList = new ArrayList<>();
            int startIndex = 0;
            int offset = pageDisplayLength;

            if (pageNumber == 1) {
                startIndex = 0;
                offset = pageDisplayLength;
                pcList = createPaginationData(startIndex, offset, obj, searchParameter);
            } else {
                startIndex = (pageNumber * offset) - offset;
                offset = pageDisplayLength;
                pcList = createPaginationData(startIndex, offset, obj, searchParameter);
            }

            int totalRecords = getTotalRecords(obj, searchParameter);

            UserPaginationObject pcJsonObject = new UserPaginationObject();
            pcJsonObject.setiTotalDisplayRecords(totalRecords);
            pcJsonObject.setiTotalRecords(totalRecords);
            pcJsonObject.setAaData(pcList);

            Gson gson = new GsonBuilder().setPrettyPrinting().create();
            json2 = gson.toJson(pcJsonObject);
        } catch (Exception e) {
            logger.error("getPcList : User Id - " + session.getAttribute("USER_ID") + " - User Name - " + session.getAttribute("USER_NAME") + " - " + e.getMessage());
            e.printStackTrace();
        }
        pw.println(json2);
    }

    public int getTotalRecords(Pc obj, String searchParameter) {
        int totalRecords = 0;
        try {
            List<Pc> pcList = service.getPcList(obj);
            totalRecords = pcList.size();
        } catch (Exception e) {
            logger.error("getTotalRecords : " + e.getMessage());
        }
        return totalRecords;
    }

    public List<Pc> createPaginationData(int startIndex, int offset, Pc obj, String searchParameter) {
        List<Pc> pcList = new ArrayList<>();
        try {
            pcList = service.getPcList(obj);
            if (!StringUtils.isEmpty(searchParameter)) {
                pcList = pcList.stream()
                        .filter(pc -> pc.getId().contains(searchParameter) ||
                                pc.getEntityCode().contains(searchParameter) ||
                                pc.getEntityName().contains(searchParameter) ||
                                pc.getProfitCenterCode().contains(searchParameter) ||
                                pc.getProfitCenterName().contains(searchParameter) ||
                                pc.getSbu().contains(searchParameter) ||
                                pc.getEmpId().contains(searchParameter) ||
                                pc.getEmpName().contains(searchParameter) ||
                                pc.getEmailId().contains(searchParameter) ||
                                pc.getStatus().contains(searchParameter))
                        .toList();
            }
            int endIndex = Math.min(startIndex + offset, pcList.size());
            pcList = pcList.subList(startIndex, endIndex);
        } catch (Exception e) {
            logger.error("createPaginationData : " + e.getMessage());
        }
        return pcList;
    }

    @RequestMapping(value = "/export-pc", method = {RequestMethod.GET, RequestMethod.POST})
    public void exportPc(HttpServletRequest request, HttpServletResponse response, HttpSession session, @ModelAttribute Pc obj, RedirectAttributes attributes) {
        try {
            String userId = (String) session.getAttribute("USER_ID");
            String userName = (String) session.getAttribute("USER_NAME");
            List<Pc> dataList = service.getPcList(obj);
            if (dataList != null && !dataList.isEmpty()) {
                XSSFWorkbook workBook = new XSSFWorkbook();
                XSSFSheet sheet = workBook.createSheet(WorkbookUtil.createSafeSheetName("Profit Center"));
                workBook.setSheetOrder(sheet.getSheetName(), 0);

                byte[] blueRGB = new byte[]{(byte) 0, (byte) 176, (byte) 240};
                byte[] greenRGB = new byte[]{(byte) 146, (byte) 208, (byte) 80};
                byte[] whiteRGB = new byte[]{(byte) 255, (byte) 255, (byte) 255};

                boolean isWrapText = true;
                boolean isBoldText = true;
                boolean isItalicText = false;
                int fontSize = 11;
                String fontName = "Times New Roman";
                CellStyle greenStyle = cellFormating(workBook, greenRGB, HorizontalAlignment.CENTER, VerticalAlignment.CENTER, isWrapText, isBoldText, isItalicText, fontSize, fontName);
                CellStyle whiteStyle = cellFormating(workBook, whiteRGB, HorizontalAlignment.LEFT, VerticalAlignment.CENTER, isWrapText, false, isItalicText, 9, fontName);

                XSSFRow heading = sheet.createRow(1);
                Cell cell1 = heading.createCell(0);
                cell1.setCellStyle(greenStyle);
                cell1.setCellValue("Profit Center - Report");

                XSSFRow headingRow = sheet.createRow(2);
                String headerString = "#,ID,Entity Code,Entity Name,Profit Center Code,Profit Center Name,SBU,Employee ID,Employee Name,Email,Created Date,Modified Date,Status";
                String[] firstHeaderStringArr = headerString.split(",");

                for (int i = 0; i < firstHeaderStringArr.length; i++) {
                    Cell cell = headingRow.createCell(i);
                    cell.setCellStyle(greenStyle);
                    cell.setCellValue(firstHeaderStringArr[i]);
                }

                short rowNo = 3;
                short sNo = 1;
                for (Pc pc : dataList) {
                    XSSFRow row = sheet.createRow(rowNo);
                    int c = 0;

                    Cell cell = row.createCell(c++);
                    cell.setCellStyle(whiteStyle);
                    cell.setCellValue(sNo++);

                    cell = row.createCell(c++);
                    cell.setCellStyle(whiteStyle);
                    cell.setCellValue(pc.getId());

                    cell = row.createCell(c++);
                    cell.setCellStyle(whiteStyle);
                    cell.setCellValue(pc.getEntityCode());

                    cell = row.createCell(c++);
                    cell.setCellStyle(whiteStyle);
                    cell.setCellValue(pc.getEntityName());

                    cell = row.createCell(c++);
                    cell.setCellStyle(whiteStyle);
                    cell.setCellValue(pc.getProfitCenterCode());

                    cell = row.createCell(c++);
                    cell.setCellStyle(whiteStyle);
                    cell.setCellValue(pc.getProfitCenterName());

                    cell = row.createCell(c++);
                    cell.setCellStyle(whiteStyle);
                    cell.setCellValue(pc.getSbu());

                    cell = row.createCell(c++);
                    cell.setCellStyle(whiteStyle);
                    cell.setCellValue(pc.getEmpId());

                    cell = row.createCell(c++);
                    cell.setCellStyle(whiteStyle);
                    cell.setCellValue(pc.getEmpName());

                    cell = row.createCell(c++);
                    cell.setCellStyle(whiteStyle);
                    cell.setCellValue(pc.getEmailId());

                    cell = row.createCell(c++);
                    cell.setCellStyle(whiteStyle);
                    cell.setCellValue(pc.getCreatedDate());

                    cell = row.createCell(c++);
                    cell.setCellStyle(whiteStyle);
                    cell.setCellValue(pc.getModifiedDate());

                    cell = row.createCell(c++);
                    cell.setCellStyle(whiteStyle);
                    cell.setCellValue(pc.getStatus());

                    rowNo++;
                }

                for (int columnIndex = 1; columnIndex < firstHeaderStringArr.length; columnIndex++) {
                    sheet.setColumnWidth(columnIndex, 25 * 200);
                }

                DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd-HHmmss");
                String fileName = "Profit_Center_" + dateFormat.format(new Date());

                response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
                response.addHeader("Content-Disposition", "attachment; filename=" + fileName + ".xlsx");
                workBook.write(response.getOutputStream());
                workBook.close();
                response.getOutputStream().flush();

                attributes.addFlashAttribute("success", dataExportSuccess);
            } else {
                attributes.addFlashAttribute("error", dataExportNoData);
            }
        } catch (Exception e) {
            attributes.addFlashAttribute("error", dataExportError);
            logger.error("exportPc : User Id - " + session.getAttribute("USER_ID") + " - User Name - " + session.getAttribute("USER_NAME") + " - " + e.getMessage());
            e.printStackTrace();
        }
    }

    private CellStyle cellFormating(XSSFWorkbook workBook, byte[] rgb, HorizontalAlignment hAlign, VerticalAlignment vAlign, boolean isWrapText, boolean isBoldText, boolean isItalicText, int fontSize, String fontName) {
        CellStyle style = workBook.createCellStyle();
        style.setFillPattern(FillPatternType.SOLID_FOREGROUND);

        if (style instanceof XSSFCellStyle) {
            XSSFCellStyle xssfCellStyle = (XSSFCellStyle) style;
            xssfCellStyle.setFillForegroundColor(new XSSFColor(rgb, null));
        }

        style.setBorderBottom(BorderStyle.MEDIUM);
        style.setBorderTop(BorderStyle.MEDIUM);
        style.setBorderLeft(BorderStyle.MEDIUM);
        style.setBorderRight(BorderStyle.MEDIUM);
        style.setAlignment(hAlign);
        style.setVerticalAlignment(vAlign);
        style.setWrapText(isWrapText);

        org.apache.poi.ss.usermodel.Font font = workBook.createFont();
        font.setFontHeightInPoints((short) fontSize);
        font.setFontName(fontName);
        font.setItalic(isItalicText);
        font.setBold(isBoldText);
        style.setFont(font);

        return style;
    }

    @RequestMapping(value = "/done-pc", method = {RequestMethod.POST, RequestMethod.GET})
    public ModelAndView donePc(@ModelAttribute Pc pc, HttpSession session) {
        ModelAndView model = new ModelAndView(PageConstants.done);
        try {
            model.addObject("redirect", "pc");
            model.addObject("module", "Profit Center");
        } catch (Exception e) {
            logger.error("donePc : User Id - " + session.getAttribute("USER_ID") + " - User Name - " + session.getAttribute("USER_NAME") + " - " + e.getMessage());
            e.printStackTrace();
        }
        return model;
    }
}