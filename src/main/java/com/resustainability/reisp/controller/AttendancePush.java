package com.resustainability.reisp.controller;


import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.Gson;

import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.*;
import java.util.Base64;

public class AttendancePush {

    private static final String SOURCE_DB_URL =  "jdbc:sqlserver://10.125.145.217:1433;databaseName=INOPSETPDB;encrypt=false";
    private static final String SOURCE_USER = "appuser";
    private static final String SOURCE_PASS = "Appuser@123$";
 
    private static final String API_URL = "https://mcdonline.nic.in/nnapi-ndmc/api/attendance/narela/pushAttendance";
    private static final String AUTH_HEADER = "Basic " + Base64.getEncoder().encodeToString("TRUSERAPI:TRNINE2022".getBytes());

    public static void main(String[] args) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultSet = null;

        try {
            // Load JDBC driver
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

            // Connect to source DB
            connection = DriverManager.getConnection(SOURCE_DB_URL, SOURCE_USER, SOURCE_PASS);

            // SQL query
            String query =
                    "WITH EmployeeDailyPunches AS ( " +
                    "    SELECT ct.emp_code AS employeeId, pe.first_name AS employeeName, ct.area_alias, " +
                    "           ct.terminal_sn AS deviceId, CAST(ct.punch_time AS DATE) AS punchDate, " +
                    "           MIN(ct.punch_time) AS inDateTime, MAX(ct.punch_time) AS outDateTime " +
                    "    FROM iclock_transaction ct " +
                    "    LEFT JOIN personnel_employee pe ON ct.emp_code = pe.emp_code " +
                    "    WHERE CAST(ct.punch_time AS DATE) = CAST(GETDATE()  AS DATE) and ct.area_alias = 'MSW-CTN-IPMSWL-DL-Narela Bawana' " +
                    "    GROUP BY ct.emp_code, pe.first_name, ct.area_alias, ct.terminal_sn, CAST(ct.punch_time AS DATE) " +
                    ") " +
                    "SELECT employeeId, employeeName, area_alias, deviceId, inDateTime, outDateTime " +
                    "FROM EmployeeDailyPunches " +
                    "ORDER BY employeeId DESC";

            statement = connection.createStatement();
            resultSet = statement.executeQuery(query);

            // Convert result set to JSON array
            JsonArray jsonArray = new JsonArray();
            int uib = 1;
            while (resultSet.next()) {
                JsonObject obj = new JsonObject();
                obj.addProperty("deviceId", resultSet.getString("deviceId"));
                obj.addProperty("employeeId", resultSet.getString("employeeId"));
                obj.addProperty("uib", uib++);
                obj.addProperty("employeeName", resultSet.getString("employeeName"));
                obj.addProperty("inLocation", true);  // static
                obj.addProperty("outLocation", false); // static
                obj.addProperty("inDateTime", resultSet.getString("inDateTime"));
                obj.addProperty("outDateTime", resultSet.getString("outDateTime"));
                jsonArray.add(obj);
            }

            // Prepare JSON string
            String jsonPayload = new Gson().toJson(jsonArray);
            System.out.println("JSON Payload:\n" + jsonPayload);
            // Send POST request
            URL url = new URL(API_URL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json");
            conn.setRequestProperty("Authorization", AUTH_HEADER);
            conn.setDoOutput(true);

            try (OutputStream os = conn.getOutputStream()) {
                byte[] input = jsonPayload.getBytes("utf-8");
                os.write(input, 0, input.length);
            }

            int responseCode = conn.getResponseCode();
            System.out.println("HTTP Response Code: " + responseCode);
            if (responseCode == 200 || responseCode == 201) {
                System.out.println("Attendance pushed successfully.");
            } else {
                System.out.println("Failed to push attendance. HTTP response code: " + responseCode);
            }

         

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Cleanup
            try {
                if (resultSet != null) resultSet.close();
                if (statement != null) statement.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
