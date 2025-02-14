package com.tmmas.cl.scl.commonbusinessentities.dto.ws;

import java.io.Serializable;

public class DatCteClienteListOutDTO implements Serializable {
	private static final long serialVersionUID = 1L;

	
	private DatCteClienteOutDTO allDatCteClienteOutDTO[];
	
	private Long codError;
	private String msgError;
	private Long codEvento;
	
	public DatCteClienteListOutDTO() {
	}
	
	public DatCteClienteOutDTO[] getallDatCteClienteOutDTO() {
		return allDatCteClienteOutDTO;
	}

	public void setallDatCteClienteOutDTO(DatCteClienteOutDTO iAllDatCteClienteOutDTO[]) {
		this.allDatCteClienteOutDTO = iAllDatCteClienteOutDTO;
	}
	
	
	public Long getCodError() {
		return codError;
	}
	public void setCodError(Long codError) {
		this.codError = codError;
	}
	public Long getCodEvento() {
		return codEvento;
	}
	public void setCodEvento(Long codEvento) {
		this.codEvento = codEvento;
	}
	public String getMsgError() {
		return msgError;
	}
	public void setMsgError(String msgError) {
		this.msgError = msgError;
	}
	
	
}//fin class DatCteClienteOutDTO


