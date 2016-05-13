<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div id="mainpage">
    <!-- main page, ajax pewnie -->
    <div id="log">
        <h1>Mam już konto:</h1>
        <form action="testlogin.jsp" method="post">
            <p> Login </p><input type="text" name="user"/> <br/>
            <p> Hasło </p><input type="password" name = "password"/> <br/><br/>
            <input type="submit" value="Zaloguj"/>
        </form>
    </div>
    <div id="reglog">
        <h1> Załóż nowe konto: </h1>
        <form>
            <input type="button" value="Załóż konto" onclick="location.href = 'rejestracja'"/>
        </form>
    </div>
</div>

