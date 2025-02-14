package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;

public class MinutosLdiInDTO  implements Serializable {
	
	
	private static final long serialVersionUID = 1L;
	private long numeroTelefono;   
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

	public long getNumeroTelefono() {
		return numeroTelefono;
	}

	public void setNumeroTelefono(long numeroTelefono) {
		this.numeroTelefono = numeroTelefono;
	}

	public AuditoriaDTO getAuditoria() {
		return auditoria;
	}

	public void setAuditoria(AuditoriaDTO auditoria) {
		this.auditoria = auditoria;
	}




}