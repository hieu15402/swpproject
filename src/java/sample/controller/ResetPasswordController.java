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
import sample.dao.UserDAO;

/**
 *
 * @author Minh
 */
public class ResetPasswordController extends HttpServlet {

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
        try {
            UserDAO dao = new UserDAO();
            String newPass = request.getParameter("password");
            String newCPass = request.getParameter("confirm_password");
            String email = request.getParameter("emailUser");
            String oldPass = dao.checkPassDuplicate(email);
            String correctPass = "Reset password successfully !";
            String incorrectPass = "Your password confirm does not match!";
            String dupPass = "It's look like you enter your old password !";

            if (!newPass.trim().equalsIgnoreCase(newCPass)) {
                request.setAttribute("incorrectPass", incorrectPass);
                request.getRequestDispatcher("newPassword.jsp").forward(request, response);
            } else {
                if (newCPass.trim().equalsIgnoreCase(oldPass)) {
                    request.setAttribute("dupPass", dupPass);
                    request.getRequestDispatcher("newPassword.jsp").forward(request, response);
                } else {
                    dao.changePasswordByEmail(newPass, email);
                    request.setAttribute("correctPass", correctPass);
                    request.getRequestDispatcher("newPassword.jsp").forward(request, response);
                }
            }
        } catch (Exception e) {
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
