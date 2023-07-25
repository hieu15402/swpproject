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
import java.sql.Time;
import java.text.ParseException;
import java.util.Date;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import sample.dto.BookingDTO;

import sample.dto.SlotDTO;
import sample.utils.Utils;

/**
 *
 * @author MSI AD
 */
public class BookingDAO {

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public List<String> getWeekDates() {
        List<String> weekDates = new ArrayList<>();

        Calendar calendar = Calendar.getInstance();
        Date currentDate = calendar.getTime();

        // Thiết lập ngày đầu tuần là thứ 2
        calendar.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);

        // Lấy thứ ngày trong tuần cho 7 ngày
        for (int i = 0; i < 7; i++) {
            Date date = calendar.getTime();

            // Định dạng ngày tháng
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd");
            String formattedDate = dateFormat.format(date);

            // Thêm ngày vào danh sách
            weekDates.add(formattedDate);

            // Tăng ngày lên 1
            calendar.add(Calendar.DAY_OF_WEEK, 1);
        }

        return weekDates;
    }

    public static List<String> getNextWeek() {
        List<String> weekDates = new ArrayList<>();

        Calendar calendar = Calendar.getInstance();
        calendar.add(Calendar.WEEK_OF_YEAR, 1); // Tăng số tuần lên 1 để lấy tuần tiếp theo
        calendar.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY); // Thiết lập ngày đầu tuần là thứ 2

        // Lấy thứ ngày trong tuần cho 7 ngày
        for (int i = 0; i < 7; i++) {
            Date date = calendar.getTime();

            // Định dạng ngày tháng
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd");
            String formattedDate = dateFormat.format(date);

            // Thêm ngày vào danh sách
            weekDates.add(formattedDate);

            // Tăng ngày lên 1
            calendar.add(Calendar.DAY_OF_WEEK, 1);
        }

        return weekDates;
    }

    public String compareDateDoctor(String[] date1, String[] date2) {
        String date = "";
        int year1 = Integer.parseInt(date1[0]);
        int month1 = Integer.parseInt(date1[1]);
        int day1 = Integer.parseInt(date1[2]);
        LocalDate Date1 = LocalDate.of(year1, month1, day1);
        int year2 = Integer.parseInt(date2[0]);
        int month2 = Integer.parseInt(date2[1]);
        int day2 = Integer.parseInt(date2[2]);
        LocalDate Date2 = LocalDate.of(year2, month2, day2);
        if (Date1.isBefore(Date2)) {
            date = "Upcoming";
        } else if (Date1.equals(Date2)) {
            date = "Today";
        }

        return date;
    }

    public int compareDate(String date1, String date2) {
        int year1 = Integer.parseInt(date1.substring(0, 4));
        int month1 = Integer.parseInt(date1.substring(5, 7));
        int day1 = Integer.parseInt(date1.substring(8, 10));

        int year2 = Integer.parseInt(date2.substring(0, 4));
        int month2 = Integer.parseInt(date2.substring(5, 7));
        int day2 = Integer.parseInt(date2.substring(8, 10));

        if (year1 > year2) {
            return 1;
        } else if (year1 < year2) {
            return -1;
        } else {
            if (month1 > month2) {
                return 1;
            } else if (month1 < month2) {
                return -1;
            } else {
                if (day1 > day2) {
                    return 1;
                } else if (day1 < day2) {
                    return -1;
                } else {
                    return 0;
                }
            }
        }
    }

    public List<SlotDTO> getSlot() {
        List<SlotDTO> list = new ArrayList<>();
        try {
            conn = Utils.getConnection();
            ps = conn.prepareStatement("select *\n"
                    + "from tbl_Slot");
            rs = ps.executeQuery();
            while (rs.next()) {
                SlotDTO s = new SlotDTO(rs.getInt(1), rs.getString(2));
                list.add(s);
            }
            return list;
        } catch (Exception e) {
        }
        return null;
    }

    public SlotDTO getSlotByID(int id) {
        SlotDTO s = null;
        try {
            conn = Utils.getConnection();
            ps = conn.prepareStatement("select *\n"
                    + "from tbl_Slot\n"
                    + "where slot_number = ?");
            ps.setInt(1, id);
            rs = ps.executeQuery();
            while (rs.next()) {
                s = new SlotDTO(rs.getInt(1), rs.getString(2));
            }
            return s;
        } catch (Exception e) {
        }
        return null;
    }

    public String[] getTodayString() {
        // Lấy ngày hiện tại
        Date currentDate = new Date();

        // Định dạng ngày tháng
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd");

        // Chuyển đổi ngày thành chuỗi theo định dạng
        String formattedDate = dateFormat.format(currentDate);
        String[] list = formattedDate.split("/");
        // Trả về ngày đã định dạng
        return list;
    }

    public String getToday() {
        // Lấy ngày hiện tại
        Date currentDate = new Date();

        // Định dạng ngày tháng
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd");

        // Chuyển đổi ngày thành chuỗi theo định dạng
        String formattedDate = dateFormat.format(currentDate);

        // Trả về ngày đã định dạng
        return formattedDate;
    }

    public List<BookingDTO> getAllBooking() throws SQLException {
        List<BookingDTO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String query = "SELECT * FROM tbl_Booking ORDER BY ID desc";
        try {
            conn = Utils.getConnection();
            if (conn != null) {
                ps = conn.prepareStatement(query);
                rs = ps.executeQuery();
                while (rs.next()) {
                    list.add(new BookingDTO(rs.getString(2), rs.getString(3), rs.getString(4), rs.getDate(5), rs.getString(6), Integer.parseInt(rs.getString(7)), rs.getString(8), Integer.parseInt(rs.getString(9).trim())));
                }
            }
        } catch (Exception e) {

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

    private static final String BIRD_NAME = "select pb.bird_name\n"
            + "from tbl_Booking b, tbl_Patient_Bird pb\n"
            + "where pb.patient_id = ? and pb.patient_id = b.patient_id";

    public String getBirdname(String patiend_id) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String bird_name = "";
        try {
            conn = Utils.getConnection();
            if (conn != null) {
                ps = conn.prepareStatement(BIRD_NAME);
                ps.setString(1, patiend_id);
                rs = ps.executeQuery();
                if (rs.next()) {
                    bird_name = rs.getString("bird_name");
                }
            }
        } catch (Exception e) {

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
        return bird_name;
    }

    private static final String SLOT_TIME = "select s.time_slot\n"
            + "from tbl_Booking b join  tbl_Slot s\n"
            + "on b.slot_number = s.slot_number and b.booking_id = ? ";

    public String getSlotTime(String booking_id) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String slot_time = "";
        try {
            conn = Utils.getConnection();
            if (conn != null) {
                ps = conn.prepareStatement(SLOT_TIME);
                ps.setString(1, booking_id);
                rs = ps.executeQuery();
                if (rs.next()) {
                    slot_time = rs.getString("time_slot");
                }
            }
        } catch (Exception e) {

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
        return slot_time;
    }

    private static final String BOOKING_STATUS = "select bs.booking_name\n"
            + "from tbl_Booking b, tbl_Booking_Status bs\n"
            + "where bs.booking_status = b.booking_status and b.booking_id = ? ";

    public String getBookingStatus(String booking_id) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String status = "";
        try {
            conn = Utils.getConnection();
            if (conn != null) {
                ps = conn.prepareStatement(BOOKING_STATUS);
                ps.setString(1, booking_id);
                rs = ps.executeQuery();
                if (rs.next()) {
                    status = rs.getString("booking_name");
                }
            }
        } catch (Exception e) {

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
        return status;
    }

    private static final String SERVICE_NAME = "select s.service_name\n"
            + "from tbl_Service s, tbl_Booking b\n"
            + "where s.service_id = b.service_id and b.booking_id = ? ";

    public String getServicename(String booking_id) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String service_name = "";
        try {
            conn = Utils.getConnection();
            if (conn != null) {
                ps = conn.prepareStatement(SERVICE_NAME);

                ps.setString(1, booking_id);
                rs = ps.executeQuery();
                if (rs.next()) {
                    service_name = rs.getString("service_name");
                }
            }
        } catch (Exception e) {

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
        return service_name;
    }

    private static final String ASSIGN_BOOKING = "UPDATE tbl_Booking SET booking_status = ?,username_doctor = ? WHERE booking_id = ?";

    public boolean AssignBooking(String bookingID, String doctor, int booking_status) throws SQLException {

        Connection conn = null;
        PreparedStatement ps = null;
        boolean checkUpdate = false;
        try {
            conn = Utils.getConnection();
            if (conn != null) {
                ps = conn.prepareStatement(ASSIGN_BOOKING);
                ps.setInt(1, booking_status);
                ps.setString(2, doctor);
                ps.setString(3, bookingID);
                checkUpdate = ps.executeUpdate() > 0 ? true : false;
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
        return checkUpdate;
    }
    private static final String CHECKIN_BOOKING = "UPDATE tbl_Booking SET booking_status = ? WHERE booking_id = ?";

    public boolean CheckInBooking(String bookingID, int booking_status) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        boolean checkUpdate = false;
        try {
            conn = Utils.getConnection();
            if (conn != null) {
                ps = conn.prepareStatement(CHECKIN_BOOKING);
                ps.setInt(1, booking_status);
                ps.setString(2, bookingID);
                checkUpdate = ps.executeUpdate() > 0 ? true : false;
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
        return checkUpdate;
    }
    private static final String CANCEL_BOOKING = "UPDATE tbl_Booking SET booking_status = 6 WHERE booking_id = ?";

    public boolean CancelBooking(String bookingID) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        boolean checkUpdate = false;
        try {
            conn = Utils.getConnection();
            if (conn != null) {
                ps = conn.prepareStatement(CANCEL_BOOKING);
                ps.setString(1, bookingID);
                checkUpdate = ps.executeUpdate() > 0 ? true : false;
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
        return checkUpdate;
    }

    private static final String HISTORY_BOOKING = "INSERT INTO tbl_Booking_Status_Details(booking_id,booking_status,date,time,note)" + " VALUES(?,?,?,?,?)";

    public boolean InsertHistory(String bookingID, int booking_status, LocalDate date, Time gio, String note) throws SQLException {

        Connection conn = null;
        PreparedStatement ps = null;
        boolean checkInsert = false;
        try {
            conn = Utils.getConnection();
            if (conn != null) {
                ps = conn.prepareStatement(HISTORY_BOOKING);
                ps.setString(1, bookingID);
                ps.setInt(2, booking_status);
                ps.setObject(3, date);
                ps.setTime(4, gio);
                ps.setString(5, note);
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

    private static final String CUSNAME = "select a.fullname\n"
            + "from tbl_Booking b join tbl_Account a\n"
            + "on ( a.user_name = b.username_customer and b.username_customer = ?)";

    public String customerName(String userName) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String user_name = "";
        try {
            conn = Utils.getConnection();
            if (conn != null) {
                ps = conn.prepareStatement(CUSNAME);

                ps.setString(1, userName);
                rs = ps.executeQuery();
                if (rs.next()) {
                    user_name = rs.getString("fullname");
                }
            }
        } catch (Exception e) {

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
        return user_name;
    }
    private static final String DOCNAME = "select a.fullname\n"
            + "from tbl_Booking b join tbl_Account a\n"
            + "on ( a.user_name = b.username_doctor and b.username_doctor = ?)";

    public String doctorName(String doctorName) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String doc_name = "";
        try {
            conn = Utils.getConnection();
            if (conn != null) {
                ps = conn.prepareStatement(DOCNAME);

                ps.setString(1, doctorName);
                rs = ps.executeQuery();
                if (rs.next()) {
                    doc_name = rs.getString("fullname");
                }
            }
        } catch (Exception e) {

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
        return doc_name;
    }

    public void insertIntoBooking(BookingDTO b) {
        try {
            conn = Utils.getConnection();
            ps = conn.prepareStatement("INSERT INTO tbl_Booking\n"
                    + "values (?, ?, ?, ?, ?, ?, ?, ?)");
            ps.setString(1, b.getBooking_id());
            ps.setString(2, b.getUsername_doctor());
            ps.setString(3, b.getUsername_customer());
            ps.setDate(4, b.getDate());
            ps.setString(5, b.getService_id());
            ps.setInt(6, b.getSlot_number());
            ps.setString(7, b.getPatient_id());
            ps.setInt(8, b.getBooking_status());
            ps.executeUpdate();
        } catch (Exception e) {

        }
    }

    public String getLastedBookingID() {
        String b = "";
        try {
            conn = Utils.getConnection();
            ps = conn.prepareStatement("select top 1 booking_id\n"
                    + "from tbl_Booking\n"
                    + "order by ID desc");
            rs = ps.executeQuery();
            if (rs.next()) {
                b = rs.getString(1);
            }
        } catch (Exception e) {
        }
        return b;
    }

    public void insertIntoBookingDetails(String booking_id, int booking_status, String date, String time) {
        try {
            conn = Utils.getConnection();
            ps = conn.prepareStatement("INSERT INTO tbl_Booking_Status_Details\n"
                    + "values (?, ?, ?, ?, ?)");
            ps.setString(1, booking_id);
            ps.setInt(2, booking_status);
            ps.setString(3, date);
            ps.setString(4, time);
            ps.setString(5, null);

            ps.executeUpdate();
        } catch (Exception e) {

        }
    }

    public Double getServiceFee(String id) {
        Double service = -1.0;
        try {
            conn = Utils.getConnection();
            ps = conn.prepareStatement("SELECT s.fee\n"
                    + "FROM tbl_Booking b\n"
                    + "INNER JOIN tbl_Service s ON s.service_id = b.service_id\n"
                    + "where booking_id = ?");
            ps.setString(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                service = rs.getDouble(1);
            }
        } catch (Exception e) {
        }
        return service;
    }

    public Double getServiceFeeByName(String name) {
        Double service = -1.0;
        try {
            conn = Utils.getConnection();
            ps = conn.prepareStatement("select fee\n"
                    + "from tbl_Service\n"
                    + "where service_name  = ?");
            ps.setString(1, name);
            rs = ps.executeQuery();
            if (rs.next()) {
                service = rs.getDouble(1);
            }
        } catch (Exception e) {
        }
        return service;
    }

    public String getServiceIDByName(String name) {
        String id = null;
        try {
            conn = Utils.getConnection();
            ps = conn.prepareStatement("select service_id\n"
                    + "from tbl_Service\n"
                    + "where service_name = ?");
            ps.setString(1, name);
            rs = ps.executeQuery();
            if (rs.next()) {
                id = rs.getString(1);
            }
        } catch (Exception e) {
        }
        return id;
    }

    public String getFullNameUserByBookingID(String id) {
        String name = null;
        try {
            conn = Utils.getConnection();
            ps = conn.prepareStatement("SELECT a.fullname\n"
                    + "FROM tbl_Booking b\n"
                    + "INNER JOIN tbl_Account a on a.user_name = b.username_customer\n"
                    + "where booking_id = ?");
            ps.setString(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                name = rs.getString(1);
            }
        } catch (Exception e) {
        }
        return name;
    }

    public int CheckBooking(String bookingID) {
        int status = 0;
        try {
            conn = Utils.getConnection();
            if (conn != null) {
                ps = conn.prepareStatement("SELECT booking_status\n"
                        + "FROM tbl_Booking\n"
                        + "WHERE booking_id = ?");
                ps.setString(1, bookingID);
                rs = ps.executeQuery();
                if (rs.next()) {
                    status = rs.getInt("booking_status");
                }
            }
        } catch (Exception e) {

        }
        return status;
    }

    public int countPatient(String doctor_id) {
        int count = 0;
        try {
            conn = Utils.getConnection();
            ps = conn.prepareStatement("select count(*)\n"
                    + "from tbl_Booking\n"
                    + "where username_doctor = ?");
            ps.setString(1, doctor_id);
            rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
        }
        return count;
    }

    public String[][] slotAppointment(String doctor) throws SQLException {
        BookingDAO dao = new BookingDAO();
        String[][] booking = new String[8][5];
        List<BookingDTO> list = dao.getAllBooking();
        List<String> day = dao.getWeekDates();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd");
        int dem = 1;
        for (BookingDTO x : list) {
            String doc = "";
            if (x.getUsername_doctor() == null) {

            } else {
                doc = x.getUsername_doctor().trim();
            }

            if (doc.equalsIgnoreCase(doctor)) {
                for (int i = 0; i < day.size(); i++) {
                    if (dateFormat.format(x.getDate()).equals(day.get(i))) {
                        String bookingID = x.getBooking_id().trim();
                        if (booking[i + 1][x.getSlot_number()] == null) {
                            booking[i + 1][x.getSlot_number()] = bookingID + " ";
                        } else {
                            booking[i + 1][x.getSlot_number()] += bookingID + " ";
                        }

                    }
                }
            }

        }
        return booking;
    }

    public boolean checkValidateSlotBooking(String date, String slotNumber) {
        try {
            conn = Utils.getConnection();
            ps = conn.prepareStatement("SELECT date, slot_number, COUNT(slot_number) AS count \n"
                    + "FROM tbl_Booking \n"
                    + "GROUP BY date, slot_number \n"
                    + "HAVING COUNT(slot_number) >= 5;");
            rs = ps.executeQuery();
            while (rs.next()) {
                LocalDate localDate = LocalDate.parse(date, DateTimeFormatter.ofPattern("yyyy/MM/dd"));
                String d = localDate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
                if (rs.getString(1).equals(d) && rs.getString(2).equals(slotNumber)) {
                    return false;
                }
            }
            return true;
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return false;
    }

    public boolean checkValidateTime(String slot, String date) {
        LocalTime currentTime = LocalTime.now();
        BookingDAO dao = new BookingDAO();
        if (date.equals(dao.getToday())) {
            switch (slot.trim()) {
                case "1": {
                    LocalTime startTime = LocalTime.parse("07:00:00");
                    if (currentTime.isBefore(startTime)) {
                        return true;
                    }
                    break;
                }
                case "2": {
                    LocalTime startTime = LocalTime.parse("09:00:00");
                    if (currentTime.isBefore(startTime)) {
                        return true;
                    }
                    break;
                }
                case "3": {
                    LocalTime startTime = LocalTime.parse("13:00:00");
                    if (currentTime.isBefore(startTime)) {
                        return true;
                    }
                    break;
                }
                case "4": {
                    LocalTime startTime = LocalTime.parse("15:00:00");
                    if (currentTime.isBefore(startTime)) {
                        return true;
                    }
                    break;
                }
                default:
                    break;
            }
        } else {
            return true;
        }

        return false;
    }

    public BookingDTO getBookingByID(String bookingID) {
        String query = "SELECT * FROM tbl_Booking WHERE booking_id = ? AND booking_status = 1";
        try {
            conn = new Utils().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, bookingID);
            rs = ps.executeQuery();
            while (rs.next()) {
                return new BookingDTO(
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getDate(5),
                        rs.getString(6),
                        Integer.parseInt(rs.getString(7)),
                        rs.getString(8),
                        Integer.parseInt(rs.getString(9).trim()));
            }
        } catch (Exception e) {
        }
        return null;
    }
     public BookingDTO getBookingByIDV2(String bookingID) {
        String query = "SELECT * FROM tbl_Booking WHERE booking_id = ?";
        try {
            conn = new Utils().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, bookingID);
            rs = ps.executeQuery();
            while (rs.next()) {
                return new BookingDTO(
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getDate(5),
                        rs.getString(6),
                        Integer.parseInt(rs.getString(7)),
                        rs.getString(8),
                        Integer.parseInt(rs.getString(9).trim()));
            }
        } catch (Exception e) {
        }
        return null;
    }

    public boolean validateSlotBookingAgain(String doctor_user, String date, String slot) {
        try {
            conn = Utils.getConnection();
            ps = conn.prepareStatement("select * from tbl_Booking\n"
                    + "where username_doctor = ? and slot_number = ? and date = ?");
            ps.setString(1, doctor_user);
            ps.setString(2, slot);
            ps.setString(3, date);
            rs = ps.executeQuery();
            if (rs.next()) {
                return false;
            }
        } catch (Exception e) {
        }
        return true;
    }
    
    public boolean checkValidateBookingInSlot(String username, String slot, String date){
        BookingDAO dao = new BookingDAO();
        try {
            List<BookingDTO> list = dao.getAllBooking();

            for (BookingDTO bookingDTO : list) {
                boolean a = bookingDTO.getUsername_customer().trim().equals(username.trim());
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

    public static void main(String[] args) throws ParseException {
        BookingDAO dao = new BookingDAO();
        System.out.println(dao.checkValidateBookingInSlot("minhga1", "1", "2023/07/12"));
    }
}
