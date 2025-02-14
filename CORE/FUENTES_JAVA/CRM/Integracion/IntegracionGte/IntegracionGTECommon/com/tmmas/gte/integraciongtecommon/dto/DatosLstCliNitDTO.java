package com.tmmas.gte.integraciongtecommon.dto;

import java.io.Serializable;

public class DatosLstCliNitDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	private AuditoriaDTO auditoria;
	private String numIdem; 
	private String codTipIdent;
	
	
	
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}
	public AuditoriaDTO getAuditoria() {
		return auditoria;
	}
	public void setAuditoria(AuditoriaDTO auditoria) {
		this.auditoria = auditoria;
	}
	public String getCodTipIdent() {
		return codTipIdent;
	}
	public void setCodTipIdent(String codTipIdent) {
		this.codTipIdent = codTipIdent;
	}
	public String getNumIdem() {
		return numIdem;
	}
	public void setNumIdem(String numIdem) {
		this.numIdem = numIdem;
	}
	
	
}
