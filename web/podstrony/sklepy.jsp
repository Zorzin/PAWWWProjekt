<%@page import="servlet.DBconnection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<sql:setDataSource var="sklepy"
     url="jdbc:mysql://localhost:3306/sklepydb"
     user="root"  password="admin"/>
<sql:query var="result" dataSource="${sklepy}">
    SELECT nazwa, adres, miasto FROM sklep
</sql:query>
<div class="info_right">
    <span style="font-size:36px;">
        <cite>
            <span style="font-family: comic sans ms,cursive;">
                <span style="color: rgb(67, 67, 67);">
                    Lista sklepów:
                </span>
            </span>
        </cite>
    </span>
    <span style="color: rgb(20, 20, 20);">
    <table border="1">
        <thead>
            <tr>
                <th>Nazwa</th>
                <th>Adres</th>
                <th>Miasto</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="currentRow" items="${result.rows}">
                <tr>
                    <td>${currentRow.nazwa}</td>
                    <td>${currentRow.adres}</td>
                    <td>${currentRow.miasto}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    </span>
</div>

