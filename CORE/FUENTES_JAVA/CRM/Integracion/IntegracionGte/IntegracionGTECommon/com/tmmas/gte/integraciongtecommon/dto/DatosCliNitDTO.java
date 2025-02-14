package com.tmmas.gte.integraciongtecommon.dto;

import java.io.Serializable;

public class DatosCliNitDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	private String numIdem; 
	private String codTipIdent;
	private long codCiclo;
	private RespuestaDTO respuesta;
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}
	public long getCodCiclo() {
		return codCiclo;
	}
	public void setCodCiclo(long codCiclo) {
		this.codCiclo = codCiclo;
	}
	public String getCodTipIdent() {
		return codTipIdent;
	}
	public void setCodTipIdent(String codTipIdent) {
		this.codTipIdent = codTipIdent;
	}
	public String getNumIdem() {
		return numIdem;
	}
	public void setNumIdem(String numIdem) {
		this.numIdem = numIdem;
	}
	public RespuestaDTO getRespuesta() {
		return respuesta;
	}
	public void setRespuesta(RespuestaDTO respuesta) {
		this.respuesta = respuesta;
	}
		
	
	
}
