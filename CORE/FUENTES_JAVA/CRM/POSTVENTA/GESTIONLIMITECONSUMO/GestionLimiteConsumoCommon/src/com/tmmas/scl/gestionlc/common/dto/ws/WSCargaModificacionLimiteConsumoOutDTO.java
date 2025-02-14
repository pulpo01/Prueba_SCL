package com.tmmas.scl.gestionlc.common.dto.ws;

import java.io.Serializable;

public class WSCargaModificacionLimiteConsumoOutDTO implements Serializable {

    private static final long serialVersionUID = 1L;
    private WSAbonadoMLCDTO wsAbonadoDTO;
    private WSLimiteConsumoMLCDTO wsLimiteConsumoDTO;
    private WSSegmentacionMLCDTO wsSegmentacionDTO;
    private int iEvento;
    private String strCodError;
    private String strDesError;

    /**
     * @return the wsAbonadoDTO
     */
    public WSAbonadoMLCDTO getWsAbonadoDTO() {
        return wsAbonadoDTO;
    }
    /**
     * @param wsAbonadoDTO the pWSAbonadoDTO to set
     */
    public void setWsAbonadoDTO(WSAbonadoMLCDTO pWSAbonadoDTO) {
        this.wsAbonadoDTO = pWSAbonadoDTO;
    }
    /**
     * @return the wsLimiteConsumoDTO
     */
    public WSLimiteConsumoMLCDTO getWsLimiteConsumoDTO() {
        return wsLimiteConsumoDTO;
    }
    /**
     * @param wsLimiteConsumoDTO the pWSLimiteConsumoDTO to set
     */
    public void setWsLimiteConsumoDTO(WSLimiteConsumoMLCDTO pWSLimiteConsumoDTO) {
        this.wsLimiteConsumoDTO = pWSLimiteConsumoDTO;
    }
    /**
     * @return the wsSegmentacionDTO
     */
    public WSSegmentacionMLCDTO getWsSegmentacionDTO() {
        return wsSegmentacionDTO;
    }
    /**
     * @param wsSegmentacionDTO the pWSSegmentacionDTO to set
     */
    public void setWsSegmentacionDTO(WSSegmentacionMLCDTO pWSSegmentacionDTO) {
        this.wsSegmentacionDTO = pWSSegmentacionDTO;
    }
    /**
     * @return the iEvento
     */
    public int getIEvento() {
        return iEvento;
    }
    /**
     * @param iEvento the pIEvento to set
     */
    public void setIEvento(int pIEvento) {
        this.iEvento = pIEvento;
    }
    /**
     * @return the strCodError
     */
    public String getStrCodError() {
        return strCodError;
    }
    /**
     * @param strCodError the pStrCodError to set
     */
    public void setStrCodError(String pStrCodError) {
        this.strCodError = pStrCodError;
    }
    /**
     * @return the strDesError
     */
    public String getStrDesError() {
        return strDesError;
    }
    /**
     * @param strDesError the pStrDesError to set
     */
    public void setStrDesError(String pStrDesError) {
        this.strDesError = pStrDesError;
    }

}
