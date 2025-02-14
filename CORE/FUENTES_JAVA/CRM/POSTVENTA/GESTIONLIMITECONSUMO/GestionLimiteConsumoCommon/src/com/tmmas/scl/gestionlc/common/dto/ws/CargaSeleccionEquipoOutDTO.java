package com.tmmas.scl.gestionlc.common.dto.ws;

import java.io.Serializable;

import com.tmmas.scl.gestionlc.common.dto.ArticuloDTO;
import com.tmmas.scl.gestionlc.common.dto.BodegaDTO;
import com.tmmas.scl.gestionlc.common.dto.EstadoDTO;
import com.tmmas.scl.gestionlc.common.dto.UsoDTO;
import com.tmmas.scl.gestionlc.common.dto.common.GestionLimiteConsumoOutDTO;

public class CargaSeleccionEquipoOutDTO extends GestionLimiteConsumoOutDTO implements Serializable {

    private static final long serialVersionUID = 1L;

    private BodegaDTO[] bodegaDTOs;

    private UsoDTO[] usoDTOs;

    private EstadoDTO[] estadoDTOs;

    private ArticuloDTO[] articuloDTOs;

    /**
     * @return the bodegaDTOs
     */
    public BodegaDTO[] getBodegaDTOs() {
        return bodegaDTOs;
    }

    /**
     * @param bodegaDTOs
     *            the bodegaDTOs to set
     */
    public void setBodegaDTOs(BodegaDTO[] bodegaDTOs) {
        this.bodegaDTOs = bodegaDTOs;
    }

    /**
     * @return the usoDTOs
     */
    public UsoDTO[] getUsoDTOs() {
        return usoDTOs;
    }

    /**
     * @param usoDTOs
     *            the usoDTOs to set
     */
    public void setUsoDTOs(UsoDTO[] usoDTOs) {
        this.usoDTOs = usoDTOs;
    }

    /**
     * @return the estadoDTOs
     */
    public EstadoDTO[] getEstadoDTOs() {
        return estadoDTOs;
    }

    /**
     * @param estadoDTOs
     *            the estadoDTOs to set
     */
    public void setEstadoDTOs(EstadoDTO[] estadoDTOs) {
        this.estadoDTOs = estadoDTOs;
    }

    /**
     * @return the articuloDTOs
     */
    public ArticuloDTO[] getArticuloDTOs() {
        return articuloDTOs;
    }

    /**
     * @param articuloDTOs
     *            the articuloDTOs to set
     */
    public void setArticuloDTOs(ArticuloDTO[] articuloDTOs) {
        this.articuloDTOs = articuloDTOs;
    }

}
