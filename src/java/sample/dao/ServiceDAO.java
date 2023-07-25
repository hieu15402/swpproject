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
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;
import sample.dto.ServiceDTO;
import sample.utils.Utils;

/**
 *
 * @author MSI AD
 */
public class ServiceDAO {

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public List<ServiceDTO> getListService() throws SQLException {
        List<ServiceDTO> list = new ArrayList<>();
        try {
            String query = "SELECT * FROM tbl_Service WHERE status = 'true' ORDER BY service_id DESC";
            conn = new Utils().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();

            while (rs.next()) {
                ServiceDTO s = new ServiceDTO(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getFloat(6),
                        rs.getString(7),
                        rs.getString(8),
                        rs.getBoolean(9),
                        0);
                list.add(s);
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
    public List<ServiceDTO> getListServiceV2() throws SQLException {
        List<ServiceDTO> list = new ArrayList<>();
        try {
            String query = "SELECT * FROM tbl_Service WHERE status = 'true' and service_name != 'Normal' and service_name != 'Vip' ORDER BY service_id DESC";
            conn = new Utils().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();

            while (rs.next()) {
                ServiceDTO s = new ServiceDTO(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getFloat(6),
                        rs.getString(7),
                        rs.getString(8),
                        rs.getBoolean(9),
                        0);
                list.add(s);
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
    private static final String querryService = "select tbl_Service.service_id, service_name, fee, icon_link, status, avg(rating_star) as avgStar, service_detail, description,image\n"
            + "           from tbl_Service left join tbl_Feedback on tbl_Service.service_id = tbl_Feedback.service_id \n"
            + "           group by tbl_Service.service_id, tbl_Service.service_name, tbl_Service.fee, icon_link, status, service_detail, description, image ";

    public List<ServiceDTO> serviceWithStar() throws SQLException, ClassNotFoundException {
        List<ServiceDTO> listService = new ArrayList<>();
        ServiceDTO ser;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = Utils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(querryService);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    String ser_id = rs.getString("service_id");
                    String ser_name = rs.getString("service_name");
                    float fee = rs.getFloat("fee");
                    String icon_link = rs.getString("icon_link");
                    boolean status = rs.getBoolean("status");
                    float avgStar = rs.getFloat("avgStar");
                    String detail = rs.getString("service_detail");
                    String des = rs.getString("description");
                    String img = rs.getString("image");
                    ser = new ServiceDTO(0, ser_id, ser_name, detail, des, fee, icon_link, img, status, avgStar);
                    listService.add(ser);
                }
            }
        } catch (SQLException e) {

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
        return listService;
    }

    public boolean update(ServiceDTO ser) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        boolean check = false;

        try {
            conn = Utils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement("update tbl_Service\n"
                        + "set service_name = ?, service_detail= ?, description =?, fee = ?, icon_link = ?, image = ?, status = ?\n"
                        + "where service_id = ?");
                ptm.setString(1, ser.getService_name());
                ptm.setString(2, ser.getService_detail());
                ptm.setString(3, ser.getDescription());
                ptm.setFloat(4, ser.getFee());
                ptm.setString(5, ser.getIcon_link());
                ptm.setString(6, ser.getImage());
                ptm.setBoolean(7, ser.isStatus());
                ptm.setString(8, ser.getService_id());
                check = ptm.execute();

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
            return check;
        }
    }

    public boolean updateWithOutIcon(ServiceDTO ser) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        boolean check = false;

        try {
            conn = Utils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement("update tbl_Service\n"
                        + "set service_name = ?, service_detail= ?, description =?, fee = ?,  image = ?, status =?\n"
                        + "where service_id = ?");
                ptm.setString(1, ser.getService_name());
                ptm.setString(2, ser.getService_detail());
                ptm.setString(3, ser.getDescription());
                ptm.setFloat(4, ser.getFee());
                ptm.setString(5, ser.getImage());
                ptm.setBoolean(6, ser.isStatus());
                ptm.setString(7, ser.getService_id());
                check = ptm.execute();

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
            return check;
        }
    }

    public boolean updateWithOutImage(ServiceDTO ser) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        boolean check = false;

        try {
            conn = Utils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement("update tbl_Service\n"
                        + "set service_name = ?, service_detail= ?, description =?, fee = ?, icon_link = ?, status = ?\n"
                        + "where service_id = ?");
                ptm.setString(1, ser.getService_name());
                ptm.setString(2, ser.getService_detail());
                ptm.setString(3, ser.getDescription());
                ptm.setFloat(4, ser.getFee());
                ptm.setString(5, ser.getIcon_link());
                ptm.setBoolean(6, ser.isStatus());
                ptm.setString(7, ser.getService_id());
                check = ptm.execute();

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
            return check;
        }
    }

    public boolean updateWithAnyIconImg(ServiceDTO ser) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        boolean check = false;

        try {
            conn = Utils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement("update tbl_Service\n"
                        + "set service_name = ?, service_detail= ?, description =?, fee = ?, status = ?\n"
                        + "where service_id = ?");
                ptm.setString(1, ser.getService_name());
                ptm.setString(2, ser.getService_detail());
                ptm.setString(3, ser.getDescription());
                ptm.setFloat(4, ser.getFee());
                ptm.setBoolean(5, ser.isStatus());
                ptm.setString(6, ser.getService_id());
                check = ptm.execute();

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
            return check;
        }
    }

    public boolean addService(ServiceDTO ser) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        boolean check = false;

        try {
            conn = Utils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement("insert into tbl_Service(service_id,service_name,service_detail,description,fee,icon_link,image,status)\n"
                        + "values(?,?,?,?,?,?,?,?);");
                ptm.setString(1, ser.getService_id());
                ptm.setString(2, ser.getService_name());
                ptm.setString(3, ser.getService_detail());
                ptm.setString(4, ser.getDescription());
                ptm.setFloat(5, ser.getFee());
                ptm.setString(6, ser.getIcon_link());
                ptm.setString(7, ser.getImage());
                ptm.setBoolean(8, true);
                check = ptm.execute();
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
            return check;
        }
    }

    public String getSerIdNext() {
        int maxID = 0;
        String result = "";
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = Utils.getConnection();
            if (conn != null) {
                ps = conn.prepareStatement("SELECT TOP 1 service_id\n"
                        + "FROM tbl_Service\n"
                        + "ORDER BY ID DESC");
                rs = ps.executeQuery();
                while (rs.next()) {
                    String max = rs.getString("service_id").trim();
                    maxID = Integer.parseInt(max) + 1;
                    result = String.format("%03d", maxID);
                }
            }
        } catch (Exception e) {
        }
        return result;
    }

    public List<String> getTop5Services() {
        List<String> topServices = new ArrayList<>();
        String query = "SELECT TOP 5 s.service_name, COUNT(b.service_id) AS service_count\n"
                + "                FROM tbl_Service s\n"
                + "                JOIN tbl_Booking b ON s.service_id = b.service_id\n"
                + "                JOIN tbl_Medical_Record m ON b.booking_id = m.booking_id\n"
                + "				JOIN tbl_Booking_Status_Details c ON b.booking_id = c.booking_id\n"
                + "				WHERE c.booking_status = 5\n"
                + "                GROUP BY s.service_id, s.service_name\n"
                + "                ORDER BY service_count DESC";
        try {
            conn = new Utils().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                String serviceName = rs.getString("service_name");
                topServices.add(serviceName);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Close resources (rs, ps, conn) here
        }
        return topServices;
    }

    public List<Integer> getTop5ServicesCount() {
        List<Integer> topServices = new ArrayList<>();
        String query = "SELECT TOP 5  COUNT(b.service_id) AS service_count\n"
                + "FROM tbl_Service s\n"
                + "JOIN tbl_Booking b ON s.service_id = b.service_id\n"
                + "JOIN tbl_Medical_Record m ON b.booking_id = m.booking_id\n JOIN tbl_Booking_Status_Details c ON b.booking_id = c.booking_id WHERE c.booking_status = 5"
                + "GROUP BY s.service_id, s.service_name\n"
                + "ORDER BY service_count DESC";

        try {
            conn = new Utils().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                int serviceCount = rs.getInt("service_count");
                topServices.add(serviceCount);
            }
        } catch (Exception e) {
        }
        return topServices;
    }

    public List<Integer> getTotalFeeByMonth(int month) {
        List<Integer> listFee = new ArrayList<>();
        String query = "SELECT MONTH(b.date) AS month, SUM(m.total_fee) AS total\n"
                + "FROM tbl_Medical_Record m\n"
                + "JOIN tbl_Booking_Status_Details b ON m.booking_id = b.booking_id\n"
                + "WHERE YEAR(b.date) = 2023 AND MONTH(b.date) = ?\n"
                + "GROUP BY MONTH(b.date)\n"
                + "ORDER BY MONTH(b.date);";
        try {
            conn = new Utils().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, month);
            rs = ps.executeQuery();
            while (rs.next()) {
                int feeList = rs.getInt("total");
                listFee.add(feeList);
            }
        } catch (Exception e) {
        }
        return listFee;
    }

    public int getTotalFeeByMonthV2(int month) {
        int temp = 0;
        String query = "SELECT MONTH(b.date) AS month, SUM(m.total_fee) AS total\n"
                + "FROM tbl_Medical_Record m\n"
                + "JOIN tbl_Booking_Status_Details b ON m.booking_id = b.booking_id\n"
                + "WHERE YEAR(b.date) = 2023 AND MONTH(b.date) = ?  AND b.booking_status = 5\n"
                + "GROUP BY MONTH(b.date)\n"
                + "ORDER BY MONTH(b.date);";
        try {
            conn = new Utils().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, month);
            rs = ps.executeQuery();
            while (rs.next()) {
                temp = rs.getInt("total");
            }
        } catch (Exception e) {
        }
        return temp;
    }

    public int getTotalRevenue() {
        int temp = 0;
        String query = "SELECT SUM(m.total_fee) AS total FROM tbl_Medical_Record m JOIN tbl_Booking_Status_Details b ON m.booking_id = b.booking_id  WHERE YEAR(b.date) = 2023 AND b.booking_status = 5";
        try {
            conn = new Utils().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            if (rs.next()) {
                temp = rs.getInt("total");
            }
        } catch (Exception e) {
        }
        return temp;
    }

    public List<ServiceDTO> getListTop5() {
        List<ServiceDTO> list = new ArrayList<>();
        String query = "SELECT * FROM tbl_Service WHERE service_id in (SELECT TOP 5  s.service_id \n"
                + "                FROM tbl_Service s\n"
                + "                JOIN tbl_Booking b ON s.service_id = b.service_id\n"
                + "                JOIN tbl_Medical_Record m ON b.booking_id = m.booking_id"
                + "                JOIN tbl_Booking_Status_Details c ON b.booking_id = c.booking_id WHERE c.booking_status = 5\n"
                + "                GROUP BY s.service_id, s.service_name\n"
                + "                ORDER BY COUNT(b.service_id)DESC)";
        try {
            conn = new Utils().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                ServiceDTO s = new ServiceDTO(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getFloat(6),
                        rs.getString(7),
                        rs.getString(8),
                        rs.getBoolean(9),
                        0);
                list.add(s);
            }
        } catch (Exception e) {
        }
        return list;
    }

    public float getRatingPointByServiceId(String serviceID) {
        float rating = 0;
        String query = "SELECT AVG(rating_star) AS avgfloat FROM tbl_Feedback WHERE service_id = ?";
        try {
            conn = new Utils().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, serviceID);
            rs = ps.executeQuery();
            while (rs.next()) {
                rating = rs.getFloat("avgfloat");
            }
        } catch (Exception e) {
        }
        DecimalFormat decimalFormat = new DecimalFormat("#.#");
        String formattedRating = decimalFormat.format(rating);
        rating = Float.parseFloat(formattedRating);
        return rating;
    }

    public String getServiceName(String id) {
        String name = "";
        String query = "SELECT service_name FROM tbl_Service WHERE service_id = ? AND status = 1";
        try {
            conn = new Utils().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                name = rs.getString("service_name");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return name;
    }

    public String getTimeSlot(int id) {
        String name = "";
        String query = "SELECT time_slot FROM tbl_Slot WHERE slot_number = ?";
        try {
            conn = new Utils().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                name = rs.getString("time_slot");
            }
        } catch (Exception e) {
        }
        return name;
    }

    public List<Integer> getTotalFeePerWeek() {
        List<Integer> listFee = new ArrayList<>();
        String query = "DECLARE @CurrentDate DATE;\n"
                + "DECLARE @StartDate DATE;\n"
                + "DECLARE @EndDate DATE;\n"
                + "	\n"
                + "SET @CurrentDate = GETDATE();\n"
                + "SET @StartDate = DATEADD(DAY, 2 - DATEPART(WEEKDAY, @CurrentDate), @CurrentDate);\n"
                + "SET @EndDate = DATEADD(DAY, 8 - DATEPART(WEEKDAY, @CurrentDate), @CurrentDate);\n"
                + "\n"
                + "SELECT \n"
                + "    CASE \n"
                + "        WHEN EXISTS (SELECT 1 FROM tbl_Booking_Status_Details WHERE CONVERT(DATE, date) = CONVERT(DATE, DATEADD(DAY, rn - 1, @StartDate)) AND booking_status = 5) \n"
                + "        THEN (SELECT total_fee FROM tbl_Medical_Record WHERE booking_id in\n"
                + "											(SELECT booking_id FROM tbl_Booking_Status_Details c WHERE CONVERT(DATE, date) = CONVERT(DATE, DATEADD(DAY, rn - 1, @StartDate)) AND booking_status = 5))\n"
                + "        ELSE '' \n"
                + "    END AS total_fee\n"
                + "FROM \n"
                + "    (SELECT ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS rn FROM sys.objects) AS numbers\n"
                + "WHERE \n"
                + "    rn <= DATEDIFF(DAY, @StartDate, @EndDate) + 1\n"
                + "ORDER BY	\n"
                + "    rn;";
        try {
            conn = new Utils().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                int temp = rs.getInt("total_fee");
                listFee.add(temp);
            }
        } catch (Exception e) {
        }
        return listFee;
    }

    public List<Integer> getCountServicePerWeek() {
        List<Integer> listFee = new ArrayList<>();
        String query = "DECLARE @CurrentDate DATE;\n"
                + "DECLARE @StartDate DATE;\n"
                + "DECLARE @EndDate DATE;\n"
                + "	\n"
                + "SET @CurrentDate = GETDATE();\n"
                + "SET @StartDate = DATEADD(DAY, 2 - DATEPART(WEEKDAY, @CurrentDate), @CurrentDate);\n"
                + "SET @EndDate = DATEADD(DAY, 8 - DATEPART(WEEKDAY, @CurrentDate), @CurrentDate);\n"
                + "\n"
                + "SELECT \n"
                + "    CASE \n"
                + "        WHEN EXISTS (SELECT 1 FROM tbl_Booking_Status_Details WHERE CONVERT(DATE, date) = CONVERT(DATE, DATEADD(DAY, rn - 1, @StartDate)) AND booking_status = 5) \n"
                + "        THEN (SELECT COUNT(service_id) FROM tbl_Medical_Record m JOIN tbl_Select_Service s ON m.record_id = s.record_id WHERE m.booking_id in \n"
                + "                (SELECT booking_id FROM tbl_Booking_Status_Details c WHERE CONVERT(DATE, date) = CONVERT(DATE, DATEADD(DAY, rn - 1, @StartDate)) AND booking_status = 5))\n"
                + "        ELSE 0 \n"
                + "    END AS total_fee\n"
                + "FROM \n"
                + "    (SELECT ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS rn FROM sys.objects) AS numbers\n"
                + "WHERE \n"
                + "    rn <= DATEDIFF(DAY, @StartDate, @EndDate) + 1\n"
                + "ORDER BY	\n"
                + "    rn;";
        try {
            conn = new Utils().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                int temp = rs.getInt("total_fee");
                listFee.add(temp);
            }
        } catch (Exception e) {
        }
        return listFee;
    }

    public List<String> getDateByName() {
        List<String> listDate = new ArrayList<>();
        String query = "DECLARE @CurrentDate DATE;\n"
                + "DECLARE @StartDate DATE;\n"
                + "DECLARE @EndDate DATE;\n"
                + "\n"
                + "SET @CurrentDate = GETDATE();\n"
                + "SET @StartDate = DATEADD(DAY, 2 - DATEPART(WEEKDAY, @CurrentDate), @CurrentDate);\n"
                + "SET @EndDate = DATEADD(DAY, 8 - DATEPART(WEEKDAY, @CurrentDate), @CurrentDate);\n"
                + "\n"
                + "SELECT \n"
                + "    CASE \n"
                + "        WHEN DATENAME(WEEKDAY, DATEADD(DAY, rn - 1, @StartDate)) = 'Monday' THEN 'Mon'\n"
                + "        WHEN DATENAME(WEEKDAY, DATEADD(DAY, rn - 1, @StartDate)) = 'Tuesday' THEN 'Tue'\n"
                + "        WHEN DATENAME(WEEKDAY, DATEADD(DAY, rn - 1, @StartDate)) = 'Wednesday' THEN 'Wed'\n"
                + "        WHEN DATENAME(WEEKDAY, DATEADD(DAY, rn - 1, @StartDate)) = 'Thursday' THEN 'Thu'\n"
                + "        WHEN DATENAME(WEEKDAY, DATEADD(DAY, rn - 1, @StartDate)) = 'Friday' THEN 'Fri'\n"
                + "        WHEN DATENAME(WEEKDAY, DATEADD(DAY, rn - 1, @StartDate)) = 'Saturday' THEN 'Sat'\n"
                + "        WHEN DATENAME(WEEKDAY, DATEADD(DAY, rn - 1, @StartDate)) = 'Sunday' THEN 'Sun'\n"
                + "    END + ' ' + FORMAT(CONVERT(DATE, DATEADD(DAY, rn - 1, @StartDate)), 'dd-MM') AS NgayVaTenThu\n"
                + "FROM \n"
                + "    (SELECT ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS rn FROM sys.objects) AS numbers\n"
                + "WHERE \n"
                + "    rn <= DATEDIFF(DAY, @StartDate, @EndDate) + 1\n"
                + "ORDER BY \n"
                + "    rn;";
        try {
            conn = new Utils().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                String temp = rs.getString("NgayVaTenThu");
                listDate.add(temp);
            }
        } catch (Exception e) {
        }
        return listDate;
    }

    public boolean checkTop1Service(String id) {
        String query = "SELECT service_id FROM tbl_Service WHERE service_id in (SELECT TOP 1 s.service_id \n"
                + "                          FROM tbl_Service s\n"
                + "                             JOIN tbl_Booking b ON s.service_id = b.service_id\n"
                + "                          JOIN tbl_Medical_Record m ON b.booking_id = m.booking_id\n"
                + "                         JOIN tbl_Booking_Status_Details c ON b.booking_id = c.booking_id WHERE c.booking_status = 5\n"
                + "                            GROUP BY s.service_id, s.service_name\n"
                + "                            ORDER BY COUNT(b.service_id)DESC)";
        try {
            conn = new Utils().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            if (rs.next()) {
                if (rs.getString("service_id").trim().equalsIgnoreCase(id.trim())) {
                    return true;
                }
                return false;
            }
        } catch (Exception e) {
        }
        return false;
    }
public List<ServiceDTO> getListServiceForBooking() throws SQLException {
        List<ServiceDTO> list = new ArrayList<>();
        try {
            String query = "SELECT * FROM tbl_Service WHERE service_id = '013' or service_id = '012'";
            conn = new Utils().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();

            while (rs.next()) {
                ServiceDTO s = new ServiceDTO(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getFloat(6),
                        rs.getString(7),
                        rs.getString(8),
                        rs.getBoolean(9),
                        0);
                list.add(s);
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
    public static void main(String[] args) {
        ServiceDAO dao = new ServiceDAO();
        System.out.println(dao.checkTop1Service("008"));
    }

}
