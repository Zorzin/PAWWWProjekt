<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page errorPage="errorpage" %>
<div id="reg">
    <h1> Edytuj produkt: </h1>


    <form action="ZapiszEdytuj" method="post">
        <input type="hidden"
               name="productId"
               value="${produkt.id}">
        <div class="block">
            <label>Nazwa:</label>
            <input type="text" 
                   name="nazwa" 
                   value="${produkt.nazwa}"/>
        </div>
        <div class="block">
            <label>Opis:</label>
            <input type="text" 
                   name="opis" 
                   value="${produkt.opis}"/>
        </div>
        <div class="block">
            <label>Ścieżka:</label>
            <input type="text" 
                   name="sciezka" 
                   value="${produkt.sciezka}"/>
        </div>
        <div class="block">
            <label>Ilość:</label>
            <input type="text" 
                   name="ilosc" 
                   value="${produkt.ilosc}"/>
        </div>
        <div class="block">
            <label>Cena:</label>
            <input type="text" 
                   name="cena" 
                   value="${produkt.cena}"/>
        </div>
        <div class="block">
            <label>Kategoria:</label>
            <input type="text" 
                   name="kategoria" 
                   value="${produkt.kategoria}"/>
        </div>
        <input type="submit" 
               value="Zapisz"/>
    </form>
</div>