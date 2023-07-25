/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.controller;

import java.io.IOException;
import java.util.Properties;
import java.util.Random;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Minh
 */
public class forgotPassword extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String email = request.getParameter("email");
        RequestDispatcher dispatcher = null;
        OtpManager otp = new OtpManager();
        int otpvalue = otp.getOtpValue();
        HttpSession mySession = request.getSession();

        if (email != null || !email.equals("")) {
            // sending otp
            Random rand = new Random();
            otpvalue = rand.nextInt(900000) + 100000;

            String to = email;// change accordingly
            // Get the session object
            Properties props = new Properties();
            props.put("mail.smtp.host", "smtp.gmail.com");
            props.put("mail.smtp.socketFactory.port", "465");
            props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.port", "465");
            Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication("thedearbirdclinic@gmail.com", "apcbriouhtfefznu");// Put your email
                    // id and
                    // password here
                }
            });
            // compose message
            try {
                MimeMessage message = new MimeMessage(session);
                message.setFrom(new InternetAddress(email));// change accordingly
                message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
                message.setSubject("THEDEARBIRD password assistance");
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
                        + "                        style=\"width: 150px; height: 150px;\" src=\"https://i.pinimg.com/originals/05/49/a2/0549a2976d1e0f3f2a9b503315013692.png\"></a>\n"
                        + "                <a style=\"float: right; margin-top: 75px; font-size: 20px;\">Password assistance</a>\n"
                        + "            </div>\n"
                        + "            <p style=\"font-size:15px\">To authenticate, please use the following (OTP) below:</p>\n"
                        + "            <h2\n"
                        + "                style=\"background:  #008333;margin: 0 auto;width: max-content;padding: 0 10px;color: #fff;border-radius: 4px;\">\n"
                        + "                " + otpvalue + "\n"
                        + "            </h2>\n"
                        + "            <p style=\"font-size:15px;\">Don't share this OTP with anyone. Our customer service team will never ask you\n"
                        + "                for your password, OTP, credit card, or banking info.</p>\n"
                        + "            <p style=\"font-size:15px;\">We hope to see you again soon.</p>\n"
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
                htmlPart.setContent(htmlContent, "text/html");

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
            request.setAttribute("emailUser", email);
            mySession.setAttribute("status", "success");
            dispatcher = request.getRequestDispatcher("inputOTP.jsp");
            request.setAttribute("message", "OTP is sent to your email id");
            //request.setAttribute("connection", con);
            mySession.setAttribute("otp", otpvalue);
            mySession.setAttribute("email", email);
            dispatcher.forward(request, response);
            //request.setAttribute("status", "success");
        }

    }

}
