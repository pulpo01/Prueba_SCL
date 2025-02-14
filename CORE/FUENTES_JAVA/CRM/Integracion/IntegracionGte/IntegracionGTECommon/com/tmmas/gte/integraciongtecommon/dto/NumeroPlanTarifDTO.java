package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;
/*
 * Autor: Alejandro Lorca
 */

public class NumeroPlanTarifDTO  implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private long numeroTelefono;
	private String desPlanTarifario;
	private AuditoriaDTO auditoria;
	
	public AuditoriaDTO getAuditoria() {
		return auditoria;
	}
	public void setAuditoria(AuditoriaDTO auditoria) {
		this.auditoria = auditoria;
	}
	public String getDesPlanTarifario() {
		return desPlanTarifario;
	}
	public void setDesPlanTarifario(String desPlanTarifario) {
		this.desPlanTarifario = desPlanTarifario;
	}
	public long getNumeroTelefono() {
		return numeroTelefono;
	}
	public void setNumeroTelefono(long numeroTelefono) {
		this.numeroTelefono = numeroTelefono;
	}
	
	

}