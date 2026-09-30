package com.chat;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/chat")
public class ChatServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/plain;charset=UTF-8");

        HttpSession session =
                request.getSession(false);

        if (session == null ||
                session.getAttribute("username") == null) {

            response.getWriter().print("Please login first");

            return;
        }

        String sender =
                (String) session.getAttribute("username");

        String receiver =
                request.getParameter("receiver");

        String message =
                request.getParameter("message");

        if (receiver == null ||
                receiver.trim().isEmpty()) {

            response.getWriter().print(
                    "Receiver is required"
            );

            return;
        }

        if (message == null ||
                message.trim().isEmpty()) {

            response.getWriter().print(
                    "Message is required"
            );

            return;
        }

        receiver = receiver.trim();
        message = message.trim();

        String sql =
                "INSERT INTO messages " +
                "(sender, receiver, message) " +
                "VALUES (?, ?, ?)";

        try (Connection connection =
                     DBConnection.getConnection()) {

            if (connection == null) {

                response.getWriter().print(
                        "Database connection failed"
                );

                return;
            }

            try (PreparedStatement statement =
                         connection.prepareStatement(sql)) {

                statement.setString(1, sender);
                statement.setString(2, receiver);
                statement.setString(3, message);

                statement.executeUpdate();

                response.getWriter().print("success");
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.getWriter().print(
                    "Database error"
            );
        }
    }


    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType(
                "application/json;charset=UTF-8"
        );

        PrintWriter out = response.getWriter();

        HttpSession session =
                request.getSession(false);

        if (session == null ||
                session.getAttribute("username") == null) {

            out.print("[]");

            return;
        }

        String currentUser =
                (String) session.getAttribute("username");

        String receiver =
                request.getParameter("receiver");

        if (receiver == null ||
                receiver.trim().isEmpty()) {

            out.print("[]");

            return;
        }

        receiver = receiver.trim();

        String sql =
                "SELECT sender, receiver, message, " +
                "DATE_FORMAT(message_time, '%Y-%m-%d %H:%i:%s') AS time " +
                "FROM messages " +
                "WHERE (sender = ? AND receiver = ?) " +
                "OR (sender = ? AND receiver = ?) " +
                "ORDER BY message_time ASC";

        try (Connection connection =
                     DBConnection.getConnection()) {

            if (connection == null) {

                out.print("[]");

                return;
            }

            try (PreparedStatement statement =
                         connection.prepareStatement(sql)) {

                statement.setString(1, currentUser);
                statement.setString(2, receiver);
                statement.setString(3, receiver);
                statement.setString(4, currentUser);

                try (ResultSet result =
                             statement.executeQuery()) {

                    StringBuilder json =
                            new StringBuilder();

                    json.append("[");

                    boolean first = true;

                    while (result.next()) {

                        if (!first) {
                            json.append(",");
                        }

                        first = false;

                        json.append("{");

                        json.append("\"sender\":\"")
                                .append(
                                        escapeJson(
                                                result.getString("sender")
                                        )
                                )
                                .append("\",");

                        json.append("\"receiver\":\"")
                                .append(
                                        escapeJson(
                                                result.getString("receiver")
                                        )
                                )
                                .append("\",");

                        json.append("\"message\":\"")
                                .append(
                                        escapeJson(
                                                result.getString("message")
                                        )
                                )
                                .append("\",");

                        json.append("\"time\":\"")
                                .append(
                                        escapeJson(
                                                result.getString("time")
                                        )
                                )
                                .append("\"");

                        json.append("}");
                    }

                    json.append("]");

                    out.print(json);
                }
            }

        } catch (Exception e) {

            e.printStackTrace();

            out.print("[]");
        }
    }


    private String escapeJson(String value) {

        if (value == null) {
            return "";
        }

        return value
                .replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\b", "\\b")
                .replace("\f", "\\f")
                .replace("\n", "\\n")
                .replace("\r", "\\r")
                .replace("\t", "\\t");
    }
}