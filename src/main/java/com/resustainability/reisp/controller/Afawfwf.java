package com.resustainability.reisp.controller;

import java.time.LocalDate;
import java.time.YearMonth;

public class Afawfwf {

	public static void main(String[] args) {
		  LocalDate today = LocalDate.now();
		  try {
			YearMonth lastQuarter = getThisQuarterMinusOneMonth(YearMonth.from(today));
			System.out.println(lastQuarter);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    
	}
	
	private static YearMonth getThisQuarterMinusOneMonth(YearMonth now) {
	    int month = now.getMonthValue();

	    YearMonth quarterStart;
	    if (month >= 1 && month <= 3)
	        quarterStart = YearMonth.of(now.getYear(), 1);   // Q1 starts in Jan
	    else if (month >= 4 && month <= 6)
	        quarterStart = YearMonth.of(now.getYear(), 4);   // Q2 starts in Apr
	    else if (month >= 7 && month <= 9)
	        quarterStart = YearMonth.of(now.getYear(), 7);   // Q3 starts in Jul
	    else
	        quarterStart = YearMonth.of(now.getYear(), 10);  // Q4 starts in Oct

	    // Return one month before the quarter start
	    return quarterStart.minusMonths(1);
	}

}
