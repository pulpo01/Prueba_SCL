package com.tmmas.scl.gestionlc.common.dto.ws;

import java.io.Serializable;

import com.tmmas.scl.gestionlc.common.dto.CatTributariaDTO;
import com.tmmas.scl.gestionlc.common.dto.ContratoDTO;
import com.tmmas.scl.gestionlc.common.dto.EquipoAntiguoDTO;
import com.tmmas.scl.gestionlc.common.dto.ProrrogaDTO;
import com.tmmas.scl.gestionlc.common.dto.common.GestionLimiteConsumoOutDTO;

public class CargaRestitucionEquipoOutDTO extends GestionLimiteConsumoOutDTO implements Serializable {

    private static final long serialVersionUID = 1L;

    private Long lonNumCelular;
    private String strNomUsuario;
    private EquipoAntiguoDTO equipoAntiguoDTO;
    private ContratoDTO[] contratoDTOs;
    private ProrrogaDTO[] prorrogaDTOs;
    private CatTributariaDTO[] catTributariaDTOs;
    private String strFolioContrato;
    private String strDespIngContrato;

    /**
     * @return the lonNumCelular
     */
    public Long getLonNumCelular() {
        return lonNumCelular;
    }

    /**
     * @param lonNumCelular
     *            the lonNumCelular to set
     */
    public void setLonNumCelular(Long lonNumCelular) {
        this.lonNumCelular = lonNumCelular;
    }

    /**
     * @return the strNomUsuario
     */
    public String getStrNomUsuario() {
        return strNomUsuario;
    }

    /**
     * @param strNomUsuario
     *            the strNomUsuario to set
     */
    public void setStrNomUsuario(String strNomUsuario) {
        this.strNomUsuario = strNomUsuario;
    }

    /**
     * @return the equipoAntiguoDTO
     */
    public EquipoAntiguoDTO getEquipoAntiguoDTO() {
        return equipoAntiguoDTO;
    }

    /**
     * @param equipoAntiguoDTO
     *            the equipoAntiguoDTO to set
     */
    public void setEquipoAntiguoDTO(EquipoAntiguoDTO equipoAntiguoDTO) {
        this.equipoAntiguoDTO = equipoAntiguoDTO;
    }

    /**
     * @return the contratoDTOs
     */
    public ContratoDTO[] getContratoDTOs() {
        return contratoDTOs;
    }

    /**
     * @param contratoDTOs
     *            the contratoDTOs to set
     */
    public void setContratoDTOs(ContratoDTO[] contratoDTOs) {
        this.contratoDTOs = contratoDTOs;
    }

    /**
     * @return the prorrogaDTOs
     */
    public ProrrogaDTO[] getProrrogaDTOs() {
        return prorrogaDTOs;
    }

    /**
     * @param prorrogaDTOs
     *            the prorrogaDTOs to set
     */
    public void setProrrogaDTOs(ProrrogaDTO[] prorrogaDTOs) {
        this.prorrogaDTOs = prorrogaDTOs;
    }

    /**
     * @return the catTributariaDTOs
     */
    public CatTributariaDTO[] getCatTributariaDTOs() {
        return catTributariaDTOs;
    }

    /**
     * @param catTributariaDTOs
     *            the catTributariaDTOs to set
     */
    public void setCatTributariaDTOs(CatTributariaDTO[] catTributariaDTOs) {
        this.catTributariaDTOs = catTributariaDTOs;
    }

    /**
     * @return the strFolioContrato
     */
    public String getStrFolioContrato() {
        return strFolioContrato;
    }

    /**
     * @param strFolioContrato
     *            the strFolioContrato to set
     */
    public void setStrFolioContrato(String strFolioContrato) {
        this.strFolioContrato = strFolioContrato;
    }

    /**
     * @return the strDespIngContrato
     */
    public String getStrDespIngContrato() {
        return strDespIngContrato;
    }

    /**
     * @param strDespIngContrato
     *            the strDespIngContrato to set
     */
    public void setStrDespIngContrato(String strDespIngContrato) {
        this.strDespIngContrato = strDespIngContrato;
    }

}
