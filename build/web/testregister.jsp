<%@page import="servlet.DBconnection"%>
<%@ page import ="java.sql.*" %>
<%@ page import ="javax.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    Integer id = 0;
    String nazwa = request.getParameter("nazwa");
    String adres = request.getParameter("adres");
    String miasto = request.getParameter("miasto");
    ServletContext sc = this.getServletContext();
    if (nazwa.equals("") || adres.equals("") || miasto.equals("")) {
        sc.setAttribute("register", "error");
        response.sendRedirect("/Projekt/rejestracja");
    } else {
        try {
            Connection con = DBconnection.getMySQLConnection("sklepydb");
            Statement stmt = con.createStatement();

            ResultSet rs = stmt.executeQuery("select id from sklep");

            while (rs.next()) {
                if (id < rs.getInt("id")) {
                    id = rs.getInt("id");
                }
            }
            id = id + 1;

            Statement st = con.createStatement();
            String sql = "insert into sklep(id,nazwa,adres,miasto) VALUES ("
                    + id + ",'" + nazwa + "','" + adres + "','" + miasto + "')";

            int i = st.executeUpdate(sql);

            if (i > 0) {
                response.sendRedirect("/Projekt");
            } else {
                response.sendRedirect("/Projekt/rejestracja");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>
