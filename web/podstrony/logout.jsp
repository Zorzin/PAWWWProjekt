<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    ServletContext sc = this.getServletContext();
    sc.removeAttribute("user");
    session.setAttribute("user", null);
    session.invalidate();
    response.sendRedirect("/Projekt");
%>
