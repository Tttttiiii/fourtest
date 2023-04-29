package com.four.servlet;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.four.entity.User;
import com.four.model.Model;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.annotation.WebServlet;

@WebServlet("/upload")
public class upload extends HttpServlet {

    public void doPost(HttpServletRequest req, HttpServletResponse res)
            throws IOException {
     req.setCharacterEncoding("utf-8");

        String usersString = req.getParameter("file-value");
        if (!"".equals(usersString)){
            Model model = new Model();
            JSONArray array = JSON.parseArray(usersString);
            for (Object o:array){
                User user = JSON.toJavaObject(JSON.parseObject(o.toString()), User.class);
                int insert = model.insert(user.getId(), user.getName(), user.getPassword());
            }
            try {
                req.getRequestDispatcher("allShow.jsp").forward(req, res);
            } catch (ServletException e) {
                e.printStackTrace();
            }
        }
    }
};
