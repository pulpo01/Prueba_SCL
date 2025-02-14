package com.tmmas.scl.gestionlc.common.dto;

import java.io.Serializable;

public class CuotaDTO implements Serializable {

    private static final long serialVersionUID = 3980487018909203664L;

    private Short shoCodCuota;
    private String strDesCuota;

    /**
     * @return the shoCodCuota
     */
    public Short getShoCodCuota() {
        return shoCodCuota;
    }

    /**
     * @param shoCodCuota
     *            the shoCodCuota to set
     */
    public void setShoCodCuota(Short shoCodCuota) {
        this.shoCodCuota = shoCodCuota;
    }

    /**
     * @return the strDesCuota
     */
    public String getStrDesCuota() {
        return strDesCuota;
    }

    /**
     * @param strDesCuota
     *            the strDesCuota to set
     */
    public void setStrDesCuota(String strDesCuota) {
        this.strDesCuota = strDesCuota;
    }

}
