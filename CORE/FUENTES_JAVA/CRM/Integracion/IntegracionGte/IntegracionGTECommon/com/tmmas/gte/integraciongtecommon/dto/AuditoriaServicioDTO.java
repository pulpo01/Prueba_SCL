package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;

public class AuditoriaServicioDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	private String nombreUsuario;
	private long codAuditoria;
	private String nomParametro;
	private String valParametro;
	
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}
	public long getCodAuditoria() {
		return codAuditoria;
	}
	public void setCodAuditoria(long codAuditoria) {
		this.codAuditoria = codAuditoria;
	}
	public String getNombreUsuario() {
		return nombreUsuario;
	}
	public void setNombreUsuario(String nombreUsuario) {
		this.nombreUsuario = nombreUsuario;
	}
	public String getNomParametro() {
		return nomParametro;
	}
	public void setNomParametro(String nomParametro) {
		this.nomParametro = nomParametro;
	}
	public String getValParametro() {
		return valParametro;
	}
	public void setValParametro(String valParametro) {
		this.valParametro = valParametro;
	}
	
	
	
	
}
