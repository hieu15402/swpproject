/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.dao;

import java.sql.Connection;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.time.Instant;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import sample.dto.FeedbackDTO;
import sample.utils.Utils;

public class FeedbackDAO {

    Connection conn = null;
    PreparedStatement ptm = null;
    ResultSet rs = null;

    public boolean InsertFeedback(FeedbackDTO fb) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = Utils.getConnection();
            if (conn != null) {
                Date myDate = Date.from(Instant.now());
                SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
                String formattedDate = formatter.format(myDate);

                ptm = conn.prepareStatement("INSERT INTO tbl_Feedback(service_id, user_name, rating_star, feedback_content,date,record_id)\n"
                        + "VALUES (?, ?, ?, ?,?,?);");

                ptm.setString(1, fb.getService_id());
                ptm.setString(2, fb.getUser_name());
                ptm.setInt(3, fb.getRating_star());
                ptm.setString(4, fb.getFeedback_content());
                ptm.setString(5, formattedDate);
                ptm.setString(6, fb.getRecord_id());
                ptm.executeUpdate();
            }

        } catch (ClassNotFoundException | SQLException e) {
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
        return check;
    }

    public FeedbackDTO getFeedback(String medical_record) throws SQLException {
        FeedbackDTO fb = new FeedbackDTO();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = Utils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement("select *\n"
                        + "from tbl_Feedback\n"
                        + "where record_id = ?");
                ptm.setString(1, medical_record.trim());
                rs = ptm.executeQuery();
                if (rs.next()) {
                    String ser_id = rs.getString("service_id");
                    String us_name = rs.getString("user_name");
                    int star = rs.getInt("rating_star");
                    String fb_content = rs.getString("feedback_content");
                    String record_id = rs.getString("record_id");
                    fb = new FeedbackDTO(ser_id, us_name, star, fb_content, null, record_id);
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
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
        return fb;
    }

    public boolean UpdateFeedback(FeedbackDTO fb) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = Utils.getConnection();
            Date myDate = Date.from(Instant.now());
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
            String formattedDate = formatter.format(myDate);
            if (conn != null) {
                ptm = conn.prepareStatement("UPDATE tbl_Feedback\n"
                        + "SET rating_star = ?, feedback_content = ?, date =?\n"
                        + "WHERE record_id = ?;");
                ptm.setInt(1, fb.getRating_star());
                ptm.setString(2, fb.getFeedback_content());
                ptm.setString(3, formattedDate);
                ptm.setString(4, fb.getRecord_id());
                ptm.executeUpdate();
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
        return check;
    }

    public List<FeedbackDTO> getAllFeedback() {
        List<FeedbackDTO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = Utils.getConnection();
            if (conn != null) {
                ps = conn.prepareStatement("SELECT * FROM tbl_Feedback");
                rs = ps.executeQuery();
                while (rs.next()) {
                    list.add(new FeedbackDTO(rs.getString(2), rs.getString(3), rs.getInt(4), rs.getString(5), rs.getDate(6), ""));
                }
            }
        } catch (Exception e) {

        }
        return list;
    }

    public List<FeedbackDTO> getAllFeedbackDoctor(String doctor) {
        List<FeedbackDTO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = Utils.getConnection();
            if (conn != null) {
                ps = conn.prepareStatement("select f.service_id,f.user_name as customer, f.feedback_content, f.rating_star,  f.date,   doc.username_doctor\n"
                        + "from tbl_Feedback f join (select record_id, date_again, total_fee, phone, note, m.patient_id, m.booking_id, username_doctor, username_customer, date,service_id\n"
                        + "							from tbl_Medical_Record m join tbl_Booking b on m.booking_id = b.booking_id) as doc on f.record_id = doc.record_id\n"
                        + "							where doc.username_doctor = ? ");
                ps.setString(1, doctor);
                rs = ps.executeQuery();
                while (rs.next()) {
                    list.add(new FeedbackDTO(rs.getString("service_id"),
                            rs.getString("customer"),
                            rs.getInt("rating_star"),
                            rs.getString("feedback_content"),
                            rs.getDate("date"), ""));
                }
            }
        } catch (Exception e) {

        }
        return list;
    }

    public String nameSer(String id) {
        String name = "";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = Utils.getConnection();
            if (conn != null) {
                ps = conn.prepareStatement("select s.service_name\n"
                        + "from tbl_Feedback f join tbl_Service s on s.service_id = f.service_id and f.service_id = ?");
                ps.setString(1, id);
                rs = ps.executeQuery();
                if (rs.next()) {
                    name = rs.getString(1);
                }
            }
        } catch (Exception e) {

        }
        return name;
    }

    public List<FeedbackDTO> getFeedBackByServices(String id) {
        List<FeedbackDTO> list = new ArrayList<>();
        String query = "SELECT service_id, user_name, rating_star,feedback_content, date, record_id FROM tbl_Feedback WHERE service_id = ?";
        try {
            conn = new Utils().getConnection();
            ptm = conn.prepareStatement(query);
            ptm.setString(1, id);
            rs = ptm.executeQuery();
            while (rs.next()) {
                FeedbackDTO feed = new FeedbackDTO(
                        rs.getString(1),
                        rs.getString(2),
                        rs.getInt(3),
                        rs.getString(4),
                        rs.getDate(5),
                        rs.getString(6));
                list.add(feed);
            }
        } catch (Exception e) {
        }
        return list;
    }

    public float getAverageRatingByServiceId(String id) {
        String query = "SELECT AVG(CAST(rating_star AS DECIMAL(10,1))) AS average_rating\n"
                + "FROM tbl_Feedback WHERE service_id = ?";
        try {
            conn = new Utils().getConnection();
            ptm = conn.prepareStatement(query);
            ptm.setString(1, id);
            rs = ptm.executeQuery();
            if (rs.next()) {
                return rs.getFloat("average_rating");
            }
        } catch (Exception e) {
        }
        return 0;
    }

    public int getCountRowRatingByServiceId(String id) {
        String query = " SELECT COUNT(*) as ROWS FROM tbl_Feedback WHERE service_id = ?";
        try {
            conn = new Utils().getConnection();
            ptm = conn.prepareStatement(query);
            ptm.setString(1, id);
            rs = ptm.executeQuery();
            if (rs.next()) {
                return rs.getInt(("ROWS"));
            }
        } catch (Exception e) {
        }
        return 0;
    }

    public int getVerySatisfied() {
        String query = "SELECT COUNT(*) as count FROM tbl_Feedback WHERE rating_star = 5";
        try {
            conn = new Utils().getConnection();
            ptm = conn.prepareStatement(query);
            rs = ptm.executeQuery();
            if (rs.next()) {
                return rs.getInt("count");
            }
        } catch (Exception e) {
        }
        return 0;
    }

    public int getSatisfied() {
        String query = "SELECT COUNT(*) as count FROM tbl_Feedback WHERE rating_star <= 4 AND rating_star >= 3";
        try {
            conn = new Utils().getConnection();
            ptm = conn.prepareStatement(query);
            rs = ptm.executeQuery();
            if (rs.next()) {
                return rs.getInt("count");
            }
        } catch (Exception e) {
        }
        return 0;
    }

    public int getUnSatisfied() {
        String query = "SELECT COUNT(*) as count FROM tbl_Feedback WHERE rating_star <= 2";
        try {
            conn = new Utils().getConnection();
            ptm = conn.prepareStatement(query);
            rs = ptm.executeQuery();
            if (rs.next()) {
                return rs.getInt("count");
            }
        } catch (Exception e) {
        }
        return 0;
    }

    public static void main(String[] args) {
        FeedbackDAO dao = new FeedbackDAO();
        int A = dao.getVerySatisfied();
        int B = dao.getSatisfied();
        int C = dao.getUnSatisfied();

        double total = A + B + C;
        double percentageAHaiLong = (A / total) * 100;
        double percentageBHaiLong = (B / total) * 100;

        int roundedPercentageAHaiLong = (int) Math.round(percentageAHaiLong);
        int roundedPercentageBHaiLong = (int) Math.round(percentageBHaiLong);

        System.out.println(roundedPercentageAHaiLong + "%");
        System.out.println(roundedPercentageBHaiLong + "%");

    }

}
