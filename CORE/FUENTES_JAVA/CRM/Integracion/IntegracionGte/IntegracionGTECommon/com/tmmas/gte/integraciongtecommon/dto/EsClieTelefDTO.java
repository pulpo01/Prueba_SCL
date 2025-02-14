package com.tmmas.gte.integraciongtecommon.dto;

import java.io.Serializable;

public class EsClieTelefDTO implements Serializable {
	/**
	 * Autor: Daniel Jara Oyarzún
	 */
	private static final long serialVersionUID = 1L;
	private AuditoriaDTO auditoria;
	private long numeroTelefono;
	private long codCliente;
	
	
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}
	public AuditoriaDTO getAuditoria() {
		return auditoria;
	}
	public void setAuditoria(AuditoriaDTO auditoria) {
		this.auditoria = auditoria;
	}
	public long getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(long codCliente) {
		this.codCliente = codCliente;
	}
	public long getNumeroTelefono() {
		return numeroTelefono;
	}
	public void setNumeroTelefono(long numeroTelefono) {
		this.numeroTelefono = numeroTelefono;
	}
	
		
		
}
