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
import java.util.ArrayList;
import java.util.List;
import sample.dto.PatientDTO;
import sample.utils.Utils;

/**
 *
 * @author MSI AD
 */
public class PatientDAO {

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    private static final String INFORMATION_BIRD = "SELECT pb.patient_id,pb.bird_name,pb.species_id , pb.age, pb.gender, pb.image, pb.status\n"
            + "FROM tbl_Account a, tbl_Patient_Bird pb, tbl_Species sp\n"
            + "WHERE a.user_name = pb.user_name and pb.species_id = sp.species_id and pb.user_name = ? and pb.status = 'True'";

    public List<PatientDTO> getBird(String user_name) {
        List<PatientDTO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = Utils.getConnection();
            if (conn != null) {
                ps = conn.prepareStatement(INFORMATION_BIRD);
                ps.setString(1, user_name);
                rs = ps.executeQuery();
                while (rs.next()) {
                    String patient_id = rs.getString("patient_id").trim();
                    String bird_name = rs.getString("bird_name").trim();
                    String species_id = rs.getString("species_id").trim();
                    String age = rs.getString("age").trim();
                    String gender = rs.getString("gender").trim();
                    String image = rs.getString("image");
                    boolean status = Boolean.parseBoolean(rs.getString("status"));
                    PatientDTO bird = new PatientDTO(patient_id, bird_name, species_id, age, gender, image, user_name, status);
                    list.add(bird);
                }
            }
        } catch (Exception e) {

        }
        return list;
    }

    private static final String SPECIES = "select sp.species_name\n"
            + "from tbl_Patient_Bird pb, tbl_Species sp\n"
            + "where pb.species_id = sp.species_id and pb.species_id =?";

    public String getSpecies(String species_id) {
        String species_name = "";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = Utils.getConnection();
            if (conn != null) {
                ps = conn.prepareStatement(SPECIES);
                ps.setString(1, species_id);
                rs = ps.executeQuery();
                if (rs.next()) {
                    species_name = rs.getString(1);
                }
            }
        } catch (Exception e) {

        }
        return species_name;
    }

    public List<PatientDTO> viewPatientListByDoctorID(String id) throws SQLException {
        List<PatientDTO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = Utils.getConnection();
            ps = conn.prepareStatement("select pb.*\n"
                    + "from tbl_Booking b inner join tbl_Patient_Bird pb on b.patient_id = pb.patient_id\n"
                    + "where username_doctor = ?");
            ps.setString(1, id);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new PatientDTO(rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8), rs.getBoolean(9)));
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

    private static final String SPECIES_LIST = "SELECT species_name FROM tbl_Species";

    public ArrayList<String> getListSpecies() throws ClassNotFoundException {
        ArrayList<String> list = new ArrayList();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = Utils.getConnection();
            if (conn != null) {
                ps = conn.prepareStatement(SPECIES_LIST);
                rs = ps.executeQuery();
                while (rs.next()) {
                    String species_name = rs.getString("species_name");
                    list.add(species_name);
                }
            }
        } catch (Exception e) {
        }
        return list;
    }
    private static final String ADD_BIRD = "INSERT INTO tbl_Patient_Bird(patient_id,bird_name,species_id,age,gender,image,user_name,status) " + " VALUES(?,?,?,?,?,?,?,?)";

    public boolean addBird(PatientDTO bird) {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = Utils.getConnection();
            if (conn != null) {
                ps = conn.prepareStatement(ADD_BIRD);
                ps.setString(1, bird.getPatient_id());
                ps.setString(2, bird.getName());
                ps.setString(3, bird.getSpecies_id());
                ps.setString(4, bird.getAge());
                ps.setString(5, bird.getGender());
                ps.setString(6, bird.getImage());
                ps.setString(7, bird.getUser_name());
                ps.setBoolean(8, bird.isStatus());
                check = ps.executeUpdate() > 0 ? true : false;
            }
        } catch (Exception e) {

        }
        return check;
    }
    private static final String SPECIES_LIST_ID = "SELECT species_id FROM tbl_Species WHERE species_name = ?";

    public String getIDSpecies(String species_name) throws ClassNotFoundException {
        String id = "";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = Utils.getConnection();
            if (conn != null) {
                ps = conn.prepareStatement(SPECIES_LIST_ID);
                ps.setString(1, species_name);
                rs = ps.executeQuery();
                while (rs.next()) {
                    id = rs.getString("species_id");
                }
            }
        } catch (Exception e) {
        }
        return id;
    }
    private static final String MAX_ID_BIRD = "SELECT TOP 1 patient_id FROM tbl_Patient_Bird ORDER BY ID DESC";

    public int MaxId() {
        int maxID = 0;
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = Utils.getConnection();
            if (conn != null) {
                ps = conn.prepareStatement(MAX_ID_BIRD);
                rs = ps.executeQuery();
                while (rs.next()) {
                    String max = rs.getString("patient_id").trim();
                    maxID = Integer.parseInt(max);
                }
            }
        } catch (Exception e) {
        }
        return maxID;
    }

    private static final String UPDATE_BIRD = "UPDATE tbl_Patient_Bird SET bird_name = ?,species_id = ? ,age = ?,gender = ?,image=? WHERE patient_id=?";

    public boolean UpdateBird(PatientDTO bird) throws ClassNotFoundException {
        boolean checkUpdate = false;
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = Utils.getConnection();
            if (conn != null) {
                ps = conn.prepareStatement(UPDATE_BIRD);
                ps.setString(1, bird.getName());
                ps.setString(2, bird.getSpecies_id());
                ps.setString(3, bird.getAge());
                ps.setString(4, bird.getGender());
                ps.setString(5, bird.getImage());
                ps.setString(6, bird.getPatient_id());
                checkUpdate = ps.executeUpdate() > 0 ? true : false;
            }

        } catch (Exception e) {

        }
        return checkUpdate;
    }

    private static final String UPDATE_BIRD_NO_IMAGE = "UPDATE tbl_Patient_Bird SET bird_name = ?,species_id = ? ,age = ?,gender = ? WHERE patient_id=?";

    public boolean UpdateBirdNoImage(PatientDTO bird) throws ClassNotFoundException {
        boolean checkUpdate = false;
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = Utils.getConnection();
            if (conn != null) {
                ps = conn.prepareStatement(UPDATE_BIRD_NO_IMAGE);
                ps.setString(1, bird.getName());
                ps.setString(2, bird.getSpecies_id());
                ps.setString(3, bird.getAge());
                ps.setString(4, bird.getGender());
                ps.setString(5, bird.getPatient_id());
                checkUpdate = ps.executeUpdate() > 0 ? true : false;
            }

        } catch (Exception e) {

        }
        return checkUpdate;
    }
    private static final String DELETE_BIRD = "UPDATE tbl_Patient_Bird SET status_bird=? WHERE patient_id=?";

    public boolean DeleteBird(int status, String patient_id) throws ClassNotFoundException {
        boolean checkDelete = false;
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = Utils.getConnection();
            if (conn != null) {
                ps = conn.prepareStatement(DELETE_BIRD);
                ps.setInt(1, status);
                ps.setString(2, patient_id);
                checkDelete = ps.executeUpdate() > 0 ? true : false;
            }

        } catch (Exception e) {

        }
        return checkDelete;
    }

    public List<PatientDTO> getPatientBird(String username) {
        List<PatientDTO> list = new ArrayList<>();
        try {
            conn = Utils.getConnection();
            ps = conn.prepareStatement("SELECT *\n"
                    + "FROM tbl_Patient_Bird\n"
                    + "WHERE user_name = ? and status = 1");
            ps.setString(1, username);
            rs = ps.executeQuery();
            while (rs.next()) {
                PatientDTO p = new PatientDTO(rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8), true);
                list.add(p);
            }
            return list;
        } catch (Exception e) {
        }
        return null;
    }

    public PatientDTO getBirdByID(String bird_id) {
        PatientDTO bird = null;
        try {
            conn = Utils.getConnection();
            ps = conn.prepareStatement("select bird_name, age, gender, species_id\n"
                    + "from tbl_Patient_Bird \n"
                    + "where patient_id = ?");
            ps.setString(1, bird_id);
            rs = ps.executeQuery();
            if (rs.next()) {
                String name = rs.getString("bird_name");
                String age = rs.getString("age");
                String gender = rs.getString("gender");
                String specied_id = rs.getString("species_id");
                bird = new PatientDTO(specied_id, name, specied_id, age, gender, "", "", true);
            }
        } catch (Exception e) {

        }
        return bird;
    }

    public boolean checkValidatePatient(String username, String patientID, String date, String slotNumber) {
        try {
            conn = Utils.getConnection();
            ps = conn.prepareStatement("select *\n"
                    + "from tbl_Booking\n"
                    + "where username_customer = ? and patient_id = ? and date = ? and slot_number = ? and booking_status != 5 and booking_status != 6");
            ps.setString(1, username);
            ps.setString(2, patientID);
            ps.setString(3, date);
            ps.setString(4, slotNumber);
            rs = ps.executeQuery();
            if (rs.next()) {
                return false;
            }
        } catch (Exception e) {
        }
        return true;
    }

    public String getBirdNameByPatientId(String id) {
        String name = "";
        String query = "SELECT bird_name from tbl_Patient_Bird WHERE patient_id = ? AND status = 1";
        try {
            conn = new Utils().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                name = rs.getString("bird_name");
            }
        } catch (Exception e) {
        }
        return name;
    }

    public PatientDTO getOneBird(String patientID) {
        PatientDTO bird = new PatientDTO();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = Utils.getConnection();
            if (conn != null) {
                ps = conn.prepareStatement("select *\n"
                        + "from tbl_Patient_Bird\n"
                        + "where patient_id = ?");
                ps.setString(1, patientID.trim());
                rs = ps.executeQuery();
                while (rs.next()) {
                    String patient_id = rs.getString("patient_id").trim();
                    String bird_name = rs.getString("bird_name").trim();
                    String species_id = rs.getString("species_id").trim();
                    String age = rs.getString("age").trim();
                    String gender = rs.getString("gender").trim();
                    String image = rs.getString("image");
                    boolean status = Boolean.parseBoolean(rs.getString("status"));
                    bird = new PatientDTO(patient_id, bird_name, species_id, age, gender, image, "", status);
                }
            }
        } catch (Exception e) {

        }
        return bird;
    }

    public static void main(String[] args) {
        PatientDAO dao = new PatientDAO();
        System.out.println(dao.checkValidatePatient("minhga1", "11", "2023/07/12", "1"));
    }

}
