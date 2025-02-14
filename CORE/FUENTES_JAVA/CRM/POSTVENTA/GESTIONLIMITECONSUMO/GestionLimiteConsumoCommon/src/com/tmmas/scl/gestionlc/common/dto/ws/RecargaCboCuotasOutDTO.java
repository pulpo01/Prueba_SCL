package com.tmmas.scl.gestionlc.common.dto.ws;

import java.io.Serializable;

import com.tmmas.scl.gestionlc.common.dto.CuotaDTO;
import com.tmmas.scl.gestionlc.common.dto.common.GestionLimiteConsumoOutDTO;

public class RecargaCboCuotasOutDTO extends GestionLimiteConsumoOutDTO implements Serializable {

    private static final long serialVersionUID = 1L;

    private CuotaDTO[] cuotaDTOs;

    /**
     * @return the cuotaDTOs
     */
    public CuotaDTO[] getCuotaDTOs() {
        return cuotaDTOs;
    }

    /**
     * @param cuotaDTOs
     *            the cuotaDTOs to set
     */
    public void setCuotaDTOs(CuotaDTO[] cuotaDTOs) {
        this.cuotaDTOs = cuotaDTOs;
    }

}
