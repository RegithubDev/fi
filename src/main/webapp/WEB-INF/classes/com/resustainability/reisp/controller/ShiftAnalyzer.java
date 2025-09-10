package com.resustainability.reisp.controller;

import java.time.*;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.stream.Collectors;

import com.resustainability.reisp.model.RawPunch;

class Punch {
    int empCode;
    LocalDateTime punchTime;
    int punchState; // 1 = In, 0 = Out

    Punch(int empCode, String punchTimeStr, int punchState) {
        this.empCode = empCode;
        this.punchTime = LocalDateTime.parse(punchTimeStr, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
        this.punchState = punchState;
    }
}

class WorkDaySummary {
    LocalDate workDate;
    List<LocalDateTime> ins = new ArrayList<>();
    List<LocalDateTime> outs = new ArrayList<>();
    List<LocalDateTime> allPunches = new ArrayList<>();

    public String getFirstIn() {
        return ins.isEmpty() ? "" : ins.stream().min(LocalDateTime::compareTo).get().toLocalTime().toString();
    }

    public String getLastOut() {
        return outs.isEmpty() ? "" : outs.stream().max(LocalDateTime::compareTo).get().toLocalTime().toString();
    }

    public String getNote() {
        if (!ins.isEmpty() && !outs.isEmpty()) {
            if (ins.get(0).toLocalTime().isAfter(LocalTime.of(20, 0))) return "C shift span likely";
            return "Complete working day";
        } else if (!ins.isEmpty()) return "Single punch (IN)";
        else if (!outs.isEmpty()) return "Day shift OUT only";
        return "No punches";
    }
}

public class ShiftAnalyzer {
    public static void main(String[] args) {
        List<Punch> punches = Arrays.asList(
        		new Punch(4999, "2025-05-25 21:48:11", 0),
        		new Punch(4999, "2025-05-25 06:06:16", 1),
        		new Punch(4999, "2025-05-24 13:57:36", 0),
        		new Punch(4999, "2025-05-24 06:18:26", 1),
        		new Punch(4999, "2025-05-23 10:39:59", 0),
        		new Punch(4999, "2025-05-22 22:06:33", 1),
        		new Punch(4999, "2025-05-22 22:06:31", 1),
        		new Punch(4999, "2025-05-22 22:06:18", 1),
        		new Punch(4999, "2025-05-22 13:53:41", 0),
        		new Punch(4999, "2025-05-22 13:53:40", 0),
        		new Punch(4999, "2025-05-22 13:53:38", 0),
        		new Punch(4999, "2025-05-21 15:27:04", 1),
        		new Punch(4999, "2025-05-21 05:49:57", 0),
        		new Punch(4999, "2025-05-20 13:55:25", 1),
        		new Punch(4999, "2025-05-20 05:50:30", 0),
        		new Punch(4999, "2025-05-19 14:02:56", 1),
        		new Punch(4999, "2025-05-19 06:25:05", 0),
        		new Punch(4999, "2025-05-19 06:25:03", 0),
        		new Punch(4999, "2025-05-19 06:24:47", 1),
        		new Punch(4999, "2025-05-19 06:24:43", 1),
        		new Punch(4999, "2025-05-19 06:24:41", 1),
        		new Punch(4999, "2025-05-18 21:42:54", 0),
        		new Punch(4999, "2025-05-18 06:04:16", 1),
        		new Punch(4999, "2025-05-17 18:29:13", 0),
        		new Punch(4999, "2025-05-17 06:09:04", 1),
        		new Punch(4999, "2025-05-16 17:58:43", 0),
        		new Punch(4999, "2025-05-16 06:31:44", 1),
        		new Punch(4999, "2025-05-15 17:56:12", 0),
        		new Punch(4999, "2025-05-15 06:20:19", 1),
        		new Punch(4999, "2025-05-14 17:48:19", 1),
        		new Punch(4999, "2025-05-14 06:15:04", 1),
        		new Punch(4999, "2025-05-13 18:05:51", 0),
        		new Punch(4999, "2025-05-13 18:05:48", 0),
        		new Punch(4999, "2025-05-13 06:06:59", 1),
        		new Punch(4999, "2025-05-12 21:55:10", 0),
        		new Punch(4999, "2025-05-12 09:52:10", 1),
        		new Punch(4999, "2025-05-12 06:08:43", 0),
        		new Punch(4999, "2025-05-12 06:08:27", 1),
        		new Punch(4999, "2025-05-12 06:08:24", 1),
        		new Punch(4999, "2025-05-11 17:51:43", 0),
        		new Punch(4999, "2025-05-11 06:32:22", 1),
        		new Punch(4999, "2025-05-11 06:32:07", 0),
        		new Punch(4999, "2025-05-10 17:54:30", 0),
        		new Punch(4999, "2025-05-10 06:33:26", 1),
        		new Punch(4999, "2025-05-09 17:58:34", 0),
        		new Punch(4999, "2025-05-09 07:03:05", 1),
        		new Punch(4999, "2025-05-08 13:41:54", 0),
        		new Punch(4999, "2025-05-07 22:00:39", 1),
        		new Punch(4999, "2025-05-07 13:42:01", 0),
        		new Punch(4999, "2025-05-06 22:03:34", 1),
        		new Punch(4999, "2025-05-06 13:56:05", 0),
        		new Punch(4999, "2025-05-06 05:55:50", 1),
        		new Punch(4999, "2025-05-05 18:56:28", 0),
        		new Punch(4999, "2025-05-05 18:56:26", 0),
        		new Punch(4999, "2025-05-05 06:14:27", 1),
        		new Punch(4999, "2025-05-04 21:52:58", 0),
        		new Punch(4999, "2025-05-04 06:11:31", 1),
        		new Punch(4999, "2025-05-03 21:49:31", 0),
        		new Punch(4999, "2025-05-03 07:33:30", 1),
        		new Punch(4999, "2025-05-02 21:58:39", 1),
        		new Punch(4999, "2025-05-02 21:58:36", 1),
        		new Punch(4999, "2025-05-02 06:11:27", 1),
        		new Punch(4999, "2025-05-01 21:50:12", 0),
        		new Punch(4999, "2025-05-01 06:07:25", 1),
        		new Punch(4999, "2025-04-30 18:09:09", 0),
        		new Punch(4999, "2025-04-30 06:14:38", 1),
        		new Punch(4999, "2025-04-29 18:07:33", 0),
        		new Punch(4999, "2025-04-29 06:18:05", 1),
        		new Punch(4999, "2025-04-29 06:18:02", 1),
        		new Punch(4999, "2025-04-28 17:54:25", 0),
        		new Punch(4999, "2025-04-28 06:23:35", 1),
        		new Punch(4999, "2025-04-27 18:01:53", 0),
        		new Punch(4999, "2025-04-27 06:17:37", 1),
        		new Punch(4999, "2025-04-26 17:48:24", 0),
        		new Punch(4999, "2025-04-26 06:15:07", 1),
        		new Punch(4999, "2025-04-26 06:15:04", 1)

        );

        Map<LocalDate, WorkDaySummary> dayMap = new HashMap<>();

        for (Punch p : punches) {
            LocalDate logicalDate = p.punchTime.toLocalTime().isAfter(LocalTime.of(21, 0))
                    ? p.punchTime.toLocalDate().plusDays(1)
                    : p.punchTime.toLocalDate();

            dayMap.putIfAbsent(logicalDate, new WorkDaySummary());
            WorkDaySummary summary = dayMap.get(logicalDate);
            summary.workDate = logicalDate;
            summary.allPunches.add(p.punchTime);
            if (p.punchState == 1) summary.ins.add(p.punchTime);
            else summary.outs.add(p.punchTime);
        }

        // Sort and print
        List<LocalDate> sortedDays = new ArrayList<>(dayMap.keySet());
        sortedDays.sort(Comparator.reverseOrder());

        System.out.printf("%-12s %-15s %-15s %-17s %s%n", "Date", "First Punch In", "Last Punch Out", "Total Punches", "Notes");
        System.out.println("----------------------------------------------------------------------------------------");
        for (LocalDate date : sortedDays) {
            WorkDaySummary wd = dayMap.get(date);
            System.out.printf("%-12s %-15s %-15s %-17d %s%n",
                    date,
                    wd.getFirstIn(),
                    wd.getLastOut(),
                    wd.allPunches.size(),
                    wd.getNote());
        }
    }
    
   

    private String formatDuration(Duration d) {
        long h = d.toHours();
        long m = (d.toMinutes() % 60);
        long s = (d.getSeconds() % 60);
        return String.format("%02d:%02d:%02d", h, m, s);
    }

}

