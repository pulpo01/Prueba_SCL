package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;

public class LlamadaClienteDTO  implements Serializable {
	/*
	 * Autor: Juan Daniel Muñoz Queupul
	 * */
	
	private static final long serialVersionUID = 1L;
    private long 	numTelefono;
	private long 	numFolio;
	private String 	campoOrden;
	private String 	tipoOrden;
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
	public String getCampoOrden() {
		return campoOrden;
	}
	public void setCampoOrden(String campoOrden) {
		this.campoOrden = campoOrden;
	}
	public long getNumFolio() {
		return numFolio;
	}
	public void setNumFolio(long numFolio) {
		this.numFolio = numFolio;
	}
	public long getNumTelefono() {
		return numTelefono;
	}
	public void setNumTelefono(long numTelefono) {
		this.numTelefono = numTelefono;
	}
	public String getTipoOrden() {
		return tipoOrden;
	}
	public void setTipoOrden(String tipoOrden) {
		this.tipoOrden = tipoOrden;
	}

}