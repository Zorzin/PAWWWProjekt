<%@page import="klasy.Lista"%>
<%@page import="klasy.Produkty"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="java.io.FileReader"%>
<%@page import="java.util.List"%>
<%@page import="klasy.Listaprodukt"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.io.File"%>
<%@page import="java.io.File"%>
<%@page import="servlet.DBconnection"%>
<%@ page import ="java.sql.*" %>
<%@ page import ="javax.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import ="java.util.Date" %>"
<%@ page errorPage="errorpage" %>
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
                Object o = sc.getAttribute("user");
                String name = o.toString();
                File f = new File("D://log//koszyk-" + name + ".txt");
                if (f.exists()) {
                    JSONParser parser = new JSONParser();
                    

                    try {

                        Object obj = parser.parse(new FileReader(
                                "D://log//koszyk-" + name + ".txt"));

                        JSONObject jsonObject = (JSONObject) obj;
                        List<Listaprodukt> lista = new ArrayList<Listaprodukt>();
                        JSONArray objList = (JSONArray) jsonObject.get("List:");
                        Iterator<JSONObject> iterator = objList.iterator();
                        while(iterator.hasNext())
                        {
                            JSONObject object = iterator.next();
                            String obiekt = object.toString();
                            obiekt=obiekt.replace("}","");
                            String[] spl = obiekt.split(",");
                            String idString = spl[1];
                            String ids = idString.substring(idString.indexOf(':')+1);
                            String iloscString = spl[0];
                            String iloscs = iloscString.substring(iloscString.indexOf(':')+1);
                            
                            rs = stmt.executeQuery("select nazwa, opis, ilosc, cena, sciezka, kategoria from produkty where idprodukty="+ids+"");
                            while(rs.next())
                            {
                                System.out.println("dodalo");
                                Listaprodukt lp = new Listaprodukt(new Produkty(Integer.parseInt(ids),rs.getString("nazwa"), rs.getString("opis"), 
                                        rs.getDouble("cena"), rs.getString("sciezka"), rs.getInt("ilosc"), rs.getString("kategoria")));
                                lp.setIlosc(Short.parseShort(iloscs));
                                lista.add(lp);
                            }   
                        }
                        Lista listaobiekt = new Lista();
                        listaobiekt.setListaproduktow(lista);
                        listaobiekt.setSuma( listaobiekt.getSubtotal());
                        sc.setAttribute("listaprod", lista);
                        sc.setAttribute("obiektlista", listaobiekt);
                        System.out.println("dodaloliste");

                    } catch (Exception e) {
                        System.out.println("wypisz blad");
                    }

                }

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

