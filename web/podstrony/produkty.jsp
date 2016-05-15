<%@ taglib prefix="c" 
           uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page errorPage="errorpage" %>
<div id="categoryRightColumn">
    <table id="productTable">

        <c:forEach var="product" items="${produkty}" varStatus="iter">
            <tr class="${((iter.index % 2) == 0) ? 'lightBlue' : 'white'}">
                <td>
                    <img src="images/products/${product.sciezka}.png"
                         alt="<c:out value='${product.sciezka}'/>">
                </td>

                <td>
                    <c:out value="${product.nazwa}"/>
                    <br>
                    <span class="smallText"><c:out value='${product.opis}'/></span>
                </td>
                <td>
                    <c:out value="${product.ilosc}"/>
                </td>
                <td>
                    <c:out value="${product.kategoria}"/>
                </td>
                <td><fmt:formatNumber type="currency" currencySymbol="&euro; " value="${product.cena}"/></td>
                <% if (session.getAttribute("user") != null) { %>
                <td>
                    <form action="<c:url value='Dodaj'/>" method="post">
                        <input type="hidden"
                               name="productId"
                               value="${product.id}">
                        <input type="submit"
                               name="submit"
                               value="<c:out value='Dodaj do listy'/>">
                    </form>
                </td>
                <td>
                    <form action="<c:url value='Edytuj'/>" method="post">
                        <input type="hidden"
                               name="productId"
                               value="${product.id}">
                        <input type="submit"
                               name="submit"
                               value="<c:out value='Edytuj'/>">
                    </form>
                </td>
                <td>
                    <form action="<c:url value='Usun'/>" method="post">
                        <input type="hidden"
                               name="productId"
                               value="${product.id}">
                        <input type="submit"
                               name="submit"
                               value="<c:out value='Usuń'/>">
                    </form>
                </td>
                <%}%>
            </tr>

        </c:forEach>
        <td>
            <form action="<c:url value='./dodajprodukt'/>">
                <input type="submit"
                       name="submit"
                       value="<c:out value='Dodaj produkt'/>">
            </form>
        </td>
    </table>
</div>