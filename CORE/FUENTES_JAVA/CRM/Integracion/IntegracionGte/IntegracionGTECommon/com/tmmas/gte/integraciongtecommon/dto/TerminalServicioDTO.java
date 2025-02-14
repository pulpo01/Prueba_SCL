package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;

public class TerminalServicioDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private AuditoriaDTO auditoria;
	private long numeroTelefono;
	private String cod_servicio;
	
	public String getCod_servicio() {
		return cod_servicio;
	}
	public void setCod_servicio(String cod_servicio) {
		this.cod_servicio = cod_servicio;
	}
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}
	public AuditoriaDTO getAuditoria() {
		return auditoria;
	}
	public void setAuditoria(AuditoriaDTO auditoria) {
		this.auditoria = auditoria;
	}
	public long getNumeroTelefono() {
		return numeroTelefono;
	}
	public void setNumeroTelefono(long numeroTelefono) {
		this.numeroTelefono = numeroTelefono;
	}

}
