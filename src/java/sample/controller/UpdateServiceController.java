/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.controller;

import java.io.IOException;
import java.net.URL;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import sample.dao.ServiceDAO;
import sample.dto.ServiceDTO;

/**
 *
 * @author TPTNam
 */
@MultipartConfig()
public class UpdateServiceController extends HttpServlet {

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
            ServiceDAO dao = new ServiceDAO();
            ServiceDTO ser;
            String ser_id = request.getParameter("service_id");
            String ser_name = request.getParameter("serviceName");
            float ser_fee = Float.parseFloat(request.getParameter("serviceFee"));
            String ser_des = request.getParameter("serviceDescription");
            String ser_detail = request.getParameter("serviceDetail");
            boolean ser_status = Boolean.parseBoolean(request.getParameter("status"));
            Part icon = request.getPart("icon");
            Part img = request.getPart("image");
            String realPath = request.getServletContext().getRealPath("/assets/img/Services_List/");
            HttpSession session = request.getSession();
            if (!icon.getSubmittedFileName().equals("") && !img.getSubmittedFileName().equals("")) {
                String iconFileName = icon.getSubmittedFileName();
                String imageFileName = img.getSubmittedFileName();
                icon.write(realPath + iconFileName);
                img.write(realPath + imageFileName);
                ser = new ServiceDTO(ser_id, ser_name, ser_detail, ser_des, ser_fee, "assets/img/Services_List/" + iconFileName, "assets/img/Services_List/" + imageFileName, ser_status);
                session.setAttribute("status_dashboard", "Service");
                dao.update(ser);
                response.sendRedirect("admin/index.jsp");
            } else if (!icon.getSubmittedFileName().equals("") && img.getSubmittedFileName().equals("")) {
                String iconFileName = icon.getSubmittedFileName();
                icon.write(realPath + iconFileName);
                ser = new ServiceDTO(ser_id, ser_name, ser_detail, ser_des, ser_fee, "assets/img/Services_List/" + iconFileName, null, ser_status);
                session.setAttribute("status_dashboard", "Service");
                dao.updateWithOutImage(ser);
                response.sendRedirect("admin/index.jsp");
            } else if (icon.getSubmittedFileName().equals("") && !img.getSubmittedFileName().equals("")) {
                String imageFileName = img.getSubmittedFileName();
                img.write(realPath + imageFileName);
                ser = new ServiceDTO(ser_id, ser_name, ser_detail, ser_des, ser_fee, null, "assets/img/Services_List/" + imageFileName, ser_status);
                session.setAttribute("status_dashboard", "Service");
                dao.updateWithOutIcon(ser);
                response.sendRedirect("admin/index.jsp");
            } else if (icon.getSubmittedFileName().equals("") && img.getSubmittedFileName().equals("")) {
                ser = new ServiceDTO(ser_id, ser_name, ser_detail, ser_des, ser_fee, null, null, ser_status);
                session.setAttribute("status_dashboard", "Service");
                dao.updateWithAnyIconImg(ser);
                response.sendRedirect("admin/index.jsp");
            }

        } catch (IOException | NumberFormatException | SQLException | ServletException e) {
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
