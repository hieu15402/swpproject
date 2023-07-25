/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.controller;

import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import sample.dao.UserDAO;
import sample.dto.UserDTO;

/**
 *
 * @author TPTNam
 */
public class UpdateProfileUserController extends HttpServlet {

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
            throws ServletException, IOException, SQLException, ParseException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            UserDAO dao = new UserDAO();
            UserDTO us = new UserDTO();
            String username = request.getParameter("username").trim();
            String fullname = request.getParameter("fullname").trim();
            String dateString = request.getParameter("dateofbirth").trim();
            String email = request.getParameter("email").trim();
            String gender = request.getParameter("gender").trim();
            String urlimg = request.getParameter("avatarnone").trim();
            Part icon = request.getPart("avatar");
            String realPath = request.getServletContext().getRealPath("/assets/img/").trim();
//            HttpSession session = request.getSession();
            if (!icon.getSubmittedFileName().equals("")) {
                String iconFileName = icon.getSubmittedFileName();
                icon.write(realPath + iconFileName);
                us = new UserDTO(username, email, request.getParameter("phone"), dateString, fullname, gender, "./assets/img/" + iconFileName);
//                session.setAttribute("status_dashboard", "Service");
                dao.UpdateUserProfile(us);
                response.sendRedirect("patient-dashboard.jsp");

            } else if (icon.getSubmittedFileName().equals("")) {
                us = new UserDTO(username, email, request.getParameter("phone"), dateString, fullname, gender, urlimg);
//                session.setAttribute("status_dashboard", "Service");
                dao.UpdateUserProfile(us);
                response.sendRedirect("patient-dashboard.jsp");
            }

        } catch (IOException | NumberFormatException | ServletException e) {
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(UpdateProfileUserController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ParseException ex) {
            Logger.getLogger(UpdateProfileUserController.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(UpdateProfileUserController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ParseException ex) {
            Logger.getLogger(UpdateProfileUserController.class.getName()).log(Level.SEVERE, null, ex);
        }
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
