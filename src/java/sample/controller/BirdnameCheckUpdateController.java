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
 * @author MSI AD
 */
public class BirdnameCheckUpdateController extends HttpServlet {

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String query = "SELECT bird_name FROM tbl_Patient_Bird WHERE bird_name = ? and user_name = ?";

        try {
            String myuser = request.getParameter("birdname_dash");
            String username = request.getParameter("username");
            conn = new Utils().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, myuser);
            ps.setString(2, username);
            rs = ps.executeQuery();

            if (rs.next()) {
                response.setContentType("text/html");
                PrintWriter out = response.getWriter();
                out.print("This birdname has been taken, try another");

            } else {
                response.setContentType("text/html");
                PrintWriter out = response.getWriter();
                out.print("Birdname is available to use");

            }
        } catch (Exception e) {
            e.getMessage();
        }
    }
}
