package com.tmmas.scl.gestionlc.common.dto.ws;

import java.io.Serializable;

import com.tmmas.scl.gestionlc.common.dto.SerieDTO;
import com.tmmas.scl.gestionlc.common.dto.common.GestionLimiteConsumoOutDTO;

public class RecargaListSeriesOutDTO extends GestionLimiteConsumoOutDTO implements Serializable {

    private static final long serialVersionUID = 1L;

    private SerieDTO[] serieDTOs;

    /**
     * @return the serieDTOs
     */
    public SerieDTO[] getSerieDTOs() {
        return serieDTOs;
    }

    /**
     * @param serieDTOs
     *            the serieDTOs to set
     */
    public void setSerieDTOs(SerieDTO[] serieDTOs) {
        this.serieDTOs = serieDTOs;
    }

}
