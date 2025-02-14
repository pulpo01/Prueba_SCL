package com.tmmas.scl.gestionlc.common.validation;

import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Locale;
import java.util.StringTokenizer;

import com.tmmas.scl.gestionlc.common.validation.exception.CampoObligatorioException;
import com.tmmas.scl.gestionlc.common.validation.exception.FormatoFechaException;
import com.tmmas.scl.gestionlc.common.validation.exception.LargoInferiorAlMinimoException;
import com.tmmas.scl.gestionlc.common.validation.exception.LargoSuperiorAlMaximoException;
import com.tmmas.scl.gestionlc.common.validation.exception.NoEsAlfanumericoException;
import com.tmmas.scl.gestionlc.common.validation.exception.NoEsDecimalException;
import com.tmmas.scl.gestionlc.common.validation.exception.NoEsEnteroException;
import com.tmmas.scl.gestionlc.common.validation.exception.NoEsFechaConHoraException;
import com.tmmas.scl.gestionlc.common.validation.exception.NoEsLetrasException;

public class ValidationHelper {

    public static String alfaNumerico = "ALFANUMERICO";
    public static String entero = "ENTERO";
    public static String letras = "LETRAS";
    public static String decimal = "DECIMAL";
    public static String fecha = "FECHA";
    public static String fechaConHora = "FECHACONHORA";

    /**
     * permite validar caracteristicas de un parametro tales como: tipo,
     * obligatoriedad, largo minimo, largo maximo
     * 
     * @param pTipo
     * @param pRequerido
     * @param pLargoMinimo
     * @param pLargoMaximo
     * @param pValor
     * @return
     */
    public static boolean validarParametro(String pTipo, boolean pRequerido, int pLargoMinimo, int pLargoMaximo, String pValor) {

        boolean result = false;

        // validar si es requerido
        if (pRequerido) {

            if (pValor == null || pValor.trim().length() == 0) {
                throw new CampoObligatorioException();
            }

        }

        // validar el largo minimo
        if (pValor != null && pValor.trim().length() > 0) {
            if (pValor.length() < pLargoMinimo) {
                throw new LargoInferiorAlMinimoException();
            }
        }
        // validar el largo maximo
        if (pValor != null && pValor.trim().length() > 0) {
            if (pValor.length() > pLargoMaximo) {
                throw new LargoSuperiorAlMaximoException();
            }
        }

        // validar dependiendo del tipo
        if (pValor != null && pValor.trim().length() > 0) {
            if (alfaNumerico.equals(pTipo)) {

                if (!esAlfanumerico(pValor)) {
                    throw new NoEsAlfanumericoException();
                }

            } else if (entero.equals(pTipo)) {

                if (!esEntero(pValor)) {
                    throw new NoEsEnteroException();
                }
            } else if (letras.equals(pTipo)) {

                if (!esLetras(pValor)) {
                    throw new NoEsLetrasException();
                }

            } else if (decimal.equals(pTipo)) {

                if (!esDecimal(pValor)) {
                    throw new NoEsDecimalException();
                }
            } else if (fecha.equals(pTipo)) {

                if (!formatoFecha(pValor)) {
                    throw new FormatoFechaException();
                }
            } else if (fechaConHora.equals(pTipo) && !" 00:00:00".equals(pValor) && !" ::".equals(pValor)) {
                if (!formatoFechaConHora(pValor)) {
                    throw new NoEsFechaConHoraException();
                }
            }
        }

        result = true;

        return result;
    }

    /**
     * Esta validación esta orientado a objeto y permite validar que si es
     * obligatorio el objeto debe ser distinto de nulo.
     * 
     * @param pRequerido
     * @param pValor
     * @return
     */
    public static boolean validarParametro(boolean pRequerido, Object pValor) {

        boolean result = false;

        // validar si es requerido
        if (pRequerido) {

            if (pValor == null) {
                throw new CampoObligatorioException();
            }

        }

        result = true;

        return result;
    }

    /**
     * valida si un String es alfanumerico
     * 
     * @param pValor
     * @return
     */
    public static boolean esAlfanumerico(String pValor) {

        if ("".equalsIgnoreCase(eliminacionEtiquetasYsimbolosXSSCopia(pValor))) {
            return false;
        }

        return true;

    }

    /**
     * permite validar si un String es un numero entero
     * 
     * @param pValor
     * @return
     */
    public static boolean esEntero(String pValor) {

        char[] cs = pValor.toCharArray();
        for (int i = 0; i < cs.length; i++) {
            if (!Character.isDigit(cs[i])) {
                return false;
            }
        }

        return true;
    }

    /**
     * Permite validar si un String esta compuesto solo por letras
     * 
     * @param pValor
     * @return
     */
    public static boolean esLetras(String pValor) {

        char[] cs = pValor.toCharArray();
        for (int i = 0; i < cs.length; i++) {
            if (!Character.isLetter(cs[i])) {
                return false;
            }
        }

        return true;
    }

    /**
     * Permite validar si un String es un decimal
     * 
     * @param pValor
     * @return
     */
    public static boolean esDecimal(String pValor) {

        try {

            BigDecimal bd = new BigDecimal(pValor.trim());

        } catch (Exception ex) {
            return false;
        }

        return true;
    }

    /**
     * Permite validar el formato de la fecha
     * 
     * @param pValor
     * @return
     */
    public static boolean formatoFecha(String pValor) {

        try {
            SimpleDateFormat formatoFecha = new SimpleDateFormat("dd-MM-yyyy", Locale.getDefault());
            formatoFecha.setLenient(false);
            formatoFecha.parse(pValor);
        } catch (ParseException e) {
            return false;
        }

        return true;
    }

    /**
     * Permite validar el formato de la fecha con la hora incluida
     * 
     * @param pValor
     * @return
     */
    public static boolean formatoFechaConHora(String pValor) {

        try {
            SimpleDateFormat formatoFecha = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss", Locale.getDefault());
            formatoFecha.setLenient(false);
            formatoFecha.parse(pValor);
        } catch (ParseException e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }

    /**
     * 
     * permite validar el formato de un decimal, verificando que cumpla con con
     * la cantidad de caracteres enteros y decimales
     * 
     * @param pValor
     * @param pCantEntero
     * @param pCantDecimal
     * @return
     */
    public static boolean validateFormatFloat(String pValor, int pCantEntero, int pCantDecimal) {

        String separadorDecimal = ".";
        Boolean resultado = true;
        int indexPunto = pValor.indexOf(separadorDecimal);

        if (indexPunto == -1) {
            // que solo viene la parte entera y se valida que no supere la
            // cantidad pasada por parametro
            if (pValor.length() > pCantEntero) {
                resultado = false;
            } else {
                resultado = true;
            }
        }

        StringTokenizer st = new StringTokenizer(pValor, separadorDecimal);

        if (st.countTokens() != 2) {
            resultado = false;
        }

        // obtengo la parte entera
        if (st.hasMoreTokens()) {

            String parteEntera = st.nextToken();

            if (parteEntera.length() > pCantEntero) {
                resultado = false;
            }
        }

        // obtengo la parte decimal
        if (st.hasMoreTokens()) {

            String parteDecimal = st.nextToken();

            if (parteDecimal.length() > pCantDecimal) {
                resultado = false;
            }
        }

        return resultado;
    }

    /**
     * permite validar que la fecha de entrada
     * 
     * @param pDate
     * @param pFormatDate
     * @return
     */
    /*
     * public static boolean isAfterSysdate(String pDate, String pFormatDate){
     * 
     * boolean result = false;
     * 
     * Calendar mySysdate = new GregorianCalendar();
     * 
     * DateFormat formatter = new SimpleDateFormat(pFormatDate);
     * 
     * Date dateIn = null;
     * 
     * try {
     * 
     * dateIn = (Date)formatter.parse(pDate);
     * 
     * } catch (ParseException e) {
     * 
     * e.printStackTrace(); throw new ErrorInesperadoException(e);
     * 
     * }
     * 
     * Calendar calFechaIn = Calendar.getInstance();
     * 
     * calFechaIn.setTime(dateIn);
     * 
     * result = calFechaIn.after(mySysdate);
     * 
     * return result; }
     */

    public static String eliminacionEtiquetasYsimbolosXSSCopia(String pres) {

        /*
         * if(res == null){ return ""; }else{
         */
        String res = pres.trim();
        String resultado = "";

        /**/
        if (res.indexOf("<") != -1) {
            resultado = "";
        }

        if (res.indexOf(">") != -1) {
            resultado = "";
        }

        if (res.indexOf("'") != -1) {
            resultado = "";
        }

        if (res.indexOf("%") != -1) {
            resultado = "";
        }

        if (res.indexOf(";") != -1) {
            resultado = "";
        }

        if (res.indexOf("&") != -1) {
            resultado = "";
        }

        if (res.indexOf("&lt;") != -1) {
            resultado = "";
        }

        if (res.indexOf("&#60;") != -1) {
            resultado = "";
        }

        if (res.indexOf("&gt;") != -1) {
            resultado = "";
        }

        if (res.indexOf("&#62;") != -1) {
            resultado = "";
        }

        if (res.indexOf("&amp;") != -1) {
            resultado = "";
        }

        if (res.indexOf("&#38;") != -1) {
            resultado = "";
        }

        if (res.indexOf("&quot;") != -1) {
            resultado = "";
        }

        if (res.indexOf("&#34;") != -1) {
            resultado = "";
        }

        if (res.indexOf("&#39;") != -1) {
            resultado = "";
        }

        if (res.indexOf("&#40;") != -1) {
            resultado = "";
        }

        if (res.indexOf("&#41;") != -1) {
            resultado = "";
        }

        if (res.indexOf("&#35;") != -1) {
            resultado = "";
        }

        if (res.indexOf("&#37;") != -1) {
            resultado = "";
        }

        if (res.indexOf("&#59;") != -1) {
            resultado = "";
        }

        if (res.indexOf("&#43;") != -1) {
            resultado = "";
        }

        if (res.indexOf("&#45;") != -1) {
            resultado = "";
        }

        resultado = res;
        return resultado;
        // }
    }

    public String eliminacionEtiquetasYsimbolosXSS(String pres) {

        /*
         * if(res == null){ return ""; }else{
         */
        String res = pres.trim();
        String resultado = "";

        /**/
        if (res.indexOf("<") != -1) {
            resultado = "";
        }

        if (res.indexOf(">") != -1) {
            resultado = "";
        }

        if (res.indexOf("'") != -1) {
            resultado = "";
        }

        if (res.indexOf("%") != -1) {
            resultado = "";
        }

        if (res.indexOf(";") != -1) {
            resultado = "";
        }

        if (res.indexOf("&") != -1) {
            resultado = "";
        }

        if (res.indexOf("&lt;") != -1) {
            resultado = "";
        }

        if (res.indexOf("&#60;") != -1) {
            resultado = "";
        }

        if (res.indexOf("&gt;") != -1) {
            resultado = "";
        }

        if (res.indexOf("&#62;") != -1) {
            resultado = "";
        }

        if (res.indexOf("&amp;") != -1) {
            resultado = "";
        }

        if (res.indexOf("&#38;") != -1) {
            resultado = "";
        }

        if (res.indexOf("&quot;") != -1) {
            resultado = "";
        }

        if (res.indexOf("&#34;") != -1) {
            resultado = "";
        }

        if (res.indexOf("&#39;") != -1) {
            resultado = "";
        }

        if (res.indexOf("&#40;") != -1) {
            resultado = "";
        }

        if (res.indexOf("&#41;") != -1) {
            resultado = "";
        }

        if (res.indexOf("&#35;") != -1) {
            resultado = "";
        }

        if (res.indexOf("&#37;") != -1) {
            resultado = "";
        }

        if (res.indexOf("&#59;") != -1) {
            resultado = "";
        }

        if (res.indexOf("&#43;") != -1) {
            resultado = "";
        }

        if (res.indexOf("&#45;") != -1) {
            resultado = "";
        }

        resultado = res;
        return resultado;
        // }
    }

    /*
     * Este metodo evalua si el parametro viene nulo, si excede el máximo
     * señalado y si posee caracteres XSS. En caso de que se cumpla cualquiera
     * de las 3 alternativas señaladas se devolverá true, en caso de no
     * cumplirse se devuelve false.
     */

    public boolean detectaXSSenString(String pvariableEvaluada) {

        boolean respuesta = false;
        if ("".equals(pvariableEvaluada)) {
            respuesta = false;
        }
        if (null == pvariableEvaluada) {
            respuesta = false;
        }
        if ("".equalsIgnoreCase(this.eliminacionEtiquetasYsimbolosXSS(pvariableEvaluada))) {
            respuesta = true;
        }
        return respuesta;
    }

    public boolean detectaXSSenStringSinValidarNulo(String pvariableEvaluada, int pLargoMaximoSoportado) {
        boolean respuesta = false;

        if (pvariableEvaluada.length() > pLargoMaximoSoportado) {
            respuesta = true;
        }
        if ("".equalsIgnoreCase(this.eliminacionEtiquetasYsimbolosXSS(pvariableEvaluada))) {
            respuesta = true;
        }
        return respuesta;
    }
}
