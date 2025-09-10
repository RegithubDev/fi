package com.resustainability.reisp.common;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class DateUtil {
    public static List<LocalDate> getDatesBetween(String from, String to) {
        LocalDate start = LocalDate.parse(from);
        LocalDate end = LocalDate.parse(to);
        List<LocalDate> dates = new ArrayList<>();
        while (!start.isAfter(end)) {
            dates.add(start);
            start = start.plusDays(1);
        }
        return dates;
    } }