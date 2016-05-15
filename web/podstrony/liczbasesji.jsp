<%-- 
    Document   : liczbasesji
    Created on : 2016-05-15, 22:43:07
    Author     : marcin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:useBean class="listener.SessionListener"
          id="sessionCounter" scope="application" />
<UL>
<LI>Łączna liczba sesji w życiu tej aplikacji:
   <jsp:getProperty name="sessionCounter"
               property="totalSessionCount" />.
<LI>Liczba sesji aktualnie w pamięci:
  <jsp:getProperty name="sessionCounter"
              property="currentSessionCount" />.
<LI>Maksymalna liczba sesji będących w pamięci w tym samym czasie:
   <jsp:getProperty name="sessionCounter"
               property="maxSessionCount" />.
</UL>
