<%@page contentType="text/html" pageEncoding="UTF-8"%>

<div id="reg">
    <h1> Załóż nowe konto: </h1>
    <h2> Wpisz swoje dane i załóż konto w hurtowni.</h2>
    <form action="testregister.jsp" method="post">
        <div class="block">
            <label>Login:</label>
            <input type="text" name="login"/>
        </div>
        <div class="block">
            <label>E-mail:</label>
            <input type="text" name="email"/>
        </div>
        <div class="block">
            <label>Hasło:</label>
            <input type="password" name="password"/>
        </div>
        <input type="submit" value="Załóż konto"/>
    </form>
</div>
