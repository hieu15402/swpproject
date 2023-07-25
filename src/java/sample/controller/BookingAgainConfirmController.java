/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import sample.dao.BookingDAO;
import sample.dto.BookingDTO;
import sample.dto.UserDTO;

/**
 *
 * @author sasak
 */
public class BookingAgainConfirmController extends HttpServlet {

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
            throws ServletException, IOException, ParseException {
        response.setContentType("text/html;charset=UTF-8");

        BookingDAO dao = new BookingDAO();

        HttpSession session = request.getSession();
        UserDTO user = (UserDTO) session.getAttribute("account");

        String serviceId = request.getParameter("service");
        String patientID = request.getParameter("patient");
        String doctorUsername = request.getParameter("doctor");
        String date = request.getParameter("date");
        String slotId = request.getParameter("slot");
        String slotName = dao.getSlotByID(Integer.parseInt(slotId)).getTime_slot();

        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        java.util.Date utilDate;
        utilDate = format.parse(date);
        java.sql.Date dateSQL = new java.sql.Date(utilDate.getTime());

        String bookingID = dao.getLastedBookingID();
        int number = Integer.parseInt(bookingID.trim().substring(2));
        number++;
        bookingID = "BK" + number;

        BookingDTO booking = new BookingDTO(bookingID, doctorUsername, user.getUsername(), dateSQL, serviceId, Integer.parseInt(slotId), patientID, 1);

        LocalTime currentTime = LocalTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm:ss");
        String timeNow = currentTime.format(formatter);
        LocalDate currentDate = LocalDate.now();
        DateTimeFormatter formatterDay = DateTimeFormatter.ofPattern("yyyy/MM/dd");
        String dateNow = currentDate.format(formatterDay);

        dao.insertIntoBooking(booking);
        dao.insertIntoBookingDetails(bookingID, 1, dateNow, timeNow);

        request.setAttribute("date", date);
        request.setAttribute("time", slotName);
        request.setAttribute("booking", bookingID);
        request.setAttribute("service", serviceId);
        request.getRequestDispatcher("booking-success.jsp").forward(request, response);
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
        } catch (ParseException ex) {
            Logger.getLogger(BookingAgainConfirmController.class.getName()).log(Level.SEVERE, null, ex);
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
        } catch (ParseException ex) {
            Logger.getLogger(BookingAgainConfirmController.class.getName()).log(Level.SEVERE, null, ex);
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
