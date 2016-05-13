<%@ taglib prefix="c" 
           uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%-- HTML markup starts below --%>

<div id="singleColumn">

     <h4 id="subtotal"><c:out value="Lacznie"/>:
          <fmt:formatNumber type="currency" currencySymbol="&euro; " value="${cart.subtotal}"/>
      </h4>

      <table id="cartTable">

        <tr class="header">
            <th><c:out value="Produkt"/></th>
            <th><c:out value="Nazwa"/></th>
            <th><c:out value="Cena"/></th>
            <th><c:out value="Ilosc"/></th>
        </tr>

        <c:forEach var="cartItem" items="${Lista.listaproduktow}" varStatus="iter">

          <c:set var="product" value="${Listaprodukt.produkt}"/>

          <tr class="${((iter.index % 2) == 0) ? 'lightBlue' : 'white'}">
            <td>
                <img src="${initParam.productImagePath}${product.name}.png"
                     alt="<fmt:message key= "${product.name}" />">
            </td>

            <td><fmt:message key="${product.name}"/></td>

            <td>
                <fmt:formatNumber type="currency" currencySymbol="&euro; " value="${cartItem.total}"/>
                <br>
                <span class="smallText" >(
                    <fmt:formatNumber type="currency" currencySymbol="&euro; " value="${product.price}"/>
                    / <fmt:message key="unit"/> )</span>
            </td>

            <td>
                <form action="<c:url value='updateCart'/>" method="post">
                    <input type="hidden"
                           name="productId"
                           value="${product.id}">
                    <input type="text"
                           maxlength="2"
                           size="2"
                           value="${cartItem.quantity}"
                           name="quantity"
                           style="margin:5px">
                    <input type="submit"
                           name="submit"
                           value="<fmt:message key='update'/>">
                </form>
            </td>
          </tr>

        </c:forEach>

      </table>
</div>