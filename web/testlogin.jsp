<%@page import="servlet.DBconnection"%>
<%@ page import ="java.sql.*" %>
<%@ page import ="javax.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import ="java.util.Date" %>"

<%
    String username = request.getParameter("user");
    String password = request.getParameter("password");

    try {
        Connection connection = DBconnection.getMySQLConnection("danelogowania");
        Statement stmt = connection.createStatement();
        ServletContext sc = this.getServletContext();
        ResultSet rs = stmt.executeQuery(
                "select login, password from user where login='"
                + username + "' and password = '" + password + "'");
        Boolean exists = false;
        if (rs.next()) {
            session = request.getSession();
            session.setAttribute("user", username);
            sc.setAttribute("user", username);
            exists = true;

            try {
                Connection con = DBconnection.getMySQLConnection("danelogowania");

                rs = stmt.executeQuery("select id from aktywnosc");
                int id = 0;
                while (rs.next()) {
                    if (id < rs.getInt("id")) {
                        id = rs.getInt("id");
                    }
                }
                id = id + 1;
                Date currentTime = new Date();
                String data = String.format("%tD %tr", currentTime, currentTime);
                Statement st = con.createStatement();
                String sql = "insert into aktywnosc(id,user,nazwa, data) VALUES ("
                        + id + ",'" + session.getAttribute("user") + "','"
                        + "poczatek sesji" + "','" + data + "')";

                st.executeUpdate(sql);

            } catch (Exception e) {
            }

        }
        if (exists == false) {
            response.sendRedirect("/Projekt/login");
            sc.setAttribute("login", "error");
        } else {
            String path = null;
            Cookie[] cookies = request.getCookies();
            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    if (cookie.getName().equals(username)) {
                        path = cookie.getValue();
                    }
                }
            }
            if (path == null) {
                response.sendRedirect("/Projekt/glowna");
            } else {
                String tmp = "/Projekt" + path;
                response.sendRedirect(tmp);
            }
        }

    } catch (Exception e) {
        e.printStackTrace();
    }
%>

