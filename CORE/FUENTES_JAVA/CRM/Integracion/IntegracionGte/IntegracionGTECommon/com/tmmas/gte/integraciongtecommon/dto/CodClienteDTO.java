package com.tmmas.gte.integraciongtecommon.dto;

import java.io.Serializable;

public class CodClienteDTO implements Serializable  {
    /**
	 * Autor : Alejandro Lorca
	 */
	private static final long serialVersionUID = 1L;

	private AuditoriaDTO auditoria;
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
    

}