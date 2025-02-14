package com.tmmas.scl.gestionlc.common.validation.exception;

/**
 * 
 * Se ejecuta cuando se quiere validar el largo minimo de un campo y este posee
 * un largo inferior al minimo
 * 
 */
public class LargoInferiorAlMinimoException extends RuntimeException {

    /**
     * 
     */
    private static final long serialVersionUID = -1875895141724437646L;

    public LargoInferiorAlMinimoException() {
        super();

    }

}
