/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.controller;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonPrimitive;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import sample.dao.FeedbackDAO;
import sample.dao.ServiceDAO;

/**
 *
 * @author Minh
 */
public class get5ServicesUsedMost extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        FeedbackDAO dao = new FeedbackDAO();
        int A = dao.getVerySatisfied();
        int B = dao.getSatisfied();
        int C = dao.getUnSatisfied();

        double total = A + B + C;
        double percentageAHaiLong = (A / total) * 100;
        double percentageBHaiLong = (B / total) * 100;
        double percentageCHaiLong = (C / total) * 100;

        int roundedPercentageAHaiLong = (int) Math.round(percentageAHaiLong);
        int roundedPercentageBHaiLong = (int) Math.round(percentageBHaiLong);
        int roundedPercentageCHaiLong = (int) Math.round(percentageCHaiLong);
        // Tạo một đối tượng JSON để chứa danh sách tên
        JsonObject jsonObject = new JsonObject();

        JsonElement verySatisfiedElement = new JsonPrimitive(roundedPercentageAHaiLong);
        JsonElement satisfiedElement = new JsonPrimitive(roundedPercentageBHaiLong);
        JsonElement unSatisfiedElement = new JsonPrimitive(roundedPercentageCHaiLong);

        jsonObject.add("VerySatisfied", verySatisfiedElement);
        jsonObject.add("Satisfied", satisfiedElement);
        jsonObject.add("Unatisfied", unSatisfiedElement);
        // Thiết lập các thông số cho response
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // Ghi dữ liệu JSON vào response
        PrintWriter out = response.getWriter();
        out.print(jsonObject.toString());
        out.flush();
    }

}
