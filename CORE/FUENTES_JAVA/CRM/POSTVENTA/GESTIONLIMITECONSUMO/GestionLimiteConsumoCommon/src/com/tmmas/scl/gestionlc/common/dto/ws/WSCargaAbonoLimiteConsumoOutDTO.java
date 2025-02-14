package com.tmmas.scl.gestionlc.common.dto.ws;

import java.io.Serializable;

/**
 * 
 * Parametros de salida del WS 
 *
 */
public class WSCargaAbonoLimiteConsumoOutDTO implements Serializable {

    private static final long serialVersionUID = 1L;
    private WSAbonadoALCDTO wsAbonadoALCDTO;
    private WSLimiteConsumoALCDTO wsLimiteConsumoALCDTO;
    private int iEvento;
    private String strCodError;
    private String strDesError;
    /**
     * @return the wsAbonadoALCDTO
     */
    public WSAbonadoALCDTO getWsAbonadoALCDTO() {
        return wsAbonadoALCDTO;
    }
    /**
     * @param wsAbonadoALCDTO the pWSAbonadoALCDTO to set
     */
    public void setWsAbonadoALCDTO(WSAbonadoALCDTO pWSAbonadoALCDTO) {
        this.wsAbonadoALCDTO = pWSAbonadoALCDTO;
    }
    /**
     * @return the wsLimiteConsumoALCDTO
     */
    public WSLimiteConsumoALCDTO getWsLimiteConsumoALCDTO() {
        return wsLimiteConsumoALCDTO;
    }
    /**
     * @param wsLimiteConsumoALCDTO the pWSLimiteConsumoALCDTO to set
     */
    public void setWsLimiteConsumoALCDTO(WSLimiteConsumoALCDTO pWSLimiteConsumoALCDTO) {
        this.wsLimiteConsumoALCDTO = pWSLimiteConsumoALCDTO;
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
