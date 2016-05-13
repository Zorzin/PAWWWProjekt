<%@ taglib prefix="c" 
           uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<div id="categoryRightColumn">


    <table id="productTable">

        <c:forEach var="product" items="${produkty}" varStatus="iter">
            <tr class="${((iter.index % 2) == 0) ? 'lightBlue' : 'white'}">
                <td>
                    <img src="${initParam.productImagePath}${product.sciezka}.png"
                         alt="<c:out value='${product.sciezka}'/>">
                </td>

                <td>
                    <c:out value="${product.nazwa}"/>
                    <br>
                    <span class="smallText"><c:out value='${product.opis}'/></span>
                </td>

                <td><fmt:formatNumber type="currency" currencySymbol="&euro; " value="${product.cena}"/></td>

                <td>
                    <form action="<c:url value='addToCart'/>" method="post">
                        <input type="hidden"
                               name="productId"
                               value="${product.id}">
                        <input type="submit"
                               name="submit"
                               value="<c:out value='addToCart'/>">
                    </form>
                </td>
            </tr>

        </c:forEach>

    </table>
</div>