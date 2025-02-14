package com.tmmas.gte.integraciongtecommon.dto;

import java.io.Serializable;

public class DatosLstCliCliDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private AuditoriaDTO auditoria;
	private long codCliente;

	
	public AuditoriaDTO getAuditoria() {
		return auditoria;
	}

	public void setAuditoria(AuditoriaDTO auditoria) {
		this.auditoria = auditoria;
	}

	public static long getSerialVersionUID() {
		return serialVersionUID;
	}

	public long getCodCliente() {
		return codCliente;
	}

	public void setCodCliente(long codCliente) {
		this.codCliente = codCliente;
	} 
	
}
