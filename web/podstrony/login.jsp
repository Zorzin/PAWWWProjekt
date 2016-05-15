<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page errorPage="errorpage" %>
<div id="mainpage">
    <!-- main page, ajax pewnie -->
    <div id="log">
        <h1>Mam już konto:</h1>
        <% ServletContext sc = this.getServletContext();
        if(sc.getAttribute("login") == "error"){%>
        <h3 style="color:red">Niepoprawny Login lub Hasło!</h3>
        <%sc.removeAttribute("login"); }%>
        <form action="testlogin.jsp" method="post">
            <p> Login </p><input type="text" name="user"/> <br/>
            <p> Hasło </p><input type="password" name = "password"/> <br/><br/>
            <input type="submit" value="Zaloguj"/>
        </form>
    </div>
</div>

