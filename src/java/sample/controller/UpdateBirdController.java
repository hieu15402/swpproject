/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import sample.dao.PatientDAO;
import sample.dto.PatientDTO;

@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50)	// 50MB
public class UpdateBirdController extends HttpServlet {

    private String getFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] tokens = contentDisp.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf("=") + 2, token.length() - 1);
            }
        }
        return "";
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String name_bird = request.getParameter("birdname");
            String species = request.getParameter("species");
            String age = request.getParameter("age");
            String gender = request.getParameter("gender");
            String patient_id = request.getParameter("patient_id");
            String species_id = request.getParameter("species_id");

            Part part = request.getPart("image_bird");
            String fileName = getFileName(part);
            String realPath = request.getServletContext().getRealPath("/assets/img/patients/");// Đường dẫn để lưu trữ hình ảnh trên máy tính
            String url = "assets/img/patients/" + fileName;
            PatientDAO dao = new PatientDAO();
            if ("".equals(fileName)) {
                PatientDTO bird = new PatientDTO(patient_id, name_bird, species_id, age, gender, url, "", true);
                boolean checkUpdate = dao.UpdateBirdNoImage(bird);
                if (checkUpdate == true) {
                    HttpSession session = request.getSession();
                    session.setAttribute("status", "AddBirdSucces");
                    response.sendRedirect("patient-dashboard.jsp");
                } else {
                    response.sendRedirect("index-2.jsp");
                }
            } else {
                part.write(realPath + fileName);
                PatientDTO bird = new PatientDTO(patient_id, name_bird, species_id, age, gender, url, "", true);
                boolean checkUpdate = dao.UpdateBird(bird);
                if (checkUpdate == true) {
                    
                    HttpSession session = request.getSession();
                    session.setAttribute("status", "AddBirdSucces");
                    response.sendRedirect("patient-dashboard.jsp");
                } else {
                    response.sendRedirect("index-2.jsp");
                }
            }

        } catch (Exception e) {

        }
    }

}
