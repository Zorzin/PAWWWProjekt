<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page errorPage="errorpage" %>
<div id="reg">
    <h1> Dodaj produkt: </h1>


    <form action="DodajProdukt" method="post">
        <div class="block">
            <label>Nazwa:</label>
            <input type="text" 
                   name="nazwa"/>
        </div>
        <div class="block">
            <label>Opis:</label>
            <input type="text" 
                   name="opis"/>
        </div>
        <div class="block">
            <label>Ścieżka:</label>
            <input type="text" 
                   name="sciezka"/>
        </div>
        <div class="block">
            <label>Ilość:</label>
            <input type="text" 
                   name="ilosc"/>
        </div>
        <div class="block">
            <label>Cena:</label>
            <input type="text" 
                   name="cena"/>
        </div>
        <div class="block">
            <label>Kategoria:</label>
            <input type="text" 
                   name="kategoria"/>
        </div>
        <input type="submit" 
               value="Dodaj"/>
    </form>
</div>