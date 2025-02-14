package com.tmmas.gte.integraciongtecommon.dto;

import java.io.Serializable;

public class DatosLstCliCueDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	private AuditoriaDTO auditoria;
	private long codCuenta;
	
	
	
	public AuditoriaDTO getAuditoria() {
		return auditoria;
	}
	public void setAuditoria(AuditoriaDTO auditoria) {
		this.auditoria = auditoria;
	}
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}
	public long getCodCuenta() {
		return codCuenta;
	}
	public void setCodCuenta(long codCuenta) {
		this.codCuenta = codCuenta;
	}
	
	
	
	

}
