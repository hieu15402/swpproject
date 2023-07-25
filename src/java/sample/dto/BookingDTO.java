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
public class BookingDTO {

    private String booking_id;
    private String username_doctor;
    private String username_customer;
    private Date date;
    private String service_id;
    private int slot_number;
    private String patient_id;
    private int booking_status;

    public BookingDTO() {
    }

    public BookingDTO(String booking_id, String username_doctor, String username_customer, Date date, String service_id, int slot_number, String patient_id, int booking_status) {
        this.booking_id = booking_id;
        this.username_doctor = username_doctor;
        this.username_customer = username_customer;
        this.date = date;
        this.service_id = service_id;
        this.slot_number = slot_number;
        this.patient_id = patient_id;
        this.booking_status = booking_status;
    }

    public String getBooking_id() {
        return booking_id;
    }

    public void setBooking_id(String booking_id) {
        this.booking_id = booking_id;
    }

    public String getUsername_doctor() {
        return username_doctor;
    }

    public void setUsername_doctor(String username_doctor) {
        this.username_doctor = username_doctor;
    }

    public String getUsername_customer() {
        return username_customer;
    }

    public void setUsername_customer(String username_customer) {
        this.username_customer = username_customer;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getService_id() {
        return service_id;
    }

    public void setService_id(String service_id) {
        this.service_id = service_id;
    }

    public int getSlot_number() {
        return slot_number;
    }

    public void setSlot_number(int slot_number) {
        this.slot_number = slot_number;
    }

    public String getPatient_id() {
        return patient_id;
    }

    public void setPatient_id(String patient_id) {
        this.patient_id = patient_id;
    }

    public int getBooking_status() {
        return booking_status;
    }

    public void setBooking_status(int booking_status) {
        this.booking_status = booking_status;
    }

    @Override
    public String toString() {
        return "BookingDTO{" + "booking_id=" + booking_id + ", username_doctor=" + username_doctor + ", username_customer=" + username_customer + ", date=" + date + ", service_id=" + service_id + ", slot_number=" + slot_number + ", patient_id=" + patient_id + ", booking_status=" + booking_status + '}';
    }

   
    
}
