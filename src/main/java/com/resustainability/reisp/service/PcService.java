package com.resustainability.reisp.service;

import com.resustainability.reisp.dao.PcDao;
import com.resustainability.reisp.model.Pc;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PcService {

    @Autowired
    private PcDao pcDao;

    private static final Logger logger = Logger.getLogger(PcService.class);

    public List<Pc> getPcList(Pc pc, int startIndex, int offset, String searchParameter) throws Exception {
        try {
            return pcDao.getpcList(pc, startIndex, offset, searchParameter);
        } catch (Exception e) {
            logger.error("Error fetching profit center list: " + e.getMessage());
            throw e;
        }
    }

    public int getTotalRecords(Pc pc, String searchParameter) throws Exception {
        try {
            return pcDao.getTotalRecords(pc, searchParameter);
        } catch (Exception e) {
            logger.error("Error counting total records: " + e.getMessage());
            throw e;
        }
    }

    public boolean addPc(Pc pc) throws Exception {
        try {
            // Check for existing email with Active status
            Pc existingPc = pcDao.findByEmailIdAndStatus(pc.getId(), "Active");
            if (existingPc != null) {
                throw new Exception("Email already exists with Active status.");
            }
            return pcDao.addPc(pc);
        } catch (Exception e) {
            logger.error("Error adding profit center: " + e.getMessage());
            throw e;
        }
    }

    public boolean updatePc(Pc pc) throws Exception {
        try {
            // Check for existing email with Active status (excluding current record)
            Pc existingPc = pcDao.findByEmailIdAndStatus(pc.getId(), "Active");
            if (existingPc != null && !existingPc.getId().equals(pc.getId())) {
                throw new Exception("Email already exists with Active status.");
            }
            return pcDao.updatePc(pc);
        } catch (Exception e) {
            logger.error("Error updating profit center: " + e.getMessage());
            throw e;
        }
    }

    public boolean deletePc(Pc pc) throws Exception {
        try {
            return pcDao.deletePc(pc);
        } catch (Exception e) {
            logger.error("Error deleting profit center: " + e.getMessage());
            throw e;
        }
    }

}