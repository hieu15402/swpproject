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
import java.util.Calendar;
import java.util.Properties;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import sample.dao.BookingDAO;
import sample.dao.PatientDAO;
import sample.dao.ServiceDAO;
import sample.dao.UserDAO;
import sample.dto.BookingDTO;

/**
 *
 * @author MSI AD
 */
public class CancelController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            String bookingID = request.getParameter("bookingID").trim();
            BookingDAO dao = new BookingDAO();
            UserDAO dao_1 = new UserDAO();
            ServiceDAO dao_2 = new ServiceDAO();
            PatientDAO dao_3 = new PatientDAO();
            BookingDTO book = dao.getBookingByID(bookingID);

            //lay thong tin send to email
            String email = dao_1.getEmailByUsername(book.getUsername_customer());
            String fullname = dao_1.getFullNameByUsername(book.getUsername_customer());

            String phone = dao_1.getPhoneByUsername(book.getUsername_customer());
            String doctorName = dao_1.getFullNameByUsername(book.getUsername_doctor());
            String birdName = dao_3.getBirdNameByPatientId(book.getPatient_id());
            Date date_1 = book.getDate();
            String note_email = request.getParameter("note_email");
            if (note_email == null) {
                note_email = "";
            }
            String serviceName = dao_2.getServiceName(book.getService_id());
            String time_slot = dao_2.getTimeSlot(book.getSlot_number());
            String[] parts = time_slot.split("-");
            String startTime = parts[0];

            Calendar calendar = Calendar.getInstance();
            calendar.setTime(date_1);

            int dayOfWeek = calendar.get(Calendar.DAY_OF_WEEK);

            String dayOfWeekString = "";
            switch (dayOfWeek) {
                case Calendar.MONDAY:
                    dayOfWeekString = "Mon";
                    break;
                case Calendar.TUESDAY:
                    dayOfWeekString = "Tue";
                    break;
                case Calendar.WEDNESDAY:
                    dayOfWeekString = "Wed";
                    break;
                case Calendar.THURSDAY:
                    dayOfWeekString = "Thu";
                    break;
                case Calendar.FRIDAY:
                    dayOfWeekString = "Fri";
                    break;
                case Calendar.SATURDAY:
                    dayOfWeekString = "Sat";
                    break;
                case Calendar.SUNDAY:
                    dayOfWeekString = "Sun";
                    break;
            }
            if (email != null || !email.equals("")) {
                String to = email;// change accordingly
                // Get the session object
                Properties props = new Properties();
                props.put("mail.smtp.host", "smtp.gmail.com");
                props.put("mail.smtp.socketFactory.port", "465");
                props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
                props.put("mail.smtp.auth", "true");
                props.put("mail.smtp.port", "465");
                Session session_1 = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
                    @Override
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication("thedearbirdclinic@gmail.com", "apcbriouhtfefznu");// Put your email
                        // id and
                        // password here
                    }
                });
                try {
                    MimeMessage message = new MimeMessage(session_1);
                    message.setFrom(new InternetAddress(email));// change accordingly
                    message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
                    message.setSubject("THEDEARBIRD canceled the appointment");
//                message.setText("Your thebirdclinic OTP code is: " + otpvalue);
                    MimeMultipart multipart = new MimeMultipart();

                    // Create a MimeBodyPart for the HTML content
                    MimeBodyPart htmlPart = new MimeBodyPart();
                    String htmlContent = "<!DOCTYPE html>\n"
                            + "<html>\n"
                            + "\n"
                            + "<head>\n"
                            + "    <base target=\"_top\">\n"
                            + "</head>\n"
                            + "\n"
                            + "<body>\n"
                            + "    <div\n"
                            + "        style=\"display: flex; align-items: center; justify-content: space-between;  font-family: Helvetica,Arial,sans-serif;width:700px;overflow:auto;line-height:1.5; margin: auto;\">\n"
                            + "        <div style=\"margin:50px auto;width:80%;padding:20px 0\">\n"
                            + "            <div style=\"border-bottom:5px solid #eee\">\n"
                            + "                <a href=\"\" style=\"font-size:30px; text-decoration:none; font-weight:600;margin-top: 112px;\"><img\n"
                            + "                        style=\"width: 150px; height: 150px;\"\n"
                            + "                        src=\"https://i.pinimg.com/originals/05/49/a2/0549a2976d1e0f3f2a9b503315013692.png\"></a>\n"
                            + "                <a style=\"float: right; margin-top: 75px; font-size: 20px;\">Booking Confirmation</a>\n"
                            + "            </div>\n"
                            + "            <h4 style=\"color: 333232;\">Hi " + fullname + ",</h4>\n"
                            + "            <p style=\"font-size:15px; color: 333232;\">Your booking request at <strong>The Dear Bird Clinic</strong> has been <br>\n"
                            + "                <strong style=\"color: #fc1313;\">canceled !</strong>\n"
                            + "            </p>\n"
                            + "\n"
                            + "            <div\n"
                            + "                style=\"height: 450px; width: 90%; border: 1px solid #eee;border-bottom: 10px solid #eee;border-top: 10px solid #eee; margin: auto auto; display: flex; flex-direction: column;\">\n"
                            + "                <div style=\"width: 100%; height: 100%;\">\n"
                            + "                    <p style=\"margin-left: 30px; color: 333232;\">CONTACT INFORMATION</p>\n"
                            + "                    <p style=\"margin-left: 30px; color: 333232;\"><b>Fullname:</b><span style=\"margin-left: 65px;\">" + fullname + "\n"
                            + "                            </span></p>\n"
                            + "                    <p style=\"margin-left: 30px; color: 333232;\"><b>Phone:</b><span style=\"margin-left: 82px;\">" + phone + "</span></p>\n"
                            + "                    <p style=\"margin-left: 30px; color: 333232;\"><b>Email:</b><span\n"
                            + "                            style=\"margin-left: 87px;\">" + email + "</span></p>\n"
                            + "                    <div style=\"width: 100%; border-bottom: 10px solid #eee;\"></div>\n"
                            + "                    <p style=\"margin-left: 30px; color: 333232;\">BOOKING INFORMATION</p>\n"
                            + "                    <p style=\"margin-left: 30px; color: 333232;\"><b>Booked with:</b><span style=\"margin-left: 44px;\">Dr " + doctorName + "</span></p>\n"
                            + "                    <p style=\"margin-left: 30px; color: 333232;\"><b>Date:</b><span style=\"margin-left: 93px;\">" + dayOfWeekString + " " + date_1 + " at\n"
                            + "                            " + time_slot + "</span></p>\n"
                            + "                    <p style=\"margin-left: 30px; color: 333232;\"><b>Booking for:</b><span style=\"margin-left: 48px;\">" + birdName
                            + "</span>\n"
                            + "                    </p>\n"
                            + "                    <p style=\"margin-left: 30px; color: 333232;\"><b>Service name:</b><span style=\"margin-left: 37px;\">" + serviceName + "</span>\n"
                            + "                    </p>\n"
                            + "                     <p style=\"margin-left:30px;color:333232\"><b>Status:</b><span style=\"margin-left: 81px; padding: 5px; background: red; color: #fff; border-radius: 5px;\">Canceled</span></p>"
                            + "              <p style=\"margin-left:30px;color:333232\">\n"
                            + "    <b>Note:</b><span style=\"margin-left: 124px;margin-right: 20px;display: inline-block;\"><i>" + note_email + "</i></span>\n"
                            + "                    </p>  "
                            + "</div>\n"
                            + "            </div>\n"
                            + "            <p style=\"font-size:15px; color: red;\"><i>Note***: You need to come to the clinic <b>15 minutes</b> before\n"
                            + "                    <b>" + startTime + "</b> on <b>" + date_1 + "</b>. Our clinic will give up the seat to another customer if you do\n"
                            + "                    not arrive on time as requested.</i></p>\n"
                            + "\n"
                            + "            <hr style=\"border:none;border-top:5px solid #eee\" />\n"
                            + "            <div style=\"float:right;padding:8px 0;color:#aaa;font-size:0.8em;line-height:1;font-weight:300\">\n"
                            + "                <p>thedearbird Inc</p>\n"
                            + "                <p>FPT University, HCM</p>\n"
                            + "            </div>\n"
                            + "        </div>\n"
                            + "    </div>\n"
                            + "</body>\n"
                            + "\n"
                            + "</html>";
                    htmlPart.setContent(htmlContent, "text/html ; charset=UTF-8");

                    // Add the HTML part to the MimeMultipart
                    multipart.addBodyPart(htmlPart);

                    // Set the content of the message to the MimeMultipart
                    message.setContent(multipart);
                    // send message
                    Transport.send(message);
                    System.out.println("message sent successfully");
                } catch (MessagingException e) {
                    throw new RuntimeException(e);
                }
            }
            boolean checkUpdate = dao.CancelBooking(bookingID);
            String note = request.getParameter("note");
            if (checkUpdate) {
                LocalDate ngayHienTai = LocalDate.now();
                LocalTime gioHienTai = LocalTime.now();
                Time gioSQL = Time.valueOf(gioHienTai);
                boolean checkHistory = dao.InsertHistory(bookingID, 4, ngayHienTai, gioSQL, note);
                if (checkHistory) {
                    HttpSession session = request.getSession();
                    session.setAttribute("status", "Pending");
                    response.sendRedirect("staff.jsp");
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
