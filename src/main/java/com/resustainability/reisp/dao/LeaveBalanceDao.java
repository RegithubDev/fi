package com.resustainability.reisp.dao;

import com.resustainability.reisp.dto.commons.Pager;
import com.resustainability.reisp.dto.entity.LeaveBalance;

import org.apache.commons.lang3.StringUtils;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class LeaveBalanceDao {

    private final JdbcTemplate jdbcTemplate;

    private static final Map<String, String> SORT_COLUMNS = Map.of(
            "id", "id",
            "empCode", "empCode",
            "empName", "empName",
            "hireDate", "hireDate"
    );

    @Autowired
    public LeaveBalanceDao(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public Pager<LeaveBalance> fetchPage(int page, int size, String sortCol, String direction, String searchTerm) {
        /* validate / default */
        sortCol = StringUtils.isBlank(sortCol) ? "id" : SORT_COLUMNS.getOrDefault(sortCol, "id");

        // sort
        direction = "desc".equalsIgnoreCase(direction) ? "DESC" : "ASC";
        int offset = page * size;

        // search term
        boolean hasSearch = StringUtils.isNotBlank(searchTerm);
        String likePattern = hasSearch ? "%" + searchTerm.trim() + "%" : null;

        /* data page */
        String dataSql = """
                SELECT  id, empCode, empName, hireDate,
                        sickLeave, casualLeave, earnedLeave,
                        maternityLeave, paternityLeave
                FROM    dbo.att_leaveBalanceSummary
                WHERE   (? IS NULL
                         OR empCode LIKE ?
                         OR empName LIKE ?)
                ORDER BY %s %s
                OFFSET  ? ROWS FETCH NEXT ? ROWS ONLY;
                """.formatted(sortCol, direction);

        List<LeaveBalance> rows = jdbcTemplate.query(
                dataSql,
                (rs, i) -> {
                    LeaveBalance lb = new LeaveBalance();
                    lb.setId(rs.getLong("id"));
                    lb.setEmpCode(rs.getString("empCode"));
                    lb.setEmpName(rs.getString("empName"));
                    lb.setHireDate(rs.getString("hireDate"));
                    lb.setSickLeave(rs.getBigDecimal("sickLeave"));
                    lb.setCasualLeave(rs.getBigDecimal("casualLeave"));
                    lb.setEarnedLeave(rs.getBigDecimal("earnedLeave"));
                    lb.setMaternityLeave(rs.getBigDecimal("maternityLeave"));
                    lb.setPaternityLeave(rs.getBigDecimal("paternityLeave"));
                    return lb;
                },
                likePattern, likePattern, likePattern,
                offset, size
        );

        /* total count */
        String countSql = """
                        SELECT COUNT(*)
                        FROM   dbo.att_leaveBalanceSummary
                        WHERE  (? IS NULL
                                OR empCode LIKE ?
                                OR empName LIKE ?)
                """;

        long total = jdbcTemplate.queryForObject(
                countSql,
                Long.class,
                likePattern, likePattern, likePattern
        );

        return new Pager<>(
                rows,
                total,
                page,
                size,
                !"id".equals(sortCol)
        );
    }
}
