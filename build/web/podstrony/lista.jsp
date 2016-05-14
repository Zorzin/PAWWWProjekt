<%@ taglib prefix="c" 
           uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%-- HTML markup starts below --%>
<%

     ServletContext sc = request.getServletContext();
     sc.getAttribute("listaprod");
     sc.getAttribute("obiektlista");

%>
<div id="singleColumn">

     <h4 id="subtotal"><c:out value="Lacznie"/>:
          <fmt:formatNumber type="currency" currencySymbol="&euro; " value="${obiektlista.suma}"/>
      </h4>

      <table id="cartTable">

        <tr class="header">
            <th><c:out value="Nazwa"/></th>
            <th><c:out value="Cena"/></th>
            <th><c:out value="Ilosc"/></th>
        </tr>

        <c:forEach var="cartItem" items="${listaprod}" varStatus="iter">

          <c:set var="product" value="${obiektlista}"/>
          <c:set var="item" value="${cartItem.produkt}"/>

          <tr class="${((iter.index % 2) == 0) ? 'lightBlue' : 'white'}">
            

            <td><c:out value="${item.nazwa}"/></td>

            <td>
                <fmt:formatNumber type="currency" currencySymbol="&euro; " value="${cartItem.suma}"/>
                <br>
                <span class="smallText" >(
                    <fmt:formatNumber type="currency" currencySymbol="&euro; " value="${item.cena}"/>
                    / <c:out value="unit"/> )</span>
            </td>

            <td>
                <form action="<c:url value='UpdateCart'/>" method="post">
                    <input type="hidden"
                           name="productId"
                           value="${item.id}">
                    <input type="text"
                           maxlength="2"
                           size="2"
                           value="${cartItem.ilosc}"
                           name="quantity"
                           style="margin:5px">
                    <input type="submit"
                           name="submit"
                           value="<c:out value='update'/>">
                </form>
            </td>
          </tr>

        </c:forEach>

      </table>
</div>