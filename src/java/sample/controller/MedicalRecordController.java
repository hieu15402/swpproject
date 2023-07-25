/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.sql.Time;
import java.time.LocalDate;
import java.time.LocalTime;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import sample.dao.BookingDAO;
import sample.dao.MedicalRecordDAO;
import sample.dao.ServiceDAO;
import sample.dto.MedicalRecordDTO;

/**
 *
 * @author MSI AD
 */
public class MedicalRecordController extends HttpServlet {

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
            MedicalRecordDAO Mdao = new MedicalRecordDAO();
            BookingDAO dao = new BookingDAO();
            String bookingID = request.getParameter("booking_id").trim();
            boolean check = Mdao.CheckgetMRByBookingID(bookingID);
            if (check == true) {
                String record_id = request.getParameter("record_id");
                String index = request.getParameter("number_service");
                int count = Integer.parseInt(index);
                String[] list_service = new String[count];
                for (int i = 0; i < count; i++) {
                    String service_id = request.getParameter("service_" + Integer.toString(i + 1));
                    if (service_id != null) {
                        String[] part = service_id.split("-");
                        list_service[i] = part[1];
                    }

                }
                boolean checkSelect = false;

                for (int i = 0; i < list_service.length; i++) {
                    MedicalRecordDTO mr1 = new MedicalRecordDTO(record_id, null, 0, "", "", "", bookingID, dao.getServiceIDByName(list_service[i]), null);
                    checkSelect = Mdao.ServiceInMedical(mr1, false);
                }
                if (checkSelect == true) {
                    boolean checkUpdate = dao.CheckInBooking(bookingID, 7);
                    if (checkUpdate) {
                        LocalDate ngayHienTai = LocalDate.now();
                        LocalTime gioHienTai = LocalTime.now();
                        Time gioSQL = Time.valueOf(gioHienTai);

                        HttpSession session = request.getSession();
                        session.setAttribute("status", "medical");
                        response.sendRedirect("doctor-dashboard.jsp");

                    }
                }
            } else {
                String patientID = request.getParameter("patient_id").trim();
                String note = request.getParameter("note");
                String fee = request.getParameter("total_fee");
                double total_fee = Double.parseDouble(fee);
                String phone = request.getParameter("phone");
                String date = request.getParameter("date_again");
                LocalDate localDate = null;

                if (date == null) {
                } else {
                    localDate = LocalDate.parse(date);
                }
                Date sqlDate = Date.valueOf(localDate);
                String record_id = Integer.toString(Mdao.MaxId() + 1);
                String index = request.getParameter("number_service");
                int count = Integer.parseInt(index);
                String[] list_service = new String[count];
                for (int i = 0; i < count; i++) {
                    String service_id = request.getParameter("service_" + Integer.toString(i + 1));
                    String[] part = service_id.split("-");
                    list_service[i] = part[1];
                }
                boolean checkMR = false;
                boolean checkSelect = false;
                MedicalRecordDTO mr = new MedicalRecordDTO(record_id, sqlDate, total_fee, phone, note, patientID, bookingID, "", null);
                checkMR = Mdao.CreateMedical(mr);
                for (int i = 0; i < list_service.length; i++) {
                    MedicalRecordDTO mr1 = new MedicalRecordDTO(record_id, sqlDate, dao.getServiceFeeByName(list_service[i]), phone, note, patientID, bookingID, dao.getServiceIDByName(list_service[i]), null);
                    checkSelect = Mdao.ServiceInMedical(mr1, false);
                }
                if (checkMR == true && checkSelect == true) {
                    boolean checkUpdate = dao.CheckInBooking(bookingID, 7);
                    if (checkUpdate) {
                        LocalDate ngayHienTai = LocalDate.now();
                        LocalTime gioHienTai = LocalTime.now();
                        Time gioSQL = Time.valueOf(gioHienTai);

                        HttpSession session = request.getSession();
                        session.setAttribute("status", "medical");
                        response.sendRedirect("doctor-dashboard.jsp");

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
