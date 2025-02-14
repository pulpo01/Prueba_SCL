package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;

public class ConsLinkFacturaDTO implements Serializable{
	private static final long serialVersionUID = 1L;
	private long numProceso;
	private long codCliente;
	private AuditoriaDTO auditoria;
	
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
	public long getNumProceso() {
		return numProceso;
	}
	public void setNumProceso(long numProceso) {
		this.numProceso = numProceso;
	}
	
}
