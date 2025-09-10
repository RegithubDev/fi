package com.resustainability.reisp.model;

import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalDateTime;

public class Shift {
	public LocalDate shiftDate;
	public LocalDateTime inTime;
     public LocalDateTime outTime;
     public Duration workDuration;
     public Duration overtime;
	public boolean missedPunchOut;
  
     public Shift(LocalDate date, LocalDateTime inTime, LocalDateTime outTime) {
         this.shiftDate = date;
         this.inTime = inTime;
         this.outTime = outTime;

         if (inTime != null && outTime != null) {
             this.workDuration = Duration.between(inTime, outTime);
             this.overtime = workDuration.minusHours(8).isNegative() ? Duration.ZERO : workDuration.minusHours(8);
         } else {
             this.workDuration = Duration.ZERO;
             this.overtime = Duration.ZERO;
         }
     }
     public String toString() {
         return "Shift Date: " + shiftDate 
             + ", IN: " + inTime 
             + ", OUT: " + outTime 
             + ", Worked: " + workDuration.toHoursPart() + "h" + workDuration.toMinutesPart() + "m"
             + ", OT: " + overtime.toHoursPart() + "h" + overtime.toMinutesPart() + "m";
     }
}
