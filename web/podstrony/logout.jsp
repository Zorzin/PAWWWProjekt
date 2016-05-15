<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.BufferedWriter"%>
<%@page import="java.io.FileWriter"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.Date"%>
<%@page import="servlet.DBconnection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page errorPage="errorpage" %>

<%
    System.out.println("Logout");
    /* dodanie do bazy informacji o koncu sesji*/
    try {
        Connection con = DBconnection.getMySQLConnection("danelogowania");
        Statement stmt = con.createStatement();

        ResultSet rs = stmt.executeQuery("select id from aktywnosc");
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
                + "koniec sesji" + "','" + data + "')";

        st.executeUpdate(sql);

        /* zapis do pliku aktywnosci */
        Statement st1 = con.createStatement();
        String user = session.getAttribute("user").toString();
        ResultSet rs1 = st1.executeQuery(
                "select id, user, nazwa, data from aktywnosc where user= '"
        + user +"'");
        String path = "D:\\log\\"
                + user + ".txt";

        try (FileWriter fw = new FileWriter(path, true);
                BufferedWriter bw = new BufferedWriter(fw);
                PrintWriter outl = new PrintWriter(bw)) {
            while (rs1.next()) {
                String date = rs1.getString("data");
                String nazwa = rs1.getString("nazwa");

                outl.println(date + ": " + nazwa);
            }
        } catch (IOException e) {
            //exception handling left as an exercise for the reader
        }

        String sql1 = "delete from aktywnosc where user = '"
                + session.getAttribute("user").toString() + "'";
        Statement st2 = con.createStatement();
        st2.executeUpdate(sql1);

    } catch (Exception e) {
    }

    /*wylogowanie*/
    ServletContext sc = this.getServletContext();
    sc.removeAttribute("user");
    session.setAttribute("user", null);
    session.invalidate();
    response.sendRedirect("/Projekt/glowna");
%>
