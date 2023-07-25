/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.dto;

import java.sql.Date;

import java.text.SimpleDateFormat;

/**
 *
 * @author MSI AD
 */
public class UserDTO {

    private String username;
    private String password;
    private String email;
    private String phone;

    private Date date_of_birth;
    private String fullname;
    private String gender;
    private String bio;
    private String image;
    private boolean status;
    private String role;
    private Date dateDate;
    private String date;

    public UserDTO() {
    }

    public UserDTO(String username, String password, String email, String phone, Date date_of_birth, String fullname, String gender, String bio, String image, boolean status, String role) {

        this.username = username;
        this.password = password;
        this.email = email;
        this.phone = phone;

        this.date_of_birth = date_of_birth;
        this.fullname = fullname;
        this.gender = gender;
        this.bio = bio;
        this.image = image;
        this.status = status;

        this.role = role;
    }

    public UserDTO(String username, String email, String phone, Date date_of_birth, String fullname, String gender, String image) {
        this.username = username;
        this.email = email;
        this.phone = phone;
        this.date_of_birth = date_of_birth;
        this.fullname = fullname;
        this.gender = gender;
        this.image = image;
    }
    
      public UserDTO(String username, String email, String phone, String date, String fullname, String gender, String image) {
        this.username = username;
        this.email = email;
        this.phone = phone;
        this.date = date;
        this.fullname = fullname;
        this.gender = gender;
        this.image = image;
  }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }
      
      

    public Date getDateDate() {
        return dateDate;
    }

    public void setDateDate(Date dateDate) {
        this.dateDate = dateDate;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public Date getDate_of_birth() {
        return date_of_birth;
    }

    public void setDate_of_birth(Date date_of_birth) {
        this.date_of_birth = date_of_birth;

    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getBio() {
        return bio;
    }

    public void setBio(String bio) {
        this.bio = bio;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;

    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    @Override
    public String toString() {
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        return "UserDTO{" + "username=" + username + ", password=" + password + ", email=" + email + ", phone=" + phone + ", date_of_birth=" + sdf.format(date_of_birth) + ", fullname=" + fullname + ", gender=" + gender + ", bio=" + bio + ", image=" + image + ", status=" + status + ", role=" + role + '}';
    }

}
