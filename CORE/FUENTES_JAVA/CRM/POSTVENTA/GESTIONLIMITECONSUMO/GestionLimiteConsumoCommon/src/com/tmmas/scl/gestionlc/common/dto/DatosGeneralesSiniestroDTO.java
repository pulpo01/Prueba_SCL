package com.tmmas.scl.gestionlc.common.dto;

import java.io.Serializable;

public class DatosGeneralesSiniestroDTO implements Serializable {

    private static final long serialVersionUID = 1L;

    private String strCargoBasCauSinie;
    private String strCargoBasOri;
    private String strCargoBasAnt;

    /**
     * @return the strCargoBasCauSinie
     */
    public String getStrCargoBasCauSinie() {
        return strCargoBasCauSinie;
    }

    /**
     * @param strCargoBasCauSinie
     *            the strCargoBasCauSinie to set
     */
    public void setStrCargoBasCauSinie(String strCargoBasCauSinie) {
        this.strCargoBasCauSinie = strCargoBasCauSinie;
    }

    /**
     * @return the strCargoBasOri
     */
    public String getStrCargoBasOri() {
        return strCargoBasOri;
    }

    /**
     * @param strCargoBasOri
     *            the strCargoBasOri to set
     */
    public void setStrCargoBasOri(String strCargoBasOri) {
        this.strCargoBasOri = strCargoBasOri;
    }

    /**
     * @return the strCargoBasAnt
     */
    public String getStrCargoBasAnt() {
        return strCargoBasAnt;
    }

    /**
     * @param strCargoBasAnt
     *            the strCargoBasAnt to set
     */
    public void setStrCargoBasAnt(String strCargoBasAnt) {
        this.strCargoBasAnt = strCargoBasAnt;
    }

}
