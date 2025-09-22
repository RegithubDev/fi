package com.resustainability.reisp.service;

import com.resustainability.reisp.model.User;
import com.resustainability.reisp.model.inventoryContribution;
import com.resustainability.reisp.dao.InventoryContributionDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class InventoryContributionService {

    @Autowired
    private InventoryContributionDAO inventoryDAO; // Fixed: Removed static modifier

    public List<inventoryContribution> getAllInventoryContributions() {
        try {
            return inventoryDAO.getAllInventoryContributions();
        } catch (Exception e) {
            throw new RuntimeException("Error fetching inventory contributions: " + e.getMessage(), e);
        }
    }

    public boolean addInventoryContribution(inventoryContribution inventory) {
        try {
            return inventoryDAO.addInventoryContribution(inventory);
        } catch (Exception e) {
            throw new RuntimeException("Error adding inventory contribution: " + e.getMessage(), e);
        }
    }

    public boolean updateInventoryContribution(inventoryContribution inventory) { // Fixed: Removed static modifier
        try {
            return inventoryDAO.updateInventoryContribution(inventory);
        } catch (Exception e) {
            throw new RuntimeException("Error updating inventory contribution: " + e.getMessage(), e);
        }
    }

    public List<inventoryContribution> getInventoryContributions(String month_year, String entity_code, String profit_center_code, User user) {
        try {
            return inventoryDAO.getInventoryContributions(month_year, entity_code, profit_center_code, user);
        } catch (Exception e) {
            throw new RuntimeException("Error fetching inventory contributions: " + e.getMessage(), e);
        }
    }

    public boolean addinventoryContribution(inventoryContribution inventoryContribution) {
        try {
            return inventoryDAO.addInventoryContribution(inventoryContribution); // Assuming DAO has this method
        } catch (Exception e) {
            throw new RuntimeException("Error adding inventory contribution: " + e.getMessage(), e);
        }
    }

    public boolean updateinventoryContribution(inventoryContribution inventoryContribution) {
        try {
            return inventoryDAO.updateInventoryContribution(inventoryContribution); // Assuming DAO has this method
        } catch (Exception e) {
            throw new RuntimeException("Error updating inventory contribution: " + e.getMessage(), e);
        }
    }



    public List<inventoryContribution> getinventoryContributions(String month_year, String entity_code, String profit_center_code, User usr) {
        try {
            return inventoryDAO.getInventoryContributions(month_year, entity_code, profit_center_code, usr); // Assuming DAO has this method
        } catch (Exception e) {
            throw new RuntimeException("Error fetching inventory contributions: " + e.getMessage(), e);
        }
    }


}