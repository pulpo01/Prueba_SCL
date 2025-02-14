package com.tmmas.scl.gestionlc.web.helper;

public class Utilidades {

    // ----------------------------------------------------------------------------
    // Este metodo devuelve un blanco si el texto de parametro es nulo.
    // Usado en la capa de presentacion para evitarnos comparaciones.
    public  String devuelveBlanco(String texto) {

        if (texto != null) {
            if (!"null".equals(texto)) {
                return texto;
            } else {
                return "";
            }
        }
        return "";
    } // devuelveBlanco

    // ----------------------------------------------------------------------------
    // ----------------------------------------------------------------------------
    public static String eliminaCaracterdeCadena(char inVal, String cadena) {
        String retValue;
        retValue = cadena.replace(inVal, ' ');
        retValue = eliminaEspaciosCadena(retValue);
        return retValue;
    }

    public static String eliminaEspaciosCadena(String cadena) {
        String retValue = "";
        for (int x = 0; x < cadena.length(); x++) {
            if (cadena.charAt(x) != ' ') {
                retValue += cadena.charAt(x);
            }
        }
        return retValue;
    }
}
