package com.tmmas.gte.integraciongtecommon.dto;

import java.io.Serializable;

public class DistribPedidoInDTO implements Serializable  {
    /**
	 * Autor : Alejandro Lorca
	 */
	private static final long serialVersionUID = 1L;

    private long codDistribuidor;
    private long codPedido;
    private AuditoriaDTO auditoria;
    
	public long getCodPedido() {
		return codPedido;
	}

	public void setCodPedido(long codPedido) {
		this.codPedido = codPedido;
	}

	public long getCodDistribuidor() {
		return codDistribuidor;
	}

	public void setCodDistribuidor(long codDistribuidor) {
		this.codDistribuidor = codDistribuidor;
	}

	public AuditoriaDTO getAuditoria() {
		return auditoria;
	}

	public void setAuditoria(AuditoriaDTO auditoria) {
		this.auditoria = auditoria;
	}

}