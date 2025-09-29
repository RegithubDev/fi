package com.resustainability.reisp.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.resustainability.reisp.dao.ContributionDao;
import com.resustainability.reisp.dao.EsiContributionDao;
import com.resustainability.reisp.model.EsiContribution;
import com.resustainability.reisp.model.User;

@Service
public class EsiContributionService {

	  @Autowired
	    private EsiContributionDao contributionDao;

	    public List<EsiContribution> getEsiContributions(String monthYear, String entity, String profitCenter, User usr) {
	        return contributionDao.getEsiContributions(monthYear, entity, profitCenter, usr);
	    }

	    public boolean addEsiContribution(EsiContribution pf) {
			return  contributionDao.addEsiContribution(pf);
	    }

	    public boolean updateEsiContribution(EsiContribution pf) {
	    	return contributionDao.updateEsiContribution(pf);
	    }

		public List<EsiContribution> geteList() throws Exception {
			  return contributionDao.geteList();
		}

		public List<EsiContribution> getpList() throws Exception {
			return  contributionDao.getpList();
		}

		public List<EsiContribution> getUList() throws Exception {
			return  contributionDao.getUList();
		}

}
