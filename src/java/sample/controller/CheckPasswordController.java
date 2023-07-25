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
import sample.dao.UserDAO;
import sample.dto.UserDTO;

/**
 *
 * @author Minh
 */
public class CheckPasswordController extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String username = request.getParameter("myusername");
            String password = request.getParameter("mypass");

            UserDAO dao = new UserDAO();
            UserDTO user = dao.Login(username, password);
            if (user == null) {
                response.setContentType("text/html");
                PrintWriter out = response.getWriter();
                out.print("Your password incorrect!");
            } else {
                response.setContentType("text/html");
                PrintWriter out = response.getWriter();
                out.print("Your password correct!");
            }
        } catch (Exception e) {
            e.getMessage();
        }

    }

}
