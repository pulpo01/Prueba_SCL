package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;

public class ConsConsumoInDTO  implements Serializable {
	/*
	 * Autor: Juan Daniel Muñoz Queupul
	 * */
	
	private static final long serialVersionUID = 1L;
	private long numeroTelefonico;   
	private String fecDesde; /*formato : DD-MM-YYYY*/  
	private String fecHasta; /*formato : DD-MM-YYYY*/  
	private AuditoriaDTO auditoria;
    
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}

	public String getFecDesde() {
		return fecDesde;
	}

	public void setFecDesde(String fecDesde) {
		this.fecDesde = fecDesde;
	}

	public String getFecHasta() {
		return fecHasta;
	}

	public void setFecHasta(String fecHasta) {
		this.fecHasta = fecHasta;
	}

	public long getNumeroTelefonico() {
		return numeroTelefonico;
	}

	public void setNumeroTelefonico(long numeroTelefonico) {
		this.numeroTelefonico = numeroTelefonico;
	}

	public AuditoriaDTO getAuditoria() {
		return auditoria;
	}

	public void setAuditoria(AuditoriaDTO auditoria) {
		this.auditoria = auditoria;
	}




}