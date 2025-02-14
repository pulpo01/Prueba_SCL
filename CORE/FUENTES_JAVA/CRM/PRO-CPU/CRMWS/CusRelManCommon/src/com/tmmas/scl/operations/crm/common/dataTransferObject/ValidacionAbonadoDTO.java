package com.tmmas.scl.operations.crm.common.dataTransferObject;

import java.io.Serializable;

public class ValidacionAbonadoDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private String abonado;
	private String usuarioSCL;
	private String canal;
	private String codigoOOSS;
	
	public String getAbonado() {
		return abonado;
	}
	public void setAbonado(String abonado) {
		this.abonado = abonado;
	}
	public String getUsuarioSCL() {
		return usuarioSCL;
	}
	public void setUsuarioSCL(String usuarioSCL) {
		this.usuarioSCL = usuarioSCL;
	}
	public String getCanal() {
		return canal;
	}
	public void setCanal(String canal) {
		this.canal = canal;
	}
	public String getCodigoOOSS() {
		return codigoOOSS;
	}
	public void setCodigoOOSS(String codigoOOSS) {
		this.codigoOOSS = codigoOOSS;
	}
	
}
