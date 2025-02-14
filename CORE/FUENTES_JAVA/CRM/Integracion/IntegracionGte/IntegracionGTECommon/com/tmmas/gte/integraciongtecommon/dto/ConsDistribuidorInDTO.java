package com.tmmas.gte.integraciongtecommon.dto;

import java.io.Serializable;

public class ConsDistribuidorInDTO implements Serializable  {
    /**
	 * Autor : Alejandro Lorca
	 */
	private static final long serialVersionUID = 1L;

    private long codDistribuidor;
    private AuditoriaDTO auditoria;

	public AuditoriaDTO getAuditoria() {
		return auditoria;
	}

	public void setAuditoria(AuditoriaDTO auditoria) {
		this.auditoria = auditoria;
	}

	public long getCodDistribuidor() {
		return codDistribuidor;
	}

	public void setCodDistribuidor(long codDistribuidor) {
		this.codDistribuidor = codDistribuidor;
	}

}