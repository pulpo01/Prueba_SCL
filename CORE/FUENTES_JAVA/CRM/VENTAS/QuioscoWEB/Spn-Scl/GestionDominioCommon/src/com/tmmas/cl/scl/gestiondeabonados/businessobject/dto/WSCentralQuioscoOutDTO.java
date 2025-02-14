package com.tmmas.cl.scl.gestiondeabonados.businessobject.dto;

import java.io.Serializable;

import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.CentralDTO;

public class WSCentralQuioscoOutDTO implements Serializable {

	private static final long serialVersionUID = 1L;

    private String codError;
    private String msgError;
    private String numEvento;
    private CentralDTO[] centralDTOs;


	public CentralDTO[] getCentralDTOs() {
		return centralDTOs;
	}
	public void setCentralDTOs(CentralDTO[] centralDTOs) {
		this.centralDTOs = centralDTOs;
	}
	public String getCodError() {
		return codError;
	}
	public void setCodError(String codError) {
		this.codError = codError;
	}
	public String getMsgError() {
		return msgError;
	}
	public void setMsgError(String msgError) {
		this.msgError = msgError;
	}
	public String getNumEvento() {
		return numEvento;
	}
	public void setNumEvento(String numEvento) {
		this.numEvento = numEvento;
	}
}
