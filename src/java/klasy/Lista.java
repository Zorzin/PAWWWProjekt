/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package klasy;

import java.util.ArrayList;
import java.util.List;
import klasy.Listaprodukt;

/**
 *
 * @author zorzi
 */
public class Lista {
    
    private List<Listaprodukt> listaproduktow;
    private int ileproduktow;
    private double suma;
    
    public Lista()
    {
        listaproduktow =  new ArrayList<Listaprodukt>();
        ileproduktow=0;
        suma=0;
    }

    public synchronized void addProdukt(Produkty produkt) {

        boolean newItem = true;

        for (Listaprodukt produktLista : listaproduktow) {

            if (produktLista.getProdukt().getId() == produkt.getId()) {

                newItem = false;
                produktLista.incrementIlosc();
            }
        }

        if (newItem) {
            Listaprodukt p = new Listaprodukt(produkt);
            listaproduktow.add(p);
        }
        suma += produkt.getCena();
    }

    public synchronized void update(Produkty produkt, String ilosc) {

        short qty = -1;

        // cast quantity as short
        qty = Short.parseShort(ilosc);

        if (qty >= 0) {

            Listaprodukt item = null;

            for (Listaprodukt produktLista : listaproduktow) {

                if (produktLista.getProdukt().getId() == produkt.getId()) {

                    if (qty != 0) {
                        // set item quantity to new value
                        produktLista.setIlosc(qty);
                    } else {
                        // if quantity equals 0, save item and break
                        item = produktLista;
                        break;
                    }
                }
            }

            if (item != null) {
                // remove from cart
                listaproduktow.remove(item);
            }
        }
        suma = getSubtotal();
    }

    public synchronized List<Listaprodukt> getProdukty() {

        return listaproduktow;
    }

    public synchronized int getIloscProduktow() {

        ileproduktow = 0;

        for (Listaprodukt produktLista : listaproduktow) {

            ileproduktow += produktLista.getIlosc();
        }

        return ileproduktow;
    }

    public synchronized double getSubtotal() {

        double amount = 0;

        for (Listaprodukt produktLista : listaproduktow) {

            Produkty produkt = (Produkty) produktLista.getProdukt();
            amount += (produktLista.getIlosc() * produkt.getCena());
        }

        return amount;
    }


    public synchronized void obliczSuma(String wplata) {

        double amount = 0;

        // cast surcharge as double
        double s = Double.parseDouble(wplata);

        amount = this.getSubtotal();
        amount += s;

        suma = amount;
    }

    public synchronized double getSuma() {

        return suma;
    }

    public synchronized void czysc() {
        listaproduktow.clear();
        ileproduktow = 0;
        suma = 0;
    }

}