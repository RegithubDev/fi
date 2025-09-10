package com.resustainability.reisp.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.resustainability.reisp.dao.ContributionDao;
import com.resustainability.reisp.dao.EsiContributionDao;
import com.resustainability.reisp.dao.PTContributionDao;
import com.resustainability.reisp.model.EsiContribution;
import com.resustainability.reisp.model.User;

@Service
public class PtContributionService {

	  @Autowired
	    private PTContributionDao contributionDao;

	    public List<EsiContribution> getPtContributions(String monthYear, String entity, String profitCenter, User usr) {
	        return contributionDao.getPtContributions(monthYear, entity, profitCenter, usr);
	    }

	    public boolean addPtContribution(EsiContribution pf) {
			return  contributionDao.addPtContribution(pf);
	    }

	    public boolean updatePtContribution(EsiContribution pf) {
	    	return contributionDao.updatePtContribution(pf);
	    }

		public List<EsiContribution> geteList() throws Exception {
			  return contributionDao.geteList();
		}

		public List<EsiContribution> getpList() throws Exception {
			return  contributionDao.getpList();
		}

}
