package com.resustainability.reisp.dto;

import java.time.LocalDateTime;

public record AttendanceDuration(
		LocalDateTime clockIn,
		LocalDateTime clockOut,
		String clockInAsString,
		String clockOutAsString,
		Long totalSeconds,
		Integer totalHours,
		Integer totalMinutes,
		Integer overtimeHours,
		Integer overtimeMinutes,
		Double totalWorkHours,
		String clockInTimePart,
		String shiftType
) {

	public static AttendanceDuration buildEmpty() {
		return new AttendanceDuration(
				null, // clockIn
				null, // clockOut
				null, // clockInAsString
				null, // clockOutAsString
				0L, // totalSeconds
				0, // totalHours
				0, // totalMinutes
				0, // overtimeHours
				0, // overtimeMinutes
				0.0, // totalWorkHours
				null, // clockInTimePart
				null  // shiftType
		);
	}

}
