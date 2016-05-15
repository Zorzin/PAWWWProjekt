/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import klasy.Produkty;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import klasy.Lista;
import klasy.Listaprodukt;

/**
 *
 * @author marcin
 */
public class ServletKontrolny extends HttpServlet {
    String baza;
    
    public void init() throws ServletException {
        ServletConfig ctx = this.getServletConfig();
        baza = ctx.getInitParameter("nazwabazy");
        ServletContext sc = this.getServletContext();
        sc.setAttribute("nazwabazy", baza);
    }
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */

        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String userPath = request.getServletPath();
        String tmp = userPath.substring(userPath.lastIndexOf("/"));
        HttpSession session = request.getSession();
        if (userPath.equals("/login")) {
            // TODO: Implement login request

        } else if (userPath.equals("/rejestracja")) {
            // TODO: Implement rejestracja page request
            userPath = "/register";

        } else if (userPath.equals("/produkty")) {
            // TODO: Implement produkty page request
            // Wczytanie produktow
            if (session.getAttribute("user") != null) {
                deleteCookie(request, response);
                makeCookie(request, response, tmp);
                AddAktywnosc(request, response, "odwiedzono strone: produkty");
            }
            List<Produkty> lista = new ArrayList<Produkty>();
            try {
                Connection connection = DBconnection.getMySQLConnection(baza);
                Statement stmt = connection.createStatement();
                ResultSet rs = stmt.executeQuery("select * from produkty");
                while (rs.next()) {
                    Produkty produkty = new Produkty(rs.getInt("idprodukty"), rs.getString("nazwa"), rs.getString("opis"),
                            rs.getDouble("cena"), rs.getString("sciezka"), rs.getInt("ilosc"),
                            rs.getString("kategoria"));
                    lista.add(produkty);
                }
                ServletContext sc = this.getServletContext();
                sc.setAttribute("produkty", lista);
                request.setAttribute("produkty", lista);

            } catch (Exception e) {
                e.printStackTrace();
            }

        } else if (userPath.equals("/lista")) {
            if (session.getAttribute("user") != null) {
                deleteCookie(request, response);
                makeCookie(request, response, tmp);
                AddAktywnosc(request, response, "odwiedzono strone: lista");
            }
            ServletContext sc = this.getServletContext();
            Lista lista = (Lista) sc.getAttribute("obiektlista");
            if (lista != null) {
                List<Listaprodukt> list = lista.getProdukty();
                check(list);
                sc.setAttribute("listaprod", lista.getProdukty());
                sc.setAttribute("obiektlista", lista);
            }
            
        } else if (userPath.equals("/kontakt")) {
            // TODO: Implement kontakt request
            if (session.getAttribute("user") != null) {
                deleteCookie(request, response);
                makeCookie(request, response, tmp);
                AddAktywnosc(request, response, "odwiedzono strone: kontakt");
            }
        } else if (userPath.equals("/glowna")) {
            if (session.getAttribute("user") != null) {
                deleteCookie(request, response);
                makeCookie(request, response, "/");
                AddAktywnosc(request, response, "odwiedzono strone: glowna");
            }
        } else if (userPath.equals("/edytuj")) {
            if (session.getAttribute("user") != null) {
                deleteCookie(request, response);
                makeCookie(request, response, tmp);
                AddAktywnosc(request, response, "odwiedzono strone: edytuj");
            }
        } else if (userPath.equals("/dodajprodukt")) {
            if (session.getAttribute("user") != null) {
                deleteCookie(request, response);
                makeCookie(request, response, tmp);
                AddAktywnosc(request, response, "odwiedzono strone: dodaj produkty");
            }
        }

        // use RequestDispatcher to forward request internally
        String url;
        if (!userPath.equals("/glowna")) {
            url = "./podstrony" + userPath + ".jsp";
        } else {
            url = "/";
        }

        try {

            request.getRequestDispatcher(url).forward(request, response);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private void makeCookie(HttpServletRequest request, HttpServletResponse response, String path)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Cookie cookie = new Cookie(session.getAttribute("user").toString(), path);

        // Usunie po 1h.
        cookie.setMaxAge(60 * 60);
        response.addCookie(cookie);
    }

    private void deleteCookie(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals(session.getAttribute("user").toString())) {
                    cookie.setMaxAge(0);
                }
            }
        }
    }

    public void check(List<Listaprodukt> lista) {

        for (Listaprodukt produkt : lista) {

            if(!Update(produkt.getProdukt(), produkt.getProdukt().getId()))
            {
                lista.remove(produkt);
            }
        }
    }

    private boolean Update(Produkty produkty, int id) {
        boolean b=false;
        try {
            Connection connection = DBconnection.getMySQLConnection(baza);
            Statement stmt = connection.createStatement();
            ResultSet rs = stmt.executeQuery("select nazwa, opis, cena, ilosc, sciezka, kategoria from produkty where idprodukty=" + id + ";");
            while (rs.next()) {
                b=true;
                produkty.setCena(rs.getDouble("cena"));
                produkty.setIlosc(rs.getInt("ilosc"));
                produkty.setNazwa(rs.getString("nazwa"));
                produkty.setOpis(rs.getString("opis"));
                produkty.setSciezka(rs.getString("sciezka"));
                produkty.setKategoria(rs.getString("kategoria"));
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return  b;
    }

    private void AddAktywnosc(HttpServletRequest request,
            HttpServletResponse response, String nazwa)
            throws ServletException, IOException {
        try {
            ServletContext sc = this.getServletContext();
            Connection con = DBconnection.getMySQLConnection(baza);
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
                    + id + ",'" + sc.getAttribute("user") + "','"
                    + nazwa + "','" + data + "')";

            st.executeUpdate(sql);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
