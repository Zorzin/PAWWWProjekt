/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import klasy.Lista;
import klasy.Listaprodukt;
import klasy.Produkty;

/**
 *
 * @author zorzi
 */
public class Dodaj extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     */
    public Lista lista;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            ServletContext sc = this.getServletContext();
            int id = Integer.parseInt(request.getParameter("productId"));
            List<Produkty> listaProdukty = (List) sc.getAttribute("produkty");
            synchronized (getServletContext()) {
                lista = (Lista) sc.getAttribute("obiektlista");
                if (lista == null) {
                    lista = new Lista();
                    lista.addProdukt(checkid(id, listaProdukty));

                } else {
                    lista.addProdukt(checkid(id, listaProdukty));
                }
            }
            sc.setAttribute("obiektlista", lista);
            sc.setAttribute("listaprod", lista.getProdukty());
            request.getRequestDispatcher("./podstrony/lista.jsp").forward(request, response);
        }
    }

    public Produkty checkid(int id, List<Produkty> lista) {

        for (Produkty produkt : lista) {
            if (id == produkt.getId()) {
                return produkt;
            }
        }
        return null;
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
        processRequest(request, response);
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

}
