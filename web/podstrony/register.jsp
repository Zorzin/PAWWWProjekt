<%@page contentType="text/html" pageEncoding="UTF-8"%>

<div id="reg">
    <h1> Dodaj sklep: </h1>
    
    <% ServletContext sc = this.getServletContext();
        if (sc.getAttribute("register")=="error") {%>
    <h3 style="color:red">Wystąpił problem z rejestracją, spróbuj ponownie!</h3>
    <%sc.removeAttribute("register");
        }%>

    <form action="testregister.jsp" method="post">
        <div class="block">
            <label>Nazwa:</label>
            <input type="text" name="nazwa"/>
        </div>
        <div class="block">
            <label>Adres:</label>
            <input type="text" name="adres"/>
        </div>
        <div class="block">
            <label>Miasto:</label>
            <input type="text" name="miasto"/>
        </div>
        <input type="submit" value="Dodaj sklep"/>
    </form>
</div>
