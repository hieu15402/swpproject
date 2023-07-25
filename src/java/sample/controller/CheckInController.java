/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.sql.Time;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import sample.dao.BookingDAO;
import sample.dao.MedicalRecordDAO;
import sample.dto.MedicalRecordDTO;

/**
 *
 * @author MSI AD
 */
public class CheckInController extends HttpServlet {

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
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            String bookingID = request.getParameter("bookingID").trim();
            int booking_status = Integer.parseInt(request.getParameter("status_booking"));
            BookingDAO dao = new BookingDAO();
            MedicalRecordDAO Mdao = new MedicalRecordDAO();
            

            if (booking_status == 3) {
                 String record_id = Integer.toString(Mdao.MaxId() + 1);
                String service = request.getParameter("service");
                MedicalRecordDTO mr1 = new MedicalRecordDTO(record_id, null, dao.getServiceFeeByName(service), "", "", "", "", dao.getServiceIDByName(service), null);
                boolean check = Mdao.ServiceInMedical(mr1, true);
                if (check == true) {
                    boolean checkUpdate = dao.CheckInBooking(bookingID, booking_status);
                    if (checkUpdate) {
                        LocalDate ngayHienTai = LocalDate.now();
                        LocalTime gioHienTai = LocalTime.now();
                        Time gioSQL = Time.valueOf(gioHienTai);
                        boolean checkHistory = dao.InsertHistory(bookingID, booking_status, ngayHienTai, gioSQL, null);
                        if (checkHistory) {
                            HttpSession session = request.getSession();
                            if (booking_status == 3) {
                                session.setAttribute("status", "Assign");
                            } else if (booking_status == 4) {
                                session.setAttribute("status", "CheckIn");
                            } else if (booking_status == 5 || booking_status == 8) {
                                session.setAttribute("status", "CheckOut");
                            }
                            response.sendRedirect("staff.jsp");
                        }
                    }

                }
            } else if (booking_status == 8) {
                String record_id = request.getParameter("record_id");
                List<String> list_ser = Mdao.getListServiceMore(Mdao.getMRByBookingID(bookingID).getRecord_id());
                boolean checkUpdateSer = false;
                for (String ls : list_ser) {
                    checkUpdateSer = Mdao.UpdateSelectService(record_id, ls);
                }
                if (checkUpdateSer == true) {
                    boolean checkUpdate = dao.CheckInBooking(bookingID, booking_status);
                    if (checkUpdate) {
                        LocalDate ngayHienTai = LocalDate.now();
                        LocalTime gioHienTai = LocalTime.now();
                        Time gioSQL = Time.valueOf(gioHienTai);
                        HttpSession session = request.getSession();
                        session.setAttribute("status", "CheckOut");
                        response.sendRedirect("staff.jsp");
                    }

                }
            } else {
                boolean checkUpdate = dao.CheckInBooking(bookingID, booking_status);
                if (checkUpdate) {
                    LocalDate ngayHienTai = LocalDate.now();
                    LocalTime gioHienTai = LocalTime.now();
                    Time gioSQL = Time.valueOf(gioHienTai);
                    boolean checkHistory = dao.InsertHistory(bookingID, booking_status, ngayHienTai, gioSQL, null);
                    if (checkHistory) {
                        HttpSession session = request.getSession();
                        if (booking_status == 3) {
                            session.setAttribute("status", "Assign");
                        } else if (booking_status == 4) {
                            session.setAttribute("status", "CheckIn");
                        } else if (booking_status == 5) {
                            session.setAttribute("status", "CheckOut");
                        }
                        response.sendRedirect("staff.jsp");
                    }
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(CheckInController.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(CheckInController.class.getName()).log(Level.SEVERE, null, ex);
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
