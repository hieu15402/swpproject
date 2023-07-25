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
public class FeedbackDTO {

    private String service_id;
    private String user_name;
    private int rating_star;
    private String feedback_content;
    private Date date;
    private String record_id;

    public FeedbackDTO() {
    }

    public FeedbackDTO(String service_id, String user_name, int rating_star, String feedback_content, Date date, String record_id) {
        this.service_id = service_id;
        this.user_name = user_name;
        this.rating_star = rating_star;
        this.feedback_content = feedback_content;
        this.date = date;
        this.record_id = record_id;
    }

    public String getRecord_id() {
        return record_id;
    }

    public void setRecord_id(String record_id) {
        this.record_id = record_id;
    }

    public String getService_id() {
        return service_id;
    }

    public void setService_id(String service_id) {
        this.service_id = service_id;
    }

    public String getUser_name() {
        return user_name;
    }

    public void setUser_name(String user_name) {
        this.user_name = user_name;
    }

    public int getRating_star() {
        return rating_star;
    }

    public void setRating_star(int rating_star) {
        this.rating_star = rating_star;
    }

    public String getFeedback_content() {
        return feedback_content;
    }

    public void setFeedback_content(String feedback_content) {
        this.feedback_content = feedback_content;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    @Override
    public String toString() {
        return "FeedbackDTO{" + "service_id=" + service_id + ", user_name=" + user_name + ", rating_star=" + rating_star + ", feedback_content=" + feedback_content + ", date=" + date + ", record_id=" + record_id + '}';
    }

}
