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
    Source schemaFile = new StreamSource(new File("C:\\Users\\zorzi\\Documents\\NetBeansProjects\\PAWWWProjekt-master\\web\\schemat.xsd"));
    Source xmlFile = new StreamSource(new File("d:\\log\\zamowienie.xml"));
    SchemaFactory schemaFactory = SchemaFactory
        .newInstance(XMLConstants.W3C_XML_SCHEMA_NS_URI);
    Schema schema = schemaFactory.newSchema(schemaFile);
    Validator validator = schema.newValidator();
    try {
      validator.validate(xmlFile);
      out.print(xmlFile.getSystemId());%>
      is valid<%
    } catch (SAXException e) {
      xmlFile.getSystemId();%>
      is NOT valid<br>
      Reason: <%e.getLocalizedMessage();
    }
%>
