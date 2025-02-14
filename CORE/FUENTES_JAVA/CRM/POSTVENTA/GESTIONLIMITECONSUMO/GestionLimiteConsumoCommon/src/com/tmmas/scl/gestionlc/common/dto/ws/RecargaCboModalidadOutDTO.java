package com.tmmas.scl.gestionlc.common.dto.ws;

import java.io.Serializable;

import com.tmmas.scl.gestionlc.common.dto.ModalidadDTO;
import com.tmmas.scl.gestionlc.common.dto.common.GestionLimiteConsumoOutDTO;

public class RecargaCboModalidadOutDTO extends GestionLimiteConsumoOutDTO implements Serializable {

    private static final long serialVersionUID = 1L;

    private ModalidadDTO[] modalidadDTOs;

    /**
     * @return the modalidadDTOs
     */
    public ModalidadDTO[] getModalidadDTOs() {
        return modalidadDTOs;
    }

    /**
     * @param modalidadDTOs
     *            the modalidadDTOs to set
     */
    public void setModalidadDTOs(ModalidadDTO[] modalidadDTOs) {
        this.modalidadDTOs = modalidadDTOs;
    }

}
