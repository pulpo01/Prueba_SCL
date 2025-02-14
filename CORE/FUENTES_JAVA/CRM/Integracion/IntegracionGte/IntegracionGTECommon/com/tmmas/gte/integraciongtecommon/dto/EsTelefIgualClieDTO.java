package com.tmmas.gte.integraciongtecommon.dto;

import java.io.Serializable;

public class EsTelefIgualClieDTO implements Serializable {

	/**
	 * Autor: Daniel Jara Oyarzún
	 */
	private static final long serialVersionUID = 1L;
	private AuditoriaDTO auditoria;
	private long num_telefono1;
	private long num_telefono2;
	
	
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}
	public AuditoriaDTO getAuditoria() {
		return auditoria;
	}
	public void setAuditoria(AuditoriaDTO auditoria) {
		this.auditoria = auditoria;
	}
	public long getNum_telefono1() {
		return num_telefono1;
	}
	public void setNum_telefono1(long num_telefono1) {
		this.num_telefono1 = num_telefono1;
	}
	public long getNum_telefono2() {
		return num_telefono2;
	}
	public void setNum_telefono2(long num_telefono2) {
		this.num_telefono2 = num_telefono2;
	}
	
	
}
