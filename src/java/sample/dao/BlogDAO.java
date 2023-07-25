/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import sample.dto.BlogDTO;
import sample.utils.Utils;

/**
 *
 * @author MSI AD
 */
public class BlogDAO {

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public List<BlogDTO> getListBlog() {
        List<BlogDTO> list = new ArrayList<>();
        try {
            String query = "SELECT blog_id, title,detail,date_post,image,status,user_name,author,c.categories_blog_name FROM tbl_Blog x, tbl_Category_Blog c WHERE x.categories_blog_id = c.categories_blog_id";
            conn = new Utils().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                BlogDTO b = new BlogDTO(
                        rs.getString(1),
                        rs.getNString(2),
                        rs.getNString(3),
                        rs.getDate(4),
                        rs.getString(5),
                        rs.getBoolean(6),
                        rs.getString(7),
                        rs.getString(8),
                        rs.getString(9));
                list.add(b);
            }
        } catch (Exception e) {
        }
        return list;
    }

    public List<BlogDTO> getListBlogHome() {
        List<BlogDTO> list = new ArrayList<>();
        try {
            String query = "SELECT blog_id, title,detail,date_post,image,status,user_name,author,c.categories_blog_name FROM tbl_Blog x, tbl_Category_Blog c WHERE x.categories_blog_id = c.categories_blog_id AND status = 1";
            conn = new Utils().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                BlogDTO b = new BlogDTO(
                        rs.getString(1),
                        rs.getNString(2),
                        rs.getNString(3),
                        rs.getDate(4),
                        rs.getString(5),
                        rs.getBoolean(6),
                        rs.getString(7),
                        rs.getString(8),
                        rs.getString(9));
                list.add(b);
            }
        } catch (Exception e) {
        }
        return list;
    }

    public List<BlogDTO> getListBlogByID(String id) {
        List<BlogDTO> list = new ArrayList<>();
        try {
            String query = "SELECT blog_id, title,detail,date_post,image,status,user_name,author,c.categories_blog_name FROM tbl_Blog x, tbl_Category_Blog c WHERE x.categories_blog_id = c.categories_blog_id AND x.blog_id = ?";
            conn = new Utils().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, id);
            rs = ps.executeQuery();
            while (rs.next()) {
                BlogDTO b = new BlogDTO(
                        rs.getString(1),
                        rs.getNString(2),
                        rs.getNString(3),
                        rs.getDate(4),
                        rs.getString(5),
                        rs.getBoolean(6),
                        rs.getString(7),
                        rs.getString(8),
                        rs.getString(9));
                list.add(b);
            }
        } catch (Exception e) {
        }
        return list;
    }

    public void setStatusByBlogID(String blog_id, int status) {
        String query = "UPDATE tbl_Blog SET status = ? WHERE blog_id = ?";
        try {
            conn = new Utils().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, status);
            ps.setString(2, blog_id);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }

    public List<BlogDTO> getListCategoriesBlog() {
        List<BlogDTO> list = new ArrayList<>();
        String query = "SELECT DISTINCT c.categories_blog_name FROM tbl_Blog b JOIN tbl_Category_Blog c ON b.categories_blog_id = c.categories_blog_id ";
        try {
            conn = new Utils().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                String categoryName = rs.getString("categories_blog_name");
                BlogDTO blogDTO = new BlogDTO();
                blogDTO.setCategories_blog_name(categoryName);
                list.add(blogDTO);
            }
        } catch (Exception e) {
        }
        return list;
    }

    public String generateUniqueBlogId() {
        int maxID = 0;
        String result = "";
        try {
            conn = Utils.getConnection();
            if (conn != null) {
                ps = conn.prepareStatement("SELECT TOP 1 blog_id\n"
                        + "FROM tbl_blog\n"
                        + "ORDER BY blog_id DESC");
                rs = ps.executeQuery();
                if (rs.next()) {
                    String max = rs.getString("blog_id").trim();
                    maxID = Integer.parseInt(max.substring(2)) + 1;
                    result = "BL" + String.format("%03d", maxID);
                } else {
                    result = "BL001";
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Handle the exception
        } finally {
            // Close the resources (conn, ps, rs) properly
        }
        return result;
    }

    public boolean isDuplicateBlogId(String blogID) {
        String query = "SELECT * FROM tbl_blog WHERE blog_id = ?";
        try {
            conn = new Utils().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, blogID);
            rs = ps.executeQuery();
            if (rs.next()) {
                return false;
            }
        } catch (Exception e) {
        }
        return true;
    }

    public void addNewBlog(String blogId, String title, String detail, String image, String user_name, String author, int category_id) {
        String query = "INSERT INTO tbl_Blog VALUES(?,?,?,GETDATE(),?,1,?,?,?)";
        try {
            conn = new Utils().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, blogId);
            ps.setString(2, title);
            ps.setString(3, detail);
            ps.setString(4, image);
            ps.setString(5, user_name);
            ps.setString(6, author);
            ps.setInt(7, category_id);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }

    public List getList() {
        List cate = new ArrayList();
        String query = "SELECT categories_blog_name FROM tbl_Category_Blog";
        try {
            conn = new Utils().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                cate.add(rs.getString("categories_blog_name"));
            }
        } catch (Exception e) {
        }
        return cate;
    }

    public int getCategoryId(String name) {
        String query = "SELECT categories_blog_id FROM tbl_Category_Blog WHERE categories_blog_name = ?";
        try {
            conn = new Utils().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, name);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("categories_blog_id");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public static void main(String[] args) {
        BlogDAO dao = new BlogDAO();
        System.out.println(dao.getCategoryId("Health"));
    }
}
