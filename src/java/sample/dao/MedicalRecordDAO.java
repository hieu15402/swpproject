package sample.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import sample.dto.MedicalRecordDTO;
import sample.utils.Utils;

public class MedicalRecordDAO {

    public String get_image_doctor(String doctor) throws SQLException {
        String url = "";
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = Utils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement("select  a.image\n"
                        + "from tbl_Account a join tbl_Booking b on a.user_name = b.username_doctor and b.username_doctor = ?");
                ptm.setString(1, doctor);
                rs = ptm.executeQuery();
                if (rs.next()) {
                    url = rs.getString("image");
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
        return url;
    }

    public String get_image_patient(String doctor) throws SQLException {
        String url = "";
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = Utils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement("select  a.image\n"
                        + "from tbl_Account a join tbl_Booking b on a.user_name = b.username_customer and b.username_customer = ?");
                ptm.setString(1, doctor);
                rs = ptm.executeQuery();
                if (rs.next()) {
                    url = rs.getString("image");
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

        return fee;
    }

    public List select_Service(String record_id) throws SQLException {
        List ls = new ArrayList();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = Utils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement("select service_id\n"
                        + "from tbl_Select_Service\n"
                        + "where tbl_Select_Service.record_id = ?");
                ptm.setString(1, record_id);
                rs = ptm.executeQuery();
                if (rs.next()) {
                    ls.add(rs.getString(1));
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

        return ls;
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

    public List<MedicalRecordDTO> getMR(String username) throws SQLException {
        List<MedicalRecordDTO> ls = new ArrayList();
        MedicalRecordDTO a = new MedicalRecordDTO();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = Utils.getConnection();
            ptm = conn.prepareStatement("select  tbl_Medical_Record.record_id, tbl_Medical_Record.patient_id,date_again , note, tbl_Booking.username_doctor, tbl_Booking.service_id\n"
                    + "                    from tbl_Medical_Record join tbl_Booking on tbl_Medical_Record.booking_id = tbl_Booking.booking_id\n"
                    + "                   where tbl_Booking.username_customer = ?");
            ptm.setString(1, username);
            rs = ptm.executeQuery();
            while (rs.next()) {
                MedicalRecordDAO dao = new MedicalRecordDAO();
                String patient_id = rs.getString("patient_id").trim();
                Date date_again = rs.getDate("date_again");
                String note = rs.getString("note");

                a = new MedicalRecordDTO(rs.getString("record_id"), date_again, 0, "", note, patient_id, "", rs.getString("service_id"), rs.getString("username_doctor"));
                ls.add(a);

            }
            return ls;
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println(e.getMessage());
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
        return null;
    }

    public List<MedicalRecordDTO> getMRDoctor(String username) throws SQLException {
        List<MedicalRecordDTO> ls = new ArrayList();
        MedicalRecordDTO a = new MedicalRecordDTO();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = Utils.getConnection();
            ptm = conn.prepareStatement("select  tbl_Medical_Record.record_id, tbl_Medical_Record.patient_id,date_again , note, tbl_Booking.username_customer, tbl_Booking.service_id,tbl_Booking.booking_id\n"
                    + "                                    from tbl_Medical_Record join tbl_Booking on tbl_Medical_Record.booking_id = tbl_Booking.booking_id\n"
                    + "                                      where tbl_Booking.username_doctor = ?");
            ptm.setString(1, username);
            rs = ptm.executeQuery();
            while (rs.next()) {
                MedicalRecordDAO dao = new MedicalRecordDAO();
                String patient_id = rs.getString("patient_id").trim();
                Date date_again = rs.getDate("date_again");
                String note = rs.getString("note");

                a = new MedicalRecordDTO(rs.getString("record_id"), date_again, 0, "", note, patient_id, rs.getString("booking_id"), rs.getString("service_id"), rs.getString("username_customer"));
                ls.add(a);

            }
            return ls;
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println(e.getMessage());
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
        return null;
    }

    public MedicalRecordDTO getMRByBookingID(String bookingID) throws SQLException {
        MedicalRecordDTO ls = new MedicalRecordDTO();
        MedicalRecordDTO a = new MedicalRecordDTO();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = Utils.getConnection();
            ptm = conn.prepareStatement("select *\n"
                    + "from tbl_Medical_Record\n"
                    + "where booking_id = ? ");
            ptm.setString(1, bookingID);
            rs = ptm.executeQuery();
            if (rs.next()) {
                ls = new MedicalRecordDTO(rs.getString(2), rs.getDate(3), rs.getDouble(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8), "", "");
            }
            return ls;
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println(e.getMessage());
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
        return null;
    }

    public boolean CheckgetMRByBookingID(String bookingID) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = Utils.getConnection();
            ptm = conn.prepareStatement("select *\n"
                    + "from tbl_Medical_Record\n"
                    + "where booking_id = ? ");
            ptm.setString(1, bookingID);
            rs = ptm.executeQuery();
            if (rs.next()) {
                check = true;
            }

        } catch (ClassNotFoundException | SQLException e) {
            System.out.println(e.getMessage());
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

    private static final String MAX_ID_MR = "select top 1 record_id\n"
            + "from tbl_Medical_Record\n"
            + "order by ID desc";

    public int MaxId() {
        int maxID = 0;
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = Utils.getConnection();
            if (conn != null) {
                ps = conn.prepareStatement(MAX_ID_MR);
                rs = ps.executeQuery();
                while (rs.next()) {
                    String max = rs.getString("record_id").trim();
                    maxID = Integer.parseInt(max);
                }
            }
        } catch (Exception e) {
        }
        return maxID;
    }
    private static final String addMR = "INSERT INTO tbl_Medical_Record(record_id,date_again,total_fee,phone,note,patient_id,booking_id)" + "VALUES(?,?,?,?,?,?,?)";

    public boolean CreateMedical(MedicalRecordDTO mr) throws SQLException {
        boolean checkInsert = false;
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = Utils.getConnection();
            if (conn != null) {
                ps = conn.prepareStatement(addMR);
                ps.setString(1, mr.getRecord_id());
                ps.setDate(2, mr.getDate_again());
                ps.setDouble(3, mr.getTotal_fee());
                ps.setString(4, mr.getPhone());
                ps.setString(5, mr.getNote());
                ps.setString(6, mr.getPatent_id());
                ps.setString(7, mr.getBooking_id());
                checkInsert = ps.executeUpdate() > 0 ? true : false;
            }
        } catch (Exception e) {

        } finally {
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return checkInsert;
    }
    private static final String addSelectService = "INSERT INTO tbl_Select_Service(service_id,fee,record_id,status)" + "VALUES(?,?,?,?)";

    public boolean ServiceInMedical(MedicalRecordDTO mr, boolean status) throws SQLException {
        boolean checkInsert = false;
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = Utils.getConnection();
            if (conn != null) {
                ps = conn.prepareStatement(addSelectService);
                ps.setString(1, mr.getSer_id());
                ps.setDouble(2, mr.getTotal_fee());
                ps.setString(3, mr.getRecord_id());
                ps.setBoolean(4, status);
                checkInsert = ps.executeUpdate() > 0 ? true : false;
            }
        } catch (Exception e) {

        } finally {
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return checkInsert;
    }

    public boolean getStatusService(String record_id, String service_id) throws SQLException {
        boolean checkInsert = false;
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = Utils.getConnection();
            if (conn != null) {
                ps = conn.prepareStatement("SELECT status FROM tbl_Select_Service WHERE service_id =? AND record_id =?");
                ps.setString(1, service_id);
                ps.setString(2, record_id.trim());
                rs = ps.executeQuery();
                if (rs.next()) {
                    checkInsert = rs.getBoolean("status");
                }
            }
        } catch (Exception e) {

        } finally {
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return checkInsert;
    }

    public static void main(String[] args) throws SQLException {
        MedicalRecordDAO dao = new MedicalRecordDAO();
        boolean check = dao.getStatusService("3", "001");
        System.out.println(check);

    }

    public List<String> getListServiceMore(String record_id) throws SQLException {
        List<String> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = Utils.getConnection();
            if (conn != null) {
                ps = conn.prepareStatement("select *\n"
                        + "from tbl_Select_Service\n"
                        + "where record_id =?");
                ps.setString(1, record_id);
                rs = ps.executeQuery();
                while (rs.next()) {
                    list.add(rs.getString("service_id"));
                }

            }
        } catch (ClassNotFoundException | SQLException e) {

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
        return list;

    }

    public boolean UpdateMedical(MedicalRecordDTO mr) throws SQLException {
        boolean checkInsert = false;
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = Utils.getConnection();
            if (conn != null) {
                ps = conn.prepareStatement("UPDATE tbl_Medical_Record\n"
                        + "SET date_again = ?, note = ?\n"
                        + "WHERE record_id =?;");
                ps.setDate(1, mr.getDate_again());
                ps.setString(2, mr.getNote());
                ps.setString(3, mr.getRecord_id());
                checkInsert = ps.executeUpdate() > 0 ? true : false;
            }
        } catch (Exception e) {

        } finally {
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return checkInsert;
    }

    public boolean UpdateSelectService(String record, String ser) throws SQLException {
        boolean checkInsert = false;
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = Utils.getConnection();
            if (conn != null) {
                ps = conn.prepareStatement("update tbl_Select_Service set status = 1 where service_id =? and record_id =? ");
                ps.setString(1, ser.trim());
                ps.setString(2, record);
                checkInsert = ps.executeUpdate() > 0 ? true : false;
            }
        } catch (Exception e) {

        } finally {
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return checkInsert;
    }
}
