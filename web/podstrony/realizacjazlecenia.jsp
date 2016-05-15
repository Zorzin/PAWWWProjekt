<%@page import="java.nio.file.Path"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="java.io.FileWriter"%>
<%@ page errorPage="errorpage" %>
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
<%@page import="org.json.simple.JSONObject"%>
<%@ page errorPage="errorpage" %>
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
        Object i = sc.getAttribute("user");
        String name = i.toString();
        File f = new File("D:\\log\\koszyk-" + name + ".xml");
        if (f.exists()) {
            f.delete();
        }
<<<<<<< HEAD
        
        sc.removeAttribute("listaprod");
        sc.removeAttribute("obiektlista");
=======
        marshaller.marshal(element, f);
        sc.setAttribute("xml",name);
        
>>>>>>> 8b3cc197a84ad9780280c8a64f9b1e3e6592b858
        request.getRequestDispatcher("/podstrony/walidacjaxml.jsp").forward(request, response);
    } else {
        
        JSONObject mainobj = new JSONObject();
        JSONArray arr = new JSONArray();
        for (Listaprodukt produkt : lista.getProdukty()) {
            JSONObject obj = new JSONObject();
            obj.put("id", produkt.getProdukt().getId());
            obj.put("ilosc", produkt.getIlosc());
            arr.add(obj);

        }
        mainobj.put("List:", arr);
        Object i = sc.getAttribute("user");
        String name = i.toString();
        try (FileWriter file = new FileWriter("D:\\log\\koszyk-" + name + ".txt")) {
            file.write(mainobj.toJSONString());
        }
        %>
        <h2 style="color:red">Nie zrealizowano zamówienia!</h2>
        <h2>Brak dostępnych produktów.<br>
        Realizacja odłożona w czasie.</h2>
        <%
    }
%>
<h1>Za mało produktów na stanie, koszyk zapisany!</h1>
