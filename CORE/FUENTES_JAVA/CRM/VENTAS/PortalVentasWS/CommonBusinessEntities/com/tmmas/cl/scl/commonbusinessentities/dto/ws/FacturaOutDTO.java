package com.tmmas.cl.scl.commonbusinessentities.dto.ws;

import java.io.Serializable;

public class FacturaOutDTO implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private String nombrePDF;
	private String rutaPDF;
	
	private Long codError;
	private String msgError;
	private Long codEvento;
	
	public Long getCodError() {
		return codError;
	}
	public void setCodError(Long codError) {
		this.codError = codError;
	}
	public String getNombrePDF() {
		return nombrePDF;
	}
	public void setNombrePDF(String nombrePDF) {
		this.nombrePDF = nombrePDF;
	}
	public String getRutaPDF() {
		return rutaPDF;
	}
	public void setRutaPDF(String rutaPDF) {
		this.rutaPDF = rutaPDF;
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


}
