package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;

public class DistribuidorInDTO implements Serializable {
	private static final long serialVersionUID = 1L;
    private long   codVendedor;    
    private String fechaDesde;
    private String fechaHasta;
    private AuditoriaDTO auditoria;
    
	
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}

	public AuditoriaDTO getAuditoria() {
		return auditoria;
	}

	public void setAuditoria(AuditoriaDTO auditoria) {
		this.auditoria = auditoria;
	}

	public long getCodVendedor() {
		return codVendedor;
	}

	public void setCodVendedor(long codVendedor) {
		this.codVendedor = codVendedor;
	}

	public String getFechaDesde() {
		return fechaDesde;
	}

	public void setFechaDesde(String fechaDesde) {
		this.fechaDesde = fechaDesde;
	}

	public String getFechaHasta() {
		return fechaHasta;
	}

	public void setFechaHasta(String fechaHasta) {
		this.fechaHasta = fechaHasta;
	}





}
