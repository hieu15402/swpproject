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
import javax.servlet.http.Part;

@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50)	// 50MB
public class ImageBirdController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String part = request.getParameter("imgbird");
       //     String fileName = getFileName(part);
            String[] parts = part.split("\\.");
            if ("jpg".equals(parts[parts.length - 1]) || "png".equals(parts[parts.length - 1])) {
                response.setContentType("text/html");
                PrintWriter out = response.getWriter();
                out.print("Image is available to use");
            } else {
                response.setContentType("text/html");
                PrintWriter out = response.getWriter();
                out.print("Allowed JPG, or PNG, try another");
            }
        } catch (Exception e) {
            e.getMessage();
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
