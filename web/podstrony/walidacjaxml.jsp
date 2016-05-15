<%@page import="org.xml.sax.SAXException"%>
<%@page import="javax.xml.validation.Schema"%>
<%@page import="javax.xml.XMLConstants"%>
<%@page import="javax.xml.validation.*"%>
<%@page import="java.io.File"%>
<%@page import="javax.xml.transform.stream.StreamSource"%>
<%@page import="javax.xml.transform.Source"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    ServletContext sc = this.getServletContext();
    String name = sc.getAttribute("xml").toString();
    Source schemaFile = new StreamSource(new File("C:\\Users\\marcin\\Desktop\\PAWWWProjekt-master\\PAWWWProjekt-master\\web\\schemat.xsd"));
    Source xmlFile = new StreamSource(new File("D:\\log\\koszyk-" + name + ".xml"));
    SchemaFactory schemaFactory = SchemaFactory
            .newInstance(XMLConstants.W3C_XML_SCHEMA_NS_URI);
    Schema schema = schemaFactory.newSchema(schemaFile);
    Validator validator = schema.newValidator();
    try {
        validator.validate(xmlFile);
%>
<h2 style="color:green">Zrealizowano zamówienie</h2>
<h4>Plik:
<%
    out.print(xmlFile.getSystemId());
%>
jest poprawny.</h4>
<%
    sc.removeAttribute("listaprod");
    sc.removeAttribute("obiektlista");
} catch (SAXException e) {%>
<h2 style="color:red">Nie zrealizowano zamówienia!</h2><br>
<h4 style="color:red">Plik: </h4>
<%
    out.print(xmlFile.getSystemId());
%>
<h4 style="color:red">jest nieprawidłowy!</h4><br>
<h4>Powód: </h4><%out.print(e.getLocalizedMessage());
    }
%></h4>
