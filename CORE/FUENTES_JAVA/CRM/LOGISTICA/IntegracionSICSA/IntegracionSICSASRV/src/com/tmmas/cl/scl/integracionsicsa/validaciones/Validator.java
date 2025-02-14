package com.tmmas.cl.scl.integracionsicsa.validaciones;

import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import com.tmmas.cl.scl.integracionsicsa.common.exception.IntegracionSICSAException;
public class Validator {

    /**
     * Valida que el campo indicado tenga la longitud indicada por los
     * parametros de entrada
     * 
     * @param object
     *            Objeto de negocio que posee un atributo con el nombre del
     *            campo indicado como parametro de entrada.
     * @param objecName
     *            Nombre del campo que pertenece al objeto de negocio.
     * @param intMin
     *            Parametro que indica el minimo de caracteres del rango a
     *            validar
     * @param intMax
     *            Parametro que indica el final del rango a validar
     * @throws ValidatorException
     */
    public static void validarLargo(Object object, String strObjecName, Integer intMin, Integer intMax) throws IntegracionSICSAException {
        String value;
        if (object != null) {
            if (object instanceof Double) {
                value = String.valueOf(new BigDecimal(((Double) object).doubleValue()));
            } else {
                value = String.valueOf(object);
            }
            if (intMin != null) {
                if (value.length() < intMin.intValue()) {
                    throw new IntegracionSICSAException("ERROR FORMATO", 1, "El largo del campo es menor a lo permitido : " + strObjecName);
                }
            }
            if (intMax != null) {
                if (value.length() > intMax.intValue()) {
                    throw new IntegracionSICSAException("ERROR FORMATO", 1, "El largo del campo es mayor a lo permitido : " + strObjecName);
                }
            }
        }
    }
    
    public static void validarLargoSerie(Object object, String strObjecName, Integer intMin, Integer intMax) throws IntegracionSICSAException {
        String value;
        if (object != null) {
            if (object instanceof Double) {
                value = String.valueOf(new BigDecimal(((Double) object).doubleValue()));
            } else {
                value = String.valueOf(object);
            }
            if (intMin != null) {
                if (value.length() < intMin.intValue()) {
                    throw new IntegracionSICSAException("ERROR FORMATO", 1, "No todos los campos " + strObjecName+" de las series tienen el tamaño minimo permitido");
                }
            }
            if (intMax != null) {
                if (value.length() > intMax.intValue()) {
                    throw new IntegracionSICSAException("ERROR FORMATO", 1, "No todos los campos " + strObjecName+" de las series tienen el tamaño maximo permitido");
                }
            }
        }
    }

    /**
     * Valida que el campo indicado sea del tipo java indicado y su condicion de
     * nulo
     * 
     * @param object
     *            Objeto de negocio que posee un atributo con el nombre del
     *            campo indicado como parametro de entrada.
     * @param objecName
     *            Nombre del campo que pertenece al objeto de negocio.
     * @param bNullable
     *            Indica si valor puede ser nulo (true) o no puede ser nulo
     *            (false).}
     * @param bIsNumeric
     *            Indica si valor es un String numerico(true) o no(false).
     * @throws ValidatorException
     */
    public static void validarTipo(Object object, String strObjecName, boolean bNullable, boolean bIsNumeric) throws IntegracionSICSAException {

        if (!bNullable) {
            if (null == object) {
                throw new IntegracionSICSAException("ERROR FORMATO", 1, "El valor del campo no debe ser nulo : " + strObjecName);
            }

            if ("".equals(object.toString())) {
                throw new IntegracionSICSAException("ERROR FORMATO", 1, "El valor del campo no debe ser vacio : " + strObjecName);
            }
        }
        if (null != object && bIsNumeric) {
            try {
                Double.parseDouble(object.toString());
            } catch (Exception nfe) {
                throw new IntegracionSICSAException("ERROR FORMATO", 1, "El valor del campo debe ser numérico : " + strObjecName);
            }
        }
    }
    
    public static void validarTipoSerie(Object object, String strObjecName, boolean bNullable, boolean bIsNumeric) throws IntegracionSICSAException {

        if (!bNullable) {
            if (null == object) {
                throw new IntegracionSICSAException("ERROR FORMATO", 1, "<br>Existen series con el campo " + strObjecName+" nulo");
            }

            if ("".equals(object.toString())) {
                throw new IntegracionSICSAException("ERROR FORMATO", 1, "<br>Existen series con el campo " + strObjecName+" vacio");
            }
        }
        if (null != object && bIsNumeric) {
            try {
                Double.parseDouble(object.toString());
            } catch (Exception nfe) {
                throw new IntegracionSICSAException("ERROR FORMATO", 1, "<br>No todos los campos " + strObjecName+" de las series son númericos");
            }
        }
    }

    /**
     * Valida Fecha
     * 
     * @param String
     * @return Date
     * @throws SpnSclBException
     * @author Hugo Olivares Martínez
     */
    public void validarFecha(String f, String campo) throws IntegracionSICSAException {
        SimpleDateFormat formatoDelTexto = new SimpleDateFormat("dd/MM/yyyy");
        try {
            formatoDelTexto.parse(f);
        } catch (ParseException e) {
            throw new IntegracionSICSAException("ERROR FORMATO", 1, "Error en la fecha, el formato correcto es dd/MM/yyyy : " + campo);
        }
    }
}
