/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import java.sql.SQLException;

import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import sample.dto.AppointmentDTO;
import sample.utils.Utils;

/**
 *
 * @author MSI AD
 */
public class AppointmentDAO {

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    private static final String APPOINTMENT_LIST_DASHBOARD = "SELECT TOP 5 b.username_customer, b.username_doctor, b.date, bs.booking_name, s.service_name, sl.time_slot \n"
            + "FROM tbl_Booking b, tbl_Booking_Status bs, tbl_Booking_Status_Details bsd, tbl_Service s, tbl_Slot sl \n"
            + "WHERE b.booking_id = bsd.booking_id AND bs.booking_status = bsd.booking_status AND b.slot_number = sl.slot_number \n"
            + "				AND b.service_id = s.service_id and bs.booking_status = '5' \n"
            + "ORDER BY b.date DESC";
    private static final String IMAGE_DOCTOR = "select  a.image\n"
            + "from tbl_Account a join tbl_Booking b on a.user_name = b.username_doctor and b.username_doctor = ?";
    private static final String IMAGE_CUS = "select  a.image\n"
            + "from tbl_Account a join tbl_Booking b on a.user_name = b.username_customer and b.username_customer = ?";

    public List<AppointmentDTO> get_list_appointment() throws SQLException {
        List<AppointmentDTO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = Utils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(APPOINTMENT_LIST_DASHBOARD);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    String user_customer = rs.getString("username_customer");
                    String user_doctor = rs.getString("username_doctor");
                    String date = rs.getString("date");
                    String status = rs.getString("booking_name");
                    String service = rs.getString("service_name");
                    String time = rs.getString("time_slot");
                    list.add(new AppointmentDTO("", user_doctor, "", user_customer, null, time, status, 0, "", "", service, date));
                }
            }
        } catch (Exception e) {

        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return list;
    }

    public List<AppointmentDTO> getAppointment() throws SQLException {
        AppointmentDAO dao = new AppointmentDAO();
        List<AppointmentDTO> list = dao.getAppointmentNotReady();
        for (AppointmentDTO a : list) {
            a.setStatus(dao.getBookingStatus(a.getBookingID()));
        }
        return list;
    }

    private List<AppointmentDTO> getAppointmentNotReady() throws SQLException {
        List<AppointmentDTO> list = new ArrayList<>();
        try {
            conn = Utils.getConnection();
            ps = conn.prepareStatement("SELECT a.name_doc, a.bio, a.name_cus, a.date, a.time_slot, b.fee, a.booking_id, a.img_doc, a.img_cus\n"
                    + "FROM\n"
                    + "(\n"
                    + "    SELECT a.booking_id, a.name_doc, a.bio, a.name_cus, a.date, b.time_slot, a.img_doc, a.img_cus\n"
                    + "    FROM\n"
                    + "    (\n"
                    + "        SELECT d.booking_id, d.fullname AS name_doc, d.bio, a.fullname AS name_cus, d.date, a.image AS img_cus, d.image AS img_doc\n"
                    + "        FROM tbl_Account a\n"
                    + "        INNER JOIN\n"
                    + "        (\n"
                    + "            SELECT a.fullname, a.bio, b.booking_id, b.username_customer, b.date, a.image\n"
                    + "            FROM tbl_Booking b\n"
                    + "            INNER JOIN tbl_Account a ON b.username_doctor = a.user_name\n"
                    + "        ) AS d ON a.user_name = d.username_customer\n"
                    + "    ) AS a\n"
                    + "    INNER JOIN\n"
                    + "    (\n"
                    + "        SELECT b.booking_id, s.time_slot\n"
                    + "        FROM tbl_Booking b\n"
                    + "        INNER JOIN tbl_Slot s ON b.slot_number = s.slot_number\n"
                    + "    ) AS b ON a.booking_id = b.booking_id\n"
                    + ") AS a\n"
                    + "INNER JOIN\n"
                    + "(\n"
                    + "    SELECT b.booking_id, s.fee\n"
                    + "    FROM tbl_Booking b\n"
                    + "    INNER JOIN tbl_Service s ON b.service_id = s.service_id\n"
                    + ") AS b ON a.booking_id = b.booking_id");
            rs = ps.executeQuery();
            while (rs.next()) {
                AppointmentDTO a = new AppointmentDTO(rs.getString(7), rs.getString(1), rs.getString(2), rs.getString(3), rs.getDate(4), rs.getString(5), "", rs.getDouble(6), rs.getString(8), rs.getString(9), "", "");
                //a.setStatus(getBookingStatus(a.getBookingID()));
                list.add(a);
            }
            return list;
        } catch (Exception e) {
            System.out.println(e.getMessage());
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return null;
    }

    private String getBookingStatus(String id) throws SQLException {
        String stt = null;
        List<String> list = new ArrayList<>();
        try {
            conn = Utils.getConnection();
            ps = conn.prepareStatement("select bsd.booking_id,bs.booking_name\n"
                    + "from tbl_Booking_Status_Details bsd inner join tbl_Booking_Status bs on bsd.booking_status=bs.booking_status\n"
                    + "where booking_id = ?");
            ps.setString(1, id);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(rs.getString(2));
            }
            switch (list.size()) {
                case 3:
                    stt = "Complete";
                    break;
                case 2:
                    stt = "Assign";
                    break;
                case 1:
                    stt = "Pending";
                    break;
                default:
                    break;
            }
            return stt;
        } catch (Exception e) {
            System.out.println(e.getMessage());
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        }

        return null;
    }

    public String get_image_doctor(String doctor) throws SQLException {
        String url = "";
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = Utils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(IMAGE_DOCTOR);
                ptm.setString(1, doctor);
                rs = ptm.executeQuery();
                if (rs.next()) {
                    url = rs.getString("image");
                }
            }
        } catch (Exception e) {

        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return url;
    }

    public String get_image_cus(String doctor) throws SQLException {
        String url = "";
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = Utils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(IMAGE_CUS);
                ptm.setString(1, doctor);
                rs = ptm.executeQuery();
                if (rs.next()) {
                    url = rs.getString("image");
                }
            }
        } catch (Exception e) {

        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return url;
    }

    public String getSpec(String username_doc) throws SQLException {
        String spec = "";
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = Utils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement("select *\n"
                        + "from tbl_Account\n"
                        + "where role_id = '3' and user_name = ?");
                ptm.setString(1, username_doc);
                rs = ptm.executeQuery();
                if (rs.next()) {
                    spec = rs.getString("bio");
                }
            }
        } catch (Exception e) {

        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }

        return spec;
    }

    public double getFeeSer(String ser_id) throws SQLException {
        double fee = 0;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = Utils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement("select *\n"
                        + "from tbl_Service\n"
                        + "where service_id = ?");
                ptm.setString(1, ser_id);
                rs = ptm.executeQuery();
                if (rs.next()) {
                    fee = rs.getDouble("fee");
                }
            }
        } catch (Exception e) {

        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }

        return fee;
    }

    public String getSerNam(String ser_id) throws SQLException {
        String spec = "";
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = Utils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement("select service_name\n"
                        + "from tbl_Service\n"
                        + "where service_id = ?");
                ptm.setString(1, ser_id);
                rs = ptm.executeQuery();
                if (rs.next()) {
                    spec = rs.getString("service_name");
                }
            }
        } catch (Exception e) {

        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }

        return spec;
    }

    public String getStatusName(String status) throws SQLException {
        String stt = "";
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = Utils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement("select *\n"
                        + "from tbl_Booking_Status\n"
                        + "where tbl_Booking_Status.booking_status = ?");
                ptm.setString(1, status);
                rs = ptm.executeQuery();
                if (rs.next()) {
                    stt = rs.getString("booking_name");
                }
            }
        } catch (Exception e) {

        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }

        return stt;
    }

    public Date getDateBooking(String bk_id) throws SQLException {
        Date date = null;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = Utils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement("select date\n"
                        + "from tbl_Booking_Status_Details\n"
                        + "where booking_id = ? and tbl_Booking_Status_Details.booking_status = '1'");
                ptm.setString(1, bk_id);
                rs = ptm.executeQuery();
                if (rs.next()) {
                    date = rs.getDate("date");
                }
            }
        } catch (Exception e) {

        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }

        return date;
    }

    public String getDocName(String username_doc) throws SQLException {
        String docname = "";
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = Utils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement("select fullname\n"
                        + "from tbl_Account\n"
                        + "where user_name = ?");
                ptm.setString(1, username_doc);
                rs = ptm.executeQuery();
                if (rs.next()) {
                    docname = rs.getString("fullname");
                }
            }
        } catch (Exception e) {

        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }

        return docname;
    }

    public List<AppointmentDTO> getAppointmentForUser(String user_name) throws SQLException {
        List<AppointmentDTO> list = new ArrayList<>();
        AppointmentDAO dao = new AppointmentDAO();
        try {
            conn = Utils.getConnection();
            ps = conn.prepareStatement("SELECT booking_id, username_customer, username_doctor, booking_date, service_id, patient_id, booking_status, latest_date, slot_number AS formatted_time\n" +
"                    FROM (\n" +
"              SELECT tbl_Booking.booking_id, username_customer, tbl_Booking.username_doctor, tbl_Booking.date AS booking_date, service_id, patient_id, tbl_Booking.booking_status, tbl_Booking_Status_Details.date AS latest_date, tbl_Booking.slot_number,\n" +
"                            ROW_NUMBER() OVER (PARTITION BY tbl_Booking.booking_id ORDER BY tbl_Booking_Status_Details.date DESC) AS row_num\n" +
"                     FROM tbl_Booking\n" +
"                    JOIN tbl_Booking_Status_Details ON tbl_Booking.booking_id = tbl_Booking_Status_Details.booking_id\n" +
"                    WHERE username_customer = ?)\n" +
"                    AS subquery\n" +
"                    WHERE row_num = 1"
                    + "order by booking_date desc;");
            ps.setString(1, user_name);
            rs = ps.executeQuery();
            while (rs.next()) {
                AppointmentDTO a = new AppointmentDTO(rs.getString(1), rs.getString(3), "", rs.getString(2), rs.getDate(4), "", rs.getString(7), 0, "", "", rs.getString(5), rs.getDate(8));
                String imgCus = dao.get_image_cus(a.getCustomerName());
                String imgDoc = dao.get_image_doctor(a.getDoctorName());
                String spec = dao.getSpec(a.getDoctorName()).trim();
                double fee = dao.getFeeSer(a.getService().trim());
                String ser_name = dao.getSerNam(a.getService());
                Date date = dao.getDateBooking(a.getBookingID());
                String docname = dao.getDocName(a.getDoctorName());
                a = new AppointmentDTO(rs.getString(1), docname.trim(), spec, rs.getString(2), rs.getDate(4), rs.getString(9), rs.getString(7), fee, imgDoc, imgCus, ser_name, date);
                list.add(a);
            }
            return list;
        } catch (Exception e) {
            System.out.println(e.getMessage());
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return null;
    }
    public static void main(String[] args) {
        AppointmentDAO dao = new AppointmentDAO();
        try {
            System.out.println(dao.getDocName("doctor1"));
        } catch (SQLException ex) {
            Logger.getLogger(AppointmentDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
