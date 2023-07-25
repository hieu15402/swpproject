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
public class BlogDTO {

    private String blog_id;
    private String title;
    private String details;
    private Date date_post;
    private String image;
    private boolean status;
    private String user_name;
    private String author;
    private String categories_blog_name;

    public BlogDTO() {
    }

    public BlogDTO(String blog_id, String title, String details, Date date_post, String image, boolean status, String user_name, String author, String categories_blog_name) {
        this.blog_id = blog_id;
        this.title = title;
        this.details = details;
        this.date_post = date_post;
        this.image = image;
        this.status = status;
        this.user_name = user_name;
        this.author = author;
        this.categories_blog_name = categories_blog_name;
        
    }

    public String getBlog_id() {
        return blog_id;
    }

    public void setBlog_id(String blog_id) {
        this.blog_id = blog_id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDetails() {
        return details;
    }

    public void setDetails(String details) {
        this.details = details;
    }

    public Date getDate_post() {
        return date_post;
    }

    public void setDate_post(Date date_post) {
        this.date_post = date_post;
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

    public String getUser_name() {
        return user_name;
    }

    public void setUser_name(String user_name) {
        this.user_name = user_name;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getCategories_blog_name() {
        return categories_blog_name;
    }

    public void setCategories_blog_name(String categories_blog_name) {
        this.categories_blog_name = categories_blog_name;
    }

    @Override
    public String toString() {
        return "BlogDTO{" + "blog_id=" + blog_id + ", title=" + title + ", details=" + details + ", date_post=" + date_post + ", image=" + image + ", status=" + status + ", user_name=" + user_name + ", author=" + author + ", categories_blog_name=" + categories_blog_name + '}';
    }

}
