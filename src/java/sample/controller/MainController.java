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

/**
 *
 * @author MSI AD
 */
@MultipartConfig()
public class MainController extends HttpServlet {

    private static String LOGIN = "login";
    private static String LOGIN_CONTROLLER = "LoginController";
    private static String LOGOUT = "logout";
    private static String LOGOUT_CONTROLLER = "LogoutController";
    private static String REGISTER = "register";
    private static String REGISTER_CONTROLLER = "RegisterController";
    private static String UPDATESERVICE = "updateService";
    private static String UPDATESERVICE_CONTROLLER = "UpdateServiceController";
    private static String ADDSERVICE = "Add";
    private static String ADDSERVICE_CONTROLLER = "AddServiceController";
    private static String UPDATE_DOCTOR_SETTING_PROFILE = "update-doctor-profile-setting";
    private static String UPDATE_DOCTOR_SETTING_PROFILE_CONTROLLER = "UpdateDoctorSettingProfileController";
    private static String CHANGEPASS = "changepass";
    private static String CHANGEPASS_CONTROLLER = "ChangePassController";
    private static String UPDATE_BIRD = "Update";
    private static String UPDATE_BIRD_CONTROLLER = "UpdateBirdController";
    private static String ADD_BIRD = "Add Bird";
    private static String ADD_BIRD_CONTROLLER = "AddBirdController";
    private static String DELETE_BIRD = "Delete";
    private static String DELETE_BIRD_CONTROLLER = "DeleteBirdController";
    private static String BOOKING_SELECTDAY = "Next";
    private static String BOOKING_SELECTDAY_CONTROLLER = "BookingSelectDayController";
    private static String PENDING = "Accept";
    private static String PENDING_CONTROLLER = "PendingController";
    private static String CANCEL = "Decline";
    private static String CANCEL_CONTROLLER = "CancelController";
    private static String CHECKOUTCOMFIRM = "CheckoutConfirm";
    private static String CHECKOUTCOMFIRM_CONTROLLER = "CheckOutController";
    private static String CHECKIN = "Check-in";
    private static String CHECKIN_CONTROLLER = "CheckInController";
    private static String MEDICAL = "Save";
    private static String MEDICAL_CONTROLLER = "MedicalRecordController";
    private static String MEDICAL_DONE = "Done";
    private static String MEDICAL_DONE_CONTROLLER = "MedicalRecordDoneController";
    private static String DONE_MEDICAL = "Done Medical";
    private static String DONE_MEDICAL_CONTROLLER = "MedicalRecordDoneNoServiceController";
    private static String UPDATEPROFILEUSER = "updateProfileUser";
    private static String UPDATEPROFILEUSER_CONTROLLER = "UpdateProfileUserController";
    private static String INSERTFEEDBACK = "feedback";
    private static String INSERTFEEDBACK_CONTROLLER = "InsertFeedbackController";
    private static String UPDATEFEEDBACK = "updateFeedback";
    private static String UPDATEFEEDBACK_CONTROLLER = "UpdateFeedbackController";
    private static String ADD_BLOG = "addblog";
    private static String ADD_BLOG_CONTROLLER = "AddNewBlogController";
    private static String DATEAGAIN = "dateAgain";
    private static String DATEAGAIN_CONTROLLER = "DateAgainController";
    private static String BOOKINGAGAIN = "BookingAgainConfirm";
    private static String BOOKINGAGAINCONTROLLER = "BookingAgainConfirmController";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = null;
        try {
            String actions = request.getParameter("action");
            if (actions.equals(REGISTER)) {
                url = REGISTER_CONTROLLER;
            } else if (actions.equals(LOGIN)) {
                url = LOGIN_CONTROLLER;
            } else if (actions.equals(LOGOUT)) {
                url = LOGOUT_CONTROLLER;
            } else if (actions.equals(UPDATESERVICE)) {
                url = UPDATESERVICE_CONTROLLER;
            } else if (actions.equals(ADDSERVICE)) {
                url = ADDSERVICE_CONTROLLER;
            } else if (actions.equals(UPDATE_DOCTOR_SETTING_PROFILE)) {
                url = UPDATE_DOCTOR_SETTING_PROFILE_CONTROLLER;
            } else if (actions.equals(CHANGEPASS)) {
                url = CHANGEPASS_CONTROLLER;
            } else if (actions.equals(UPDATE_BIRD)) {
                url = UPDATE_BIRD_CONTROLLER;
            } else if (actions.equals(ADD_BIRD)) {
                url = ADD_BIRD_CONTROLLER;
            } else if (actions.equals(DELETE_BIRD)) {
                url = DELETE_BIRD_CONTROLLER;
            } else if (actions.equals(BOOKING_SELECTDAY)) {
                url = BOOKING_SELECTDAY_CONTROLLER;
            } else if (actions.equals("Accept")) {
                url = PENDING_CONTROLLER;
            } else if (actions.equals(CANCEL)) {
                url = CANCEL_CONTROLLER;
            } else if (actions.equals(CHECKIN)) {
                url = CHECKIN_CONTROLLER;
            } else if (actions.equals(CHECKOUTCOMFIRM)) {
                url = CHECKOUTCOMFIRM_CONTROLLER;
            } else if (actions.equals(UPDATEPROFILEUSER)) {
                url = UPDATEPROFILEUSER_CONTROLLER;
            } else if (actions.equals(MEDICAL)) {
                url = MEDICAL_CONTROLLER;
            } else if (actions.equals(INSERTFEEDBACK)) {
                url = INSERTFEEDBACK_CONTROLLER;
            } else if (actions.equals(UPDATEFEEDBACK)) {
                url = UPDATEFEEDBACK_CONTROLLER;
            } else if (actions.equals(ADD_BLOG)) {
                url = ADD_BLOG_CONTROLLER;
            } else if (actions.equals(DATEAGAIN)) {
                url = DATEAGAIN_CONTROLLER;
            } else if (actions.equals(BOOKINGAGAIN)) {
                url = BOOKINGAGAINCONTROLLER;
            } else if (actions.equals(MEDICAL_DONE)) {
                url = MEDICAL_DONE_CONTROLLER;
            } else if (actions.equals(DONE_MEDICAL)) {
                url = DONE_MEDICAL_CONTROLLER;
            } else {
                url = "error-404.jsp";
            }
        } catch (Exception e) {
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
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
