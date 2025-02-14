package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;



public class BancoDispInDTO implements Serializable {
	/*
	 * Autor: Leonardo Muñoz R.
	 * */
	private static final long serialVersionUID = 1L;
	private long indPac;
	private AuditoriaDTO auditoria;
	
	public AuditoriaDTO getAuditoria() {
		return auditoria;
	}
	public void setAuditoria(AuditoriaDTO auditoria) {
		this.auditoria = auditoria;
	}
	public long getIndPac() {
		return indPac;
	}
	public void setIndPac(long indPac) {
		this.indPac = indPac;
	}
	
}
