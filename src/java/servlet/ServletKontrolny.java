/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author marcin
 */
public class ServletKontrolny extends HttpServlet {

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
            if (session.getAttribute("user") != null) {
                deleteCookie(request, response);
                makeCookie(request, response, tmp);
            }
        } else if (userPath.equals("/koszyk")) {
            // TODO: Implement koszyk request
            if (session.getAttribute("user") != null) {
                deleteCookie(request, response);
                makeCookie(request, response, tmp);
            }

        } else if (userPath.equals("/kontakt")) {
            // TODO: Implement kontakt request
            if (session.getAttribute("user") != null) {
                deleteCookie(request, response);
                makeCookie(request, response, tmp);
            }

        } else if (userPath.equals("/glowna")){
            if (session.getAttribute("user") != null) {
                deleteCookie(request, response);
                makeCookie(request, response, "/");
            }
        }

        // use RequestDispatcher to forward request internally
        String url;
        if(!userPath.equals("/glowna"))
        {
            url = "./podstrony" + userPath + ".jsp";
        }
        else
        {
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
}
