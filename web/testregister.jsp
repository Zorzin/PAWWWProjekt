<%@page import="servlet.DBconnection"%>
<%@ page import ="java.sql.*" %>
<%@ page import ="javax.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    Integer id = 0;
    String login = request.getParameter("login");
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    try {
        Connection con = DBconnection.getMySQLConnection("danelogowania");
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery("select id from user");

        while (rs.next()) {
            if (id < rs.getInt("id")) {
                id = rs.getInt("id");
            }
        }
        id = id + 1;

        Statement st = con.createStatement();
        String sql = "insert into user(id,login,password,email) VALUES ("
                + id + ",'" + login + "','" + password + "','" + email + "')";

        int i = st.executeUpdate(sql);

        if (i > 0) {
            response.sendRedirect("/Projekt");
        } else {
            response.sendRedirect("/Projekt/rejestracja");
        }

    } catch (Exception e) {
        e.printStackTrace();
    }
%>
