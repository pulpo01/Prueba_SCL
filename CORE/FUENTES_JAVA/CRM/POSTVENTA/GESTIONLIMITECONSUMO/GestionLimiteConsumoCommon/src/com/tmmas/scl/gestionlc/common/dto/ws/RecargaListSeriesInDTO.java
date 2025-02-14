package com.tmmas.scl.gestionlc.common.dto.ws;

import java.io.Serializable;

import com.tmmas.scl.gestionlc.common.dto.ConsultaSeriesDTO;

public class RecargaListSeriesInDTO implements Serializable {

    private static final long serialVersionUID = 1L;

    private ConsultaSeriesDTO consultaSeriesDTO;

    private String strNomUsuario;

    private Long lonNumAbonado;

    private Long lonNumSiniestro;

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
     * @return the consultaSeriesDTO
     */
    public ConsultaSeriesDTO getConsultaSeriesDTO() {
        return consultaSeriesDTO;
    }

    /**
     * @param consultaSeriesDTO
     *            the consultaSeriesDTO to set
     */
    public void setConsultaSeriesDTO(ConsultaSeriesDTO consultaSeriesDTO) {
        this.consultaSeriesDTO = consultaSeriesDTO;
    }

    /**
     * @return the lonNumAbonado
     */
    public Long getLonNumAbonado() {
        return lonNumAbonado;
    }

    /**
     * @param lonNumAbonado
     *            the lonNumAbonado to set
     */
    public void setLonNumAbonado(Long lonNumAbonado) {
        this.lonNumAbonado = lonNumAbonado;
    }

    /**
     * @return the lonNumSiniestro
     */
    public Long getLonNumSiniestro() {
        return lonNumSiniestro;
    }

    /**
     * @param lonNumSiniestro
     *            the lonNumSiniestro to set
     */
    public void setLonNumSiniestro(Long lonNumSiniestro) {
        this.lonNumSiniestro = lonNumSiniestro;
    }

}
