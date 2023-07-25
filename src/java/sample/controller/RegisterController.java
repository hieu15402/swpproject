/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.controller;

import java.io.IOException;
import java.net.URLDecoder;
import java.nio.charset.StandardCharsets;
import java.sql.Date;
import java.text.SimpleDateFormat;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.http.client.methods.HttpPost;
import sample.dao.UserDAO;
import sample.dto.UserDTO;

/**
 *
 * @author Minh
 */
public class RegisterController extends HttpServlet {

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
        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        //Get value of users input
        //Lists error when user input incorrect
        String errorUsername = "*Invalid input username";
        String errorEmail = "*The email has already been taken.";
        String errorPhone = "*The phone has already been taken.";
        String errorCoPass = "*The password confirmation does not match.";

        try {
            String username = request.getParameter("username");
            String fullname = request.getParameter("fullname");
            String fullname_decode = new String(fullname.getBytes(StandardCharsets.ISO_8859_1), StandardCharsets.UTF_8);
            String email = request.getParameter("email");

            String gender = request.getParameter("gender");
            String dobString = request.getParameter("dob");
            //Chỗ này đổi này tháng chuỗi sang java date
            SimpleDateFormat inputDateFormat = new SimpleDateFormat("yyyy-MM-dd");
            java.util.Date utilDate = inputDateFormat.parse(dobString);
            java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());

            String phone = request.getParameter("phone");
            String password = request.getParameter("password");
            String confirm_password = request.getParameter("confirm_password");

            //Check input (username)
            String usernamePattern = "^[a-zA-Z0-9]{5,19}$";
            UserDAO dao = new UserDAO();
            UserDTO user2 = dao.checkExistEmail(email);
            UserDTO user3 = dao.checkExistPhone(phone);
            //Check input (password)
//            if (!username.matches(usernamePattern)) {
//                request.setAttribute("errorUsername", errorUsername);
//                request.getRequestDispatcher("register.jsp").forward(request, response);
//            } else 
            if (!password.equalsIgnoreCase(confirm_password)) {
                request.setAttribute("errorCoPass", errorCoPass);
                request.getRequestDispatcher("register.jsp").forward(request, response);
            } else if (user2 != null) {
                request.setAttribute("errorEmail", errorEmail);
                request.getRequestDispatcher("register.jsp").forward(request, response);
            } else if (user3 != null) {
                request.setAttribute("errorPhone", errorPhone);
                request.getRequestDispatcher("register.jsp").forward(request, response);
            } else {
                UserDTO user = dao.checkExistAccount(username);
                if (user == null) {
                    dao.signUpAccount(username, fullname_decode, email, gender, sqlDate, phone, password);
                    UserDTO a = dao.Login(username, password);
                    session.setAttribute("account", a);
                    response.sendRedirect("index-2.jsp");
                } else {
                    request.getRequestDispatcher("register.jsp").forward(request, response);
                }

            }
        } catch (Exception e) {
            e.printStackTrace();
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
