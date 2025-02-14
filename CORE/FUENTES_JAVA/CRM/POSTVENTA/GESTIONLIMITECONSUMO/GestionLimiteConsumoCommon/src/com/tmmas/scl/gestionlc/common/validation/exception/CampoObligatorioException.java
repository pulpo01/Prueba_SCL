package com.tmmas.scl.gestionlc.common.validation.exception;

/**
 * 
 * Se ejecuta cuando se quiere validar que un campo es obligatorio y el valor es
 * nulo o vacio
 * 
 */
public class CampoObligatorioException extends RuntimeException {

    /**
     * 
     */
    private static final long serialVersionUID = 3192779408255985571L;

    public CampoObligatorioException() {
        super();

    }

}
