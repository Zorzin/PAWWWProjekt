/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package klasy;

/**
 *
 * @author zorzi
 */
public class Listaprodukt {

    Produkty produkt;
    short ilosc;

    public Listaprodukt(Produkty produkt) {
        this.produkt = produkt;
        ilosc = 1;
    }

    public Produkty getProdukt() {
        return produkt;
    }

    public short getIlosc() {
        return ilosc;
    }

    public void setIlosc(short ilosc) {
        this.ilosc = ilosc;
    }

    public void incrementIlosc() {
        ilosc++;
    }

    public void decrementIlosc() {
        ilosc--;
    }

    public double getSuma() {
        double suma = 0;
        suma = (this.getIlosc() * produkt.getCena());
        return suma;
    }

}