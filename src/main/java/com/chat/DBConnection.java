package com.chat;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    private static final String URL =
            "jdbc:mysql://db01.dbhost.dev:5051/db_454smw44z"
            + "?useSSL=false"
            + "&serverTimezone=Asia/Kolkata"
            + "&allowPublicKeyRetrieval=true";

    private static final String USER = "user_454smw44z";

    private static final String PASSWORD = "YOUR_PASSWORD";

    public static Connection getConnection() {

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");

            return DriverManager.getConnection(
                    URL,
                    USER,
                    PASSWORD
            );

        } catch (Exception e) {

            e.printStackTrace();

            return null;
        }
    }
}