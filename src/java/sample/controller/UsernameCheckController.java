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
public class UsernameCheckController extends HttpServlet {

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String query = "SELECT * FROM tbl_Account WHERE user_name = ?";

        String myuser = request.getParameter("myuser");
        try {
            conn = new Utils().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, myuser);
            rs = ps.executeQuery();

            if (rs.next()) {
                response.setContentType("text/html");
                PrintWriter out = response.getWriter();
                out.print("This username has been taken, try another !");
            } else {
                response.setContentType("text/html");
                PrintWriter out = response.getWriter();
                if (myuser.length() < 8) {
                    out.print("Username must at least 8 characters !");
                } else {
                    out.print("Username is available to use !");
                }
            }
        } catch (Exception e) {
            e.getMessage();
        }
    }

}
