<%@page import="servlet.DBconnection"%>
<%@ page import ="java.sql.*" %>
<%@ page import ="javax.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String username = request.getParameter("user");
    String password = request.getParameter("password");

    try {
        Connection connection = DBconnection.getMySQLConnection("danelogowania");
        Statement stmt = connection.createStatement();
        ResultSet rs = stmt.executeQuery(
                "select login, password from user where login='"
                + username + "' and password = '" + password + "'");
        Boolean exists = false;
        if (rs.next()) {
            session = request.getSession();
            session.setAttribute("user", username);
            ServletContext sc = this.getServletContext();
            sc.setAttribute("user", username);
            exists = true;
        }
        if (exists == false) {
            response.sendRedirect("/Projekt/login");
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
                response.sendRedirect("/Projekt");
            } else {
                String tmp = "/Projekt/" + path;
                response.sendRedirect(tmp);
            }
        }

    } catch (Exception e) {
        e.printStackTrace();
    }
%>

