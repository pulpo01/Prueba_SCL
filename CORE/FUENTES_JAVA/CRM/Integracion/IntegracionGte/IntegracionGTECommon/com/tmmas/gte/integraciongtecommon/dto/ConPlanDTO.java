package com.tmmas.gte.integraciongtecommon.dto;

import java.io.Serializable;

public class ConPlanDTO implements Serializable  {
    /**
	 * Autor : Juan Muñoz Queupul
	 */
	private static final long serialVersionUID = 1L;
    private long numeroTelefono;
    private AuditoriaDTO auditoria;
    
	public AuditoriaDTO getAuditoria() {
		return auditoria;
	}
	public void setAuditoria(AuditoriaDTO auditoria) {
		this.auditoria = auditoria;
	}
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}
	public long getNumeroTelefono() {
		return numeroTelefono;
	}
	public void setNumeroTelefono(long numeroTelefono) {
		this.numeroTelefono = numeroTelefono;
	}
    
	
}