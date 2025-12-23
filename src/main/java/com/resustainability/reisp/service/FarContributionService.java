package com.resustainability.reisp.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import com.resustainability.reisp.model.User;
import com.resustainability.reisp.dao.FarContributionDAO;
import com.resustainability.reisp.model.FarContribution;

@Service  // THIS IS CRITICAL - Registers as Spring Bean
public class FarContributionService  {

@Autowired
FarContributionDAO dao;

	public boolean addfarContribution(FarContribution farContribution) {
		// TODO Auto-generated method stub
		return dao.addfarContribution(farContribution);
	}

	public boolean updatefarContribution(FarContribution farContribution) {
		// TODO Auto-generated method stub
		return dao.updatefarContribution(farContribution);
	}

	public List<FarContribution> getFarContributions(String month_year, String entity_Code, String profit_Center_Code,
			User usr) {
		// TODO Auto-generated method stub
		return dao.getFarContributions(month_year,entity_Code,profit_Center_Code,usr);
	}

  
}