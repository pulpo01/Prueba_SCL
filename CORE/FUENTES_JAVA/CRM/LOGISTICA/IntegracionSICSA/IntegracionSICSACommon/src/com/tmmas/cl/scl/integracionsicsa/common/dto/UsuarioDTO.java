package com.tmmas.cl.scl.integracionsicsa.common.dto;

import java.io.Serializable;

public class UsuarioDTO implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private String codUsuario;
	private String nomUsuario; 
	private String appUsuario;
	private String uidUsuario; 
	private String emailUsuario;
	
	public String getNomUsuario() {
		return nomUsuario;
	}
	public void setNomUsuario(String nomUsuario) {
		this.nomUsuario = nomUsuario;
	}
	public String getAppUsuario() {
		return appUsuario;
	}
	public void setAppUsuario(String appUsuario) {
		this.appUsuario = appUsuario;
	}
	public String getUidUsuario() {
		return uidUsuario;
	}
	public void setUidUsuario(String uidUsuario) {
		this.uidUsuario = uidUsuario;
	}
	public String getEmailUsuario() {
		return emailUsuario;
	}
	public void setEmailUsuario(String emailUsuario) {
		this.emailUsuario = emailUsuario;
	}
	public String getCodUsuario() {
		return codUsuario;
	}
	public void setCodUsuario(String codUsuario) {
		this.codUsuario = codUsuario;
	}
}
