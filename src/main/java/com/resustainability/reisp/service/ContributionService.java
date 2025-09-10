package com.resustainability.reisp.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.resustainability.reisp.dao.ContributionDao;
import com.resustainability.reisp.model.PfContribution;
import com.resustainability.reisp.model.User;

@Service
public class ContributionService {

	  @Autowired
	    private ContributionDao contributionDao;

	    public List<PfContribution> getPfContributions(String monthYear, String entity, String profitCenter, User usr) {
	        return contributionDao.getPfContributions(monthYear, entity, profitCenter, usr);
	    }

	    public boolean addPfContribution(PfContribution pf) {
			return  contributionDao.addPfContribution(pf);
	    }

	    public boolean updatePfContribution(PfContribution pf) {
	    	return contributionDao.updatePfContribution(pf);
	    }

		public List<PfContribution> geteList() throws Exception {
			  return contributionDao.geteList();
		}

		public List<PfContribution> getpList() throws Exception {
			return  contributionDao.getpList();
		}

}
