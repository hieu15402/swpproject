/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.controller;

import java.io.File;
import java.io.IOException;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import sample.dao.UserDAO;

@MultipartConfig
public class UpdateDoctorSettingProfileController extends HttpServlet {

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
        String username = request.getParameter("username");
        String fullname = request.getParameter("fullname");
        String phone = request.getParameter("phone");
        String gender = request.getParameter("gender");
        String dob = request.getParameter("date_of_birth");
        String bio = request.getParameter("bio");
        UserDAO dao = new UserDAO();
        Part filePart = request.getPart("file");
        String realPath = request.getServletContext().getRealPath("/assets/img/doctors/");
        String fileName = filePart.getSubmittedFileName(); // Lấy tên tệp ảnh gốc
        if (!fileName.isEmpty()) {

            String destinationPath = realPath + fileName;

            filePart.write(destinationPath);

            String imagePath = "assets/img/doctors/" + fileName; // Đường dẫn tệp ảnh từ gốc ứng dụng web
            try {
                dao.UpdateDoctorProfile(username, fullname, phone, gender, dob, bio, imagePath);
                HttpSession session = request.getSession();
                session.setAttribute("status", "doctor-profile");
            } catch (Exception e) {
                log("Error at UpdateDoctorSettingProfileController" + e.toString());
            } finally {
                //response.sendRedirect("doctor-profile-settings.jsp");

                request.getRequestDispatcher("doctor-dashboard.jsp").forward(request, response);
            }
        } else {
            try {
                dao.UpdateDoctorProfile(username, fullname, phone, gender, dob, bio);
                HttpSession session = request.getSession();
                session.setAttribute("status", "doctor-profile");
            } catch (Exception e) {
                log("Error at UpdateDoctorSettingProfileController" + e.toString());
            } finally {
                //response.sendRedirect("doctor-profile-settings.jsp");

                request.getRequestDispatcher("doctor-dashboard.jsp").forward(request, response);
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
