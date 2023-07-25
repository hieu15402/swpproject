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
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import sample.dto.AppointmentDTO;
import sample.dto.BookingDTO;
import sample.dto.UserDTO;
import sample.utils.Utils;

/**
 *
 * @author MSI AD
 */
public class UserDAO {

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public List<UserDTO> get3PopularDoctor() {
        List<UserDTO> list = new ArrayList<>();
        int count = 0;
        try {
            conn = Utils.getConnection();
            ps = conn.prepareStatement("WITH doctor_counts AS (\n"
                    + "    SELECT b.username_doctor, COUNT(b.username_doctor) AS count\n"
                    + "    FROM tbl_Medical_Record md\n"
                    + "    INNER JOIN tbl_Booking b ON md.booking_id = b.booking_id\n"
                    + "    GROUP BY b.username_doctor\n"
                    + ")\n"
                    + "SELECT a.*,c.count\n"
                    + "FROM tbl_Account a\n"
                    + "INNER JOIN doctor_counts c ON a.user_name = c.username_doctor\n"
                    + "ORDER BY c.count DESC");
            rs = ps.executeQuery();
            while (rs.next()) {
                if (count > 2) {
                    break;
                }
                list.add(new UserDTO(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getDate(5), rs.getString(6), rs.getString(7), rs.getString(8), rs.getString(9), true, rs.getString(11)));
                count++;
            }
            return list;
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return null;
    }

    public int getCount(String username) {
        int i = 0;
        try {
            conn = Utils.getConnection();
            ps = conn.prepareStatement("with doctor_count as  (SELECT b.username_doctor, COUNT(b.username_doctor) AS count\n"
                    + "    FROM tbl_Medical_Record md\n"
                    + "    INNER JOIN tbl_Booking b ON md.booking_id = b.booking_id\n"
                    + "    GROUP BY b.username_doctor)\n"
                    + "select c.count\n"
                    + "from doctor_count c\n"
                    + "where c.username_doctor = ?");
            ps.setString(1, username);
            rs = ps.executeQuery();
            if (rs.next()) {
                i = rs.getInt(1);
            }
        } catch (Exception e) {
        }
        return i;
    }

    public List<UserDTO> get3RecentCustomer() {
        List<UserDTO> list = new ArrayList<>();
        List<UserDTO> list1 = new ArrayList<>();
        int count = 0;
        try {
            conn = Utils.getConnection();
            ps = conn.prepareStatement("with customer as(select pb.user_name,md.ID\n"
                    + "from tbl_Medical_Record md inner join tbl_Patient_Bird pb\n"
                    + "	 on md.patient_id = pb.patient_id\n"
                    + ")\n"
                    + "select a.*\n"
                    + "from tbl_Account a inner join customer c on a.user_name = c.user_name\n"
                    + "order by c.ID desc");
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new UserDTO(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getDate(5), rs.getString(6), rs.getString(7), rs.getString(8), rs.getString(9), true, rs.getString(11)));
            }
            for (UserDTO u : list) {
                boolean a = true;
                for (UserDTO u1 : list1) {
                    if (u1.getUsername().equals(u.getUsername())) {
                        a = false;
                        break;
                    }
                }
                if (a == true) {
                    list1.add(u);
                }
            }
            return list1;
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return null;
    }

    public List<UserDTO> getListCustomer() {
        List<UserDTO> list = new ArrayList<>();
        try {
            String query = "SELECT * FROM tbl_Account WHERE role_id = 4";
            conn = new Utils().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();

            while (rs.next()) {
                UserDTO user = new UserDTO(
                        rs.getString(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getDate(5),
                        rs.getString(6),
                        rs.getString(7),
                        rs.getString(8),
                        rs.getString(9),
                        rs.getBoolean(10),
                        rs.getString(11));

                list.add(user);
            }
        } catch (Exception e) {
        }
        return list;
    }

    public void signUpAccount(String username, String fullName, String email, String gender, Date dob, String phone, String password) {
        String query = "INSERT INTO tbl_Account VALUES(?,?,?,?,?,?,?,NULL,'assets/img/user_image_default.png',1,4)";

        try {
            conn = new Utils().getConnection();
            ps = conn.prepareCall(query);
            ps.setString(1, username);
            ps.setString(2, password);
            ps.setString(3, email);
            ps.setString(4, phone);
            ps.setDate(5, dob);
            ps.setString(6, new String(fullName.getBytes("UTF-8"), "UTF-8"));
            ps.setString(7, gender);
            ps.executeUpdate();

        } catch (Exception e) {
        }
    }

    public UserDTO checkExistAccount(String username) {
        String query = "SELECT * FROM tbl_Account WHERE user_name = ?";
        try {
            conn = new Utils().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, username);
            rs = ps.executeQuery();
            while (rs.next()) {
                return new UserDTO(
                        rs.getString(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getDate(5),
                        rs.getString(6),
                        rs.getString(7),
                        rs.getString(8),
                        rs.getString(9),
                        rs.getBoolean(10),
                        rs.getString(11));
            }
        } catch (Exception e) {
        }
        return null;
    }

    public UserDTO checkExistEmail(String email) {
        String query = "SELECT * FROM tbl_Account WHERE email = ?";
        try {
            conn = new Utils().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, email);
            rs = ps.executeQuery();
            while (rs.next()) {
                return new UserDTO(
                        rs.getString(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getDate(5),
                        rs.getString(6),
                        rs.getString(7),
                        rs.getString(8),
                        rs.getString(9),
                        rs.getBoolean(10),
                        rs.getString(11));
            }
        } catch (Exception e) {
        }
        return null;
    }

    public UserDTO checkExistPhone(String phone) {
        String query = "SELECT * FROM tbl_Account WHERE phone = ?";
        try {
            conn = new Utils().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, phone);
            rs = ps.executeQuery();
            while (rs.next()) {
                return new UserDTO(
                        rs.getString(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getDate(5),
                        rs.getString(6),
                        rs.getString(7),
                        rs.getString(8),
                        rs.getString(9),
                        rs.getBoolean(10),
                        rs.getString(11));
            }
        } catch (Exception e) {

        }
        return null;
    }

    public List<String> getDateAndPaidForCustomerList(String name) {
        List<String> list = new ArrayList<>();
        try {
            conn = Utils.getConnection();
            ps = conn.prepareStatement("with customer as(select md.booking_id,pb.user_name,md.ID,md.total_fee\n"
                    + "from tbl_Medical_Record md inner join tbl_Patient_Bird pb\n"
                    + "	 on md.patient_id = pb.patient_id\n"
                    + "where pb.user_name = ?)\n"
                    + "select b.date, c.total_fee\n"
                    + "from tbl_Booking b inner join customer c on b.booking_id = c.booking_id\n"
                    + "order by c.ID desc");
            ps.setString(1, name);
            rs = ps.executeQuery();
            if (rs.next()) {
                list.add(rs.getString(1));
                list.add(rs.getString(2));
            }
            return list;
        } catch (Exception e) {
        }
        return null;
    }

    public UserDTO Login(String username, String password) {
        String query = "SELECT * FROM tbl_Account WHERE user_name = ? AND password = ? AND status = 1";
        try {
            conn = new Utils().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, username);
            ps.setString(2, password);
            rs = ps.executeQuery();
            while (rs.next()) {
                return new UserDTO(
                        rs.getString(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getDate(5),
                        rs.getNString(6),
                        rs.getString(7),
                        rs.getString(8),
                        rs.getString(9),
                        rs.getBoolean(10),
                        rs.getString(11));
            }

        } catch (Exception e) {
        }
        return null;
    }

    private static final String LOGIN_GOOGLE = "SELECT * FROM tbl_Account WHERE email = ?";

    public UserDTO checkLogin(String email) throws SQLException {
        UserDTO user = null;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = Utils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(LOGIN_GOOGLE);
                ptm.setString(1, email);
                rs = ptm.executeQuery();
                if (rs.next()) {
                    String email_ = rs.getString("email");
                    user = new UserDTO(rs.getString(1),
                            rs.getString(2),
                            rs.getString(3),
                            rs.getString(4),
                            rs.getDate(5),
                            rs.getNString(6),
                            rs.getString(7),
                            rs.getString(8),
                            rs.getString(9),
                            rs.getBoolean(10),
                            rs.getString(11));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
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
        return user;

    }
    private static final String querryDoctor = "select *\n"
            + "from tbl_Account\n"
            + "where role_id = 3;";

    public List<UserDTO> doctorList() throws SQLException {
        List<UserDTO> ls = new ArrayList<>();
        UserDTO doctor;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = Utils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(querryDoctor);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    String user_name = rs.getString("user_name");
                    String email = rs.getString("email");
                    String speciality = rs.getString("bio");
                    String phone = rs.getString("phone");
                    String gender = rs.getString("gender");
                    Date dateofbird = rs.getDate("date_of_birth");
                    String fullname = rs.getString("fullname");
                    String image = rs.getString("image");
                    String roleId = rs.getString("role_id");
                    if (image == null) {
                        image = "assets/img/doctors/blank-profile-picture.png";
                    }
                    boolean status = rs.getBoolean("status");
                    doctor = new UserDTO(user_name, null, email, phone, dateofbird, fullname, gender, speciality, image, status, roleId);
                    ls.add(doctor);
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
        return ls;
    }

    public String getRoleNameByUsername(String username) {
        String query = "SELECT TOP 1 r.rolename \n"
                + "FROM tbl_Account ac, tbl_Role r \n"
                + "WHERE ac.role_id = r.role_id \n"
                + "AND ac.role_id = (SELECT role_id FROM tbl_Account WHERE user_name = ?)";
        try {
            conn = new Utils().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, username);
            rs = ps.executeQuery();
            rs.next();
            return rs.getString(1);
        } catch (Exception e) {
        }
        return null;
    }

    public String getRoleIdByUsername(String username) {
        String query = "SELECT role_id FROM tbl_Account WHERE user_name = ?";
        try {
            conn = new Utils().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, username);
            rs = ps.executeQuery();
            rs.next();
            return rs.getString(1);
        } catch (Exception e) {
        }
        return null;
    }

    public UserDTO viewCustomerByPatientID(String id) {
        UserDTO u = null;
        try {
            conn = Utils.getConnection();
            ps = conn.prepareStatement("select a.*\n"
                    + "from tbl_Patient_Bird pb inner join tbl_Account a on pb.user_name = a.user_name\n"
                    + "where pb.patient_id = ?");
            ps.setString(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                u = new UserDTO(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getDate(5), rs.getString(6), rs.getString(7), rs.getString(8), rs.getString(9), true, rs.getString(11));
            }
            return u;
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return null;
    }

    public UserDTO getDoctorByID(String id) {
        UserDTO a = null;
        try {
            conn = Utils.getConnection();
            ps = conn.prepareStatement("select *\n"
                    + "from tbl_Account\n"
                    + "where USER_NAME = ?");
            ps.setString(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                a = new UserDTO(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getDate(5), rs.getString(6), rs.getString(7), rs.getString(8), rs.getString(9), true, rs.getString(11));
            }
            return a;
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return null;
    }

    public void UpdateDoctorProfile(String username, String fullname, String phone, String gender, String dob, String bio, String img) {
        try {
            conn = Utils.getConnection();
            ps = conn.prepareStatement("UPDATE tbl_Account\n"
                    + "SET fullname = ?, phone = ?, gender = ? , date_of_birth = ?, bio = ?, image = ? \n"
                    + "where USER_NAME = ?");
            ps.setString(1, fullname);
            ps.setString(2, phone);
            ps.setString(3, gender);
            ps.setString(4, dob);
            ps.setString(5, bio);
            ps.setString(6, img);
            ps.setString(7, username);
            ps.executeUpdate();

        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }

    public void UpdateDoctorProfile(String username, String fullname, String phone, String gender, String dob, String bio) {
        try {
            conn = Utils.getConnection();
            ps = conn.prepareStatement("UPDATE tbl_Account\n"
                    + "SET fullname = ?, phone = ?, gender = ? , date_of_birth = ?, bio = ?\n"
                    + "where USER_NAME = ?");
            ps.setString(1, fullname);
            ps.setString(2, phone);
            ps.setString(3, gender);
            ps.setString(4, dob);
            ps.setString(5, bio);
            ps.setString(6, username);
            ps.executeUpdate();

        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }

    public void changePasswordByUsername(String username, String password) {
        String query = "UPDATE tbl_Account SET password = ? WHERE user_name = ? AND status = 1";
        try {
            conn = new Utils().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, password);
            ps.setString(2, username);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }

    public void setStatusByName(String username, int status) {
        String query = "UPDATE tbl_Account SET status = ? WHERE user_name = ?";
        try {
            conn = new Utils().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, status);
            ps.setString(2, username);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }

    public List<UserDTO> listStaffAndManager() {
        List<UserDTO> list = new ArrayList<>();
        String query = "SELECT *\n"
                + "FROM tbl_Account\n"
                + "WHERE role_id IN (2, 5)\n"
                + "ORDER BY CASE role_id\n"
                + "    WHEN 5 THEN 0 \n"
                + "    WHEN 2 THEN 1  -- Staf\n"
                + "    ELSE 2        \n"
                + "END";
        try {
            conn = new Utils().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();

            while (rs.next()) {
                UserDTO user = new UserDTO(rs.getString(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getDate(5),
                        rs.getNString(6),
                        rs.getString(7),
                        rs.getString(8),
                        rs.getString(9),
                        rs.getBoolean(10),
                        rs.getString(11));
                list.add(user);
            }
        } catch (Exception e) {
        }
        return list;
    }

    public UserDTO getUser(String user_name) throws SQLException {
        UserDTO us = new UserDTO();
        try {
            conn = new Utils().getConnection();
            ps = conn.prepareStatement("select email, phone, date_of_birth, fullname, gender, image\n"
                    + "from tbl_Account\n"
                    + "where user_name = ?");
            ps.setString(1, user_name);
            rs = ps.executeQuery();

            while (rs.next()) {
                String email = rs.getString("email");
                String phone = rs.getString("phone");
                Date date = rs.getDate("date_of_birth");
                String fullname = rs.getString("fullname");
                String gender = rs.getString("gender").trim();
                String urlimg = rs.getString("image");
                us = new UserDTO(user_name, email, phone, date, fullname, gender, urlimg);
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

        return us;
    }

    public static int countPatients(String doctorUsername) {
        Connection cn = null;
        int count = 0;
        try {
            cn = Utils.getConnection();
            String sql = "SELECT username_doctor, COUNT(patient_id) AS count FROM tbl_Booking WHERE username_doctor = ? "
                    + "GROUP BY username_doctor";
            PreparedStatement stm = cn.prepareStatement(sql);
            stm.setString(1, doctorUsername);
            ResultSet rs = stm.executeQuery();

            if (rs.next()) {
                return count = rs.getInt("count");
            }
        } catch (Exception e) {

        }
        return 0; // Trả về 0 nếu không có kết quả
    }

    public static int countTodayPatients(String doctorUsername) {
        Connection cn = null;
        int count = 0;
        try {
            cn = Utils.getConnection();
            LocalDate today = LocalDate.now();
            java.sql.Date todayDate = java.sql.Date.valueOf(today);
            String sql = "SELECT COUNT(booking_date) AS count FROM tbl_Booking WHERE username_doctor = ? "
                    + "AND booking_date = ?";
            PreparedStatement stm = cn.prepareStatement(sql);
            stm.setString(1, doctorUsername);
            stm.setDate(2, todayDate);
            ResultSet rs = stm.executeQuery();

            if (rs.next()) {
                count = rs.getInt("count"); // Gán giá trị của trường "count" vào biến count
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Đảm bảo đóng kết nối và các tài nguyên liên quan
            if (cn != null) {
                try {
                    cn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        return count;
    }

    public static int countAppoinments(String doctorUsername) {
        Connection cn = null;
        int count = 0;
        try {
            cn = Utils.getConnection();
            String sql = "SELECT username_doctor, COUNT(booking_id) AS count FROM tbl_Booking WHERE username_doctor = ? "
                    + "GROUP BY username_doctor";
            PreparedStatement stm = cn.prepareStatement(sql);
            stm.setString(1, doctorUsername);
            ResultSet rs = stm.executeQuery();

            if (rs.next()) {
                return count = rs.getInt("count");
            }
        } catch (Exception e) {

        }
        return 0; // Trả về 0 nếu không có kết quả
    }

    public void getBookingInformation(String doctorUsername) {
        Connection cn = null;
        try {
            cn = Utils.getConnection();
            String sql = "SELECT * FROM tbl_booking";
            PreparedStatement stm = cn.prepareStatement(sql);
            ResultSet rs = stm.executeQuery(sql);

        } catch (Exception e) {

        }
    }

    public List<AppointmentDTO> TodayAppt(String doctorUsername) {
        List<AppointmentDTO> list2 = new ArrayList<>();
        Connection cn = null;

        try {
            cn = Utils.getConnection();
            LocalDate today = LocalDate.now();
            java.sql.Date todayDate = java.sql.Date.valueOf(today);
            String sql = "SELECT a.image, a.fullname, b.booking_date, s.service_name, sl.time_slot "
                    + "FROM tbl_Booking b "
                    + "JOIN tbl_Account a ON b.username_customer = a.user_name "
                    + "JOIN tbl_Service s ON b.service_id = s.service_id "
                    + "JOIN tbl_Slot sl ON b.slot_number = sl.slot_number "
                    + "WHERE b.username_doctor = ? AND b.booking_date = ?";

            PreparedStatement stm = cn.prepareStatement(sql);
            stm.setString(1, doctorUsername);
            stm.setDate(2, todayDate);
            ResultSet rs = stm.executeQuery();

            while (rs.next()) {
                String user_customer = rs.getString("fullname");
                String date = rs.getString("booking_date");
                String service = rs.getString("service_name");
                String time = rs.getString("time_slot");
                String image_cus = rs.getString("image");
                list2.add(new AppointmentDTO("", "", "", user_customer, null, time, "", 0, "", image_cus, service, date));

            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Đảm bảo đóng kết nối và các tài nguyên liên quan
            if (cn != null) {
                try {
                    cn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        return list2;
    }

    public List<AppointmentDTO> NextDayAppt(String doctorUsername) {
        List<AppointmentDTO> list1 = new ArrayList<>();
        Connection cn = null;

        try {
            cn = Utils.getConnection();
            LocalDate tomorrow = LocalDate.now();
            java.sql.Date tomorrowDate = java.sql.Date.valueOf(tomorrow);
            String sql = "SELECT a.image, a.fullname, b.booking_date, s.service_name, sl.time_slot "
                    + "FROM tbl_Booking b "
                    + "JOIN tbl_Account a ON b.username_customer = a.user_name "
                    + "JOIN tbl_Service s ON b.service_id = s.service_id "
                    + "JOIN tbl_Slot sl ON b.slot_number = sl.slot_number "
                    + "WHERE b.username_doctor = ? AND b.booking_date > ? \n"
                    + "ORDER by b.booking_date";

            PreparedStatement stm = cn.prepareStatement(sql);
            stm.setString(1, doctorUsername);
            stm.setDate(2, tomorrowDate);
            ResultSet rs = stm.executeQuery();

            while (rs.next()) {
                String user_customer = rs.getString("fullname");
                String date = rs.getString("booking_date");
                String service = rs.getString("service_name");
                String time = rs.getString("time_slot");
                String image_cus = rs.getString("image");
                list1.add(new AppointmentDTO("", "", "", user_customer, null, time, "", 0, "", image_cus, service, date));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Đảm bảo đóng kết nối và các tài nguyên liên quan
            if (cn != null) {
                try {
                    cn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        return list1;
    }

    public List<UserDTO> getListDoctor() {
        List<UserDTO> list = new ArrayList<>();
        String query = "SELECT * FROM tbl_Account WHERE role_id = '3'";
        try {
            conn = new Utils().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                UserDTO doc = new UserDTO(rs.getString(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getDate(5),
                        rs.getNString(6),
                        rs.getString(7),
                        rs.getString(8),
                        rs.getString(9),
                        rs.getBoolean(10),
                        rs.getString(11));
                list.add(doc);
            }

        } catch (Exception e) {
        }
        return list;
    }

    public void UpdateUserProfile(UserDTO us) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = Utils.getConnection();
            ps = conn.prepareStatement("update tbl_Account\n"
                    + "set email = ?, phone = ?, date_of_birth = ?, fullname = ?, gender = ?, image = ?\n"
                    + "where user_name = ?");
            ps.setString(1, us.getEmail());
            ps.setString(2, us.getPhone());
            ps.setString(3, us.getDate());
            ps.setString(4, us.getFullname());
            ps.setString(5, us.getGender());
            ps.setString(6, us.getImage());
            ps.setString(7, us.getUsername());
            ps.executeUpdate();

        } catch (ClassNotFoundException | SQLException e) {
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
    }

    public void changePasswordByEmail(String password, String email) {
        String query = "UPDATE tbl_Account SET password = ? WHERE email = ? AND status = 1";
        try {
            conn = new Utils().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, password);
            ps.setString(2, email);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }

    public boolean checkValidateBookingDoctor(String doctor_username, String slot, String date) {
        BookingDAO dao = new BookingDAO();
        try {
            List<BookingDTO> list = dao.getAllBooking();

            for (BookingDTO bookingDTO : list) {
                boolean a = bookingDTO.getUsername_doctor().trim().equals(doctor_username.trim());
                boolean b = bookingDTO.getSlot_number() == Integer.parseInt(slot);
                LocalDate localDate = LocalDate.parse(date, DateTimeFormatter.ofPattern("yyyy/MM/dd"));
                String d = localDate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
                boolean c = bookingDTO.getDate().toString().trim().equals(d.trim());
                boolean e = (bookingDTO.getBooking_status() != 6 && bookingDTO.getBooking_status() != 5);
                if (a && b && c && e) {
                    return false;
                }
            }
        } catch (Exception e) {

        }
        return true;
    }

    public String checkPassDuplicate(String email) {
        String password = "";
        String query = "SELECT  password FROM tbl_Account WHERE email = ? AND status = 1";
        try {
            conn = new Utils().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, email);
            rs = ps.executeQuery();
            while (rs.next()) {
                password = rs.getString("password");
            }
        } catch (Exception e) {
        }
        return password;
    }

    public String getEmailByUsername(String user_name) {
        String email = "";
        String query = "SELECT email FROM tbl_Account WHERE user_name = ? AND status = 1";
        try {
            conn = new Utils().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, user_name);
            rs = ps.executeQuery();
            while (rs.next()) {
                email = rs.getString("email");
            }
        } catch (Exception e) {
        }
        return email;
    }

    public String getPhoneByUsername(String user_name) {
        String name = "";
        String query = "SELECT phone FROM tbl_Account WHERE user_name = ? AND status = 1";
        try {
            conn = new Utils().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, user_name);
            rs = ps.executeQuery();
            while (rs.next()) {
                name = rs.getString("phone");
            }
        } catch (Exception e) {
        }
        return name;
    }

    public String getFullNameByUsername(String user_name) {
        String name = "";
        String query = "SELECT fullname FROM tbl_Account WHERE user_name = ? AND status = 1";
        try {
            conn = new Utils().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, user_name);
            rs = ps.executeQuery();
            while (rs.next()) {
                name = rs.getString("fullname");
            }
        } catch (Exception e) {
        }
        return name;
    }

    public static void main(String[] args) {
        UserDAO dao = new UserDAO();
        System.out.println(dao.checkValidateBookingDoctor("minhga1", "1", "2023/07/12"));
    }
}
