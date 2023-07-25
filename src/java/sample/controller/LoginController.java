/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import sample.dao.UserDAO;
import sample.dto.UserDTO;

/**
 *
 * @author Minh
 */
public class LoginController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String userName = request.getParameter("username");
        String password = request.getParameter("password");
        String errorLogin = "The username or password is invalid";

        UserDAO dao = new UserDAO();
        UserDTO user = dao.Login(userName, password);
        if (user == null) {
            request.setAttribute("errorLogin", errorLogin);
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else {
            String getRoleID = user.getRole().trim();
            if (getRoleID.equalsIgnoreCase("1") || getRoleID.equalsIgnoreCase("5")) {
                HttpSession session = request.getSession();
                session.setAttribute("account", user);
                response.sendRedirect("admin/index.jsp");
            } else if (getRoleID.equalsIgnoreCase("3")) {
                HttpSession session = request.getSession();
                session.setAttribute("account", user);
                response.sendRedirect("doctor-dashboard.jsp");
            }else if (getRoleID.equalsIgnoreCase("2")) {
                HttpSession session = request.getSession();
                session.setAttribute("account", user);
                response.sendRedirect("staff.jsp");
            }else {
                HttpSession session = request.getSession();
                session.setAttribute("account", user);
                response.sendRedirect("index-2.jsp");
            }

        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
