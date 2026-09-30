package com.chat;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (username == null || password == null ||
                username.trim().isEmpty() ||
                password.trim().isEmpty()) {

            response.sendRedirect(
                    "login.jsp?error=Please enter username and password"
            );

            return;
        }

        String sql =
                "SELECT username FROM users " +
                "WHERE username = ? AND password = ?";

        try (Connection connection =
                     DBConnection.getConnection()) {

            if (connection == null) {

                response.sendRedirect(
                        "login.jsp?error=Database connection failed"
                );

                return;
            }

            try (PreparedStatement statement =
                         connection.prepareStatement(sql)) {

                statement.setString(1, username.trim());
                statement.setString(2, password);

                try (ResultSet result =
                             statement.executeQuery()) {

                    if (result.next()) {

                        HttpSession session =
                                request.getSession();

                        session.setAttribute(
                                "username",
                                result.getString("username")
                        );

                        response.sendRedirect("chat.jsp");

                    } else {

                        response.sendRedirect(
                                "login.jsp?error=Invalid username or password"
                        );
                    }
                }
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    "login.jsp?error=Database error"
            );
        }
    }
}