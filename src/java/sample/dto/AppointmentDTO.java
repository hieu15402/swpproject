/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.dto;

import java.sql.Date;

/**
 *
 * @author MSI AD
 */
public class AppointmentDTO {

    private String bookingID;
    private String doctorName;
    private String speciality;
    private String customerName;
    private Date date;
    private String time;
    private String status;
    private double fee;
    private String imgDoc;
    private String imgCus;
    private String service;
    private String date_;
    private Date dateBooking;

    public AppointmentDTO() {
    }

    public AppointmentDTO(String bookingID, String doctorName, String speciality, String customerName, Date date, String time, String status, double fee, String imgDoc, String imgCus, String service, String date_) {
        this.bookingID = bookingID;
        this.doctorName = doctorName;
        this.speciality = speciality;
        this.customerName = customerName;
        this.date = date;
        this.time = time;
        this.status = status;
        this.fee = fee;
        this.imgDoc = imgDoc;
        this.imgCus = imgCus;
        this.service = service;
        this.date_ = date_;
    }

    public AppointmentDTO(String bookingID, String doctorName, String speciality, String customerName, Date date, String time, String status, double fee, String imgDoc, String imgCus, String service, Date dateBooking) {
        this.bookingID = bookingID;
        this.doctorName = doctorName;
        this.speciality = speciality;
        this.customerName = customerName;
        this.date = date;
        this.time = time;
        this.status = status;
        this.fee = fee;
        this.imgDoc = imgDoc;
        this.imgCus = imgCus;
        this.service = service;
        this.dateBooking = dateBooking;
    }

    public Date getDateBooking() {
        return dateBooking;
    }

    public void setDateBooking(Date dateBooking) {
        this.dateBooking = dateBooking;
    }

    public String getBookingID() {
        return bookingID;
    }

    public void setBookingID(String bookingID) {
        this.bookingID = bookingID;
    }

    public String getDoctorName() {
        return doctorName;
    }

    public void setDoctorName(String doctorName) {
        this.doctorName = doctorName;
    }

    public String getSpeciality() {
        return speciality;
    }

    public void setSpeciality(String speciality) {
        this.speciality = speciality;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public double getFee() {
        return fee;
    }

    public void setFee(double fee) {
        this.fee = fee;
    }

    public String getImgDoc() {
        return imgDoc;
    }

    public void setImgDoc(String imgDoc) {
        this.imgDoc = imgDoc;
    }

    public String getImgCus() {
        return imgCus;
    }

    public void setImgCus(String imgCus) {
        this.imgCus = imgCus;
    }

    public String getService() {
        return service;
    }

    public void setService(String service) {
        this.service = service;
    }

    public String getDate_() {
        return date_;
    }

    public void setDate_(String date_) {
        this.date_ = date_;
    }

}
