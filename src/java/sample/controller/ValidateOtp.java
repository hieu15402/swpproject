/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

;

/**
 *
 * @author Minh
 */
public class ValidateOtp extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int value_1 = Integer.parseInt(request.getParameter("num1"));
        int value_2 = Integer.parseInt(request.getParameter("num2"));
        int value_3 = Integer.parseInt(request.getParameter("num3"));
        int value_4 = Integer.parseInt(request.getParameter("num4"));
        int value_5 = Integer.parseInt(request.getParameter("num5"));
        int value_6 = Integer.parseInt(request.getParameter("num6"));

        int value = value_1 * 100000 + value_2 * 10000 + value_3 * 1000 + value_4 * 100 + value_5 * 10 + value_6;

        HttpSession session = request.getSession();
        int otp = (int) session.getAttribute("otp");

        if (value == otp) {
            request.setAttribute("email", request.getParameter("emailUser"));
            session.setAttribute("status", "success");
            request.getRequestDispatcher("newPassword.jsp").forward(request, response);
        } else {
            request.setAttribute("wrongOTP", true);
            request.getRequestDispatcher("inputOTP.jsp").forward(request, response);

        }

    }

}
