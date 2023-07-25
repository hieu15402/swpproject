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
public class PhoneCheckController extends HttpServlet {

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String query = "SELECT * FROM tbl_Account WHERE phone = ?";

        String myphone = request.getParameter("myphone");
        try {
            conn = new Utils().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, myphone);
            rs = ps.executeQuery();

            if (rs.next()) {
                response.setContentType("text/html");
                PrintWriter out = response.getWriter();
                out.print("This phone has been taken, try another !");
            } else {
                response.setContentType("text/html");
                PrintWriter out = response.getWriter();
                if (!myphone.matches("^0\\d{9,10}$")) {
                    out.print("It looks like you may have entered an incorrect phone!");
                } else {
                    out.print("Phone is available to use !");
                }

            }
        } catch (Exception e) {
            e.getMessage();
        }
    }

}
