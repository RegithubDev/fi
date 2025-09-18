package com.resustainability.reisp.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.resustainability.reisp.dao.PcDao;
import com.resustainability.reisp.model.Pc;

@Service
public class PcService {

    @Autowired
    PcDao dao;

    public List<Pc> getPcList(Pc obj) throws Exception {
        return dao.getPcList(obj);
    }

    public boolean addPc(Pc obj) throws Exception {
        return dao.addPc(obj);
    }

    public boolean updatePc(Pc obj) throws Exception {
        return dao.updatePc(obj);
    }

    public boolean deletePc(Pc obj) throws Exception {
        return dao.deletePc(obj);
    }
}