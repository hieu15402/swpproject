/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import sample.utils.Utils;

/**
 *
 * @author Minh
 */
public class EmailCheckControllerReverse extends HttpServlet {

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String query = "SELECT * FROM tbl_Account WHERE email = ? AND status = 1";

        String myemail = request.getParameter("myemail_1");
        try {
            conn = new Utils().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, myemail);
            rs = ps.executeQuery();

            if (rs.next()) {
                response.setContentType("text/html");
                PrintWriter out = response.getWriter();
                if (!myemail.matches("^([\\w]*[\\w\\.]*(?!\\.)@gmail.com)")) {
                    out.print("It looks like you may have entered an incorrect email!");
                } else {
                    out.print("Email is available to reset password !");
                }
            } else {
                response.setContentType("text/html");
                PrintWriter out = response.getWriter();
                if (!myemail.matches("^([\\w]*[\\w\\.]*(?!\\.)@gmail.com)")) {
                    out.print("It looks like you may have entered an incorrect email!");
                } else {
                    out.print("Your entered email does not match any account !");
                }
            }
        } catch (Exception e) {
            e.getMessage();
        }
    }

}
