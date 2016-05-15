package klasy;

import com.sun.org.apache.xerces.internal.impl.dv.xs.IDDV;



/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author zorzi
 */
public class Produkty {
    private int id;
    private String nazwa;
    private String opis;
    private double cena;
    private String sciezka;
    private int ilosc;
    private String kategoria;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNazwa() {
        return nazwa;
    }

    public void setNazwa(String nazwa) {
        this.nazwa = nazwa;
    }

    public String getOpis() {
        return opis;
    }

    public void setOpis(String opis) {
        this.opis = opis;
    }

    public double getCena() {
        return cena;
    }

    public void setCena(double cena) {
        this.cena = cena;
    }

    public String getSciezka() {
        return sciezka;
    }

    public void setSciezka(String sciezka) {
        this.sciezka = sciezka;
    }

    public int getIlosc() {
        return ilosc;
    }

    public void setIlosc(int ilosc) {
        this.ilosc = ilosc;
    }

    public String getKategoria() {
        return kategoria;
    }

    public void setKategoria(String kategoria) {
        this.kategoria = kategoria;
    }
    
    public Produkty(int id,String nazwa, String opis, double cena, String sciezka, int ilosc, String kategoria)
    {
        this.id = id;
        this.nazwa = nazwa;
        this.opis=opis;
        this.cena = cena;
        this.sciezka = sciezka;
        this.ilosc = ilosc;
        this.kategoria = kategoria;
    }
}
