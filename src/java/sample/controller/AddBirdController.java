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
public class AddBirdController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Xử lý dữ liệu đăng ký
        try {
            PatientDAO dao = new PatientDAO();
            String user_name = request.getParameter("user_name");
            String bird_name = request.getParameter("bird_name");
            String age = request.getParameter("age");
            String gender = request.getParameter("gender");
            String species = request.getParameter("species");
            String species_id = dao.getIDSpecies(species).trim();
            String patient_id = Integer.toString(dao.MaxId() + 1);

            // Lưu hình ảnh
            Part part = request.getPart("bird_image");
            String fileName = getFileName(part);
            String realPath = request.getServletContext().getRealPath("/assets/img/patients/");// Đường dẫn để lưu trữ hình ảnh trên máy tính
            String url = "assets/img/patients/" + fileName;
            if ("".equals(fileName)) {
                PatientDTO bird = new PatientDTO(patient_id, bird_name, species_id, age, gender, null, user_name, true);
                boolean check_Insert = dao.addBird(bird);
                if (check_Insert) {
                    HttpSession session = request.getSession();
                    session.setAttribute("status", "AddBirdSucces");
                    response.sendRedirect("patient-dashboard.jsp");
                } else {
                    response.sendRedirect("index-2.jsp");
                }
            } else {
                part.write(realPath + fileName);
                PatientDTO bird = new PatientDTO(patient_id, bird_name, species_id, age, gender, url, user_name, true);
                boolean check_Insert = dao.addBird(bird);
                if (check_Insert) {
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
}
