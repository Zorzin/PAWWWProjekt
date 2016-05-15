<%-- 
    Document   : realizacjazlecenia
    Created on : 2016-05-15, 13:29:39
    Author     : marcin
--%>

<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="servlet.DBconnection"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Date"%>
<%@page import="klasy.Listaprodukt"%>
<%@page import="klasy.Lista"%>
<%@page import="klasy.Produkty"%>
<%@ taglib prefix="c" 
           uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@page import="xml.Realizacja"%>
<%@page import="xml.ItemList"%>
<%@page import="xml.ItemT"%>
<%@page import="xml.ObjectFactory"%>
<%@page import="xml.Datowanie"%>
<%@page import="javax.xml.bind.JAXBContext"%>
<%@page import="javax.xml.bind.JAXBElement"%>
<%@page import="javax.xml.bind.Marshaller"%>
<%@page import="javax.xml.bind.JAXBException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%
    Boolean generowac = false;
    List<Boolean> wystarczy = new ArrayList<Boolean>();
    ServletContext sc = request.getServletContext();
    Lista lista = (Lista) sc.getAttribute("obiektlista");
    Connection connection = DBconnection.getMySQLConnection("danelogowania");
    /*Sprawdzenie czy generować plik xml*/

    for (Listaprodukt produkt : lista.getProdukty()) {
        int id = produkt.getProdukt().getId();
        int ilosc = produkt.getIlosc();
        PreparedStatement pstmt = connection.prepareStatement(
                "select ilosc from produkty where idprodukty = ?");
        pstmt.setInt(1, id);
        ResultSet rs = pstmt.executeQuery();
        if (rs.next()) {
            if (ilosc <= rs.getInt("ilosc")) {
                wystarczy.add(true);
            } else {
                wystarczy.add(false);
            }
        }
    }
    if (!wystarczy.contains(false) && wystarczy.size() > 0) {
        generowac = true;
    }

    wystarczy.clear();

    /*Generowanie pliku xml koszyka */
    if (generowac) {
        ObjectFactory factory = new ObjectFactory();

        Date currentTime = new Date();
        String data = String.format("%tD %tr", currentTime, currentTime);

        Datowanie date = factory.createDatowanie();
        date.setCzasGenerowania(data);

        ItemList itemList = factory.createItemList();

        for (Listaprodukt produkt : lista.getProdukty()) {
            ItemT towar = factory.createItemT();
            String nazwa = produkt.getProdukt().getNazwa();
            String kategoria = produkt.getProdukt().getKategoria();
            String ile = Integer.toString(produkt.getIlosc());
            towar.setNazwa(nazwa);
            towar.setKategoria(kategoria);
            towar.setIlosc(ile);

            itemList.getItem().add(towar);
        }
        Realizacja realizacja = factory.createRealizacja();
        realizacja.setData(date);
        realizacja.setProdukty(itemList);

        JAXBContext context = JAXBContext.newInstance("xml", xml.ObjectFactory.class.getClassLoader());

        JAXBElement<Realizacja> element = factory.createZamowienie(realizacja);

        Marshaller marshaller = context.createMarshaller();

        marshaller.setProperty("jaxb.formatted.output", Boolean.TRUE);
        String path = "d:\\log\\zamowienie.xml";

        File os = new File(path);
        marshaller.marshal(element, os);
    } else {
        //Dodac co robic gdy wieksza ilosc w zamowieniu niz na stanie
    }
%>

