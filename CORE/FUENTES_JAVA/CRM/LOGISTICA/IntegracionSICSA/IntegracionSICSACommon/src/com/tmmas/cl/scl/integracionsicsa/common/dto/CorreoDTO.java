package com.tmmas.cl.scl.integracionsicsa.common.dto;

import java.io.Serializable;

public class CorreoDTO implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String codGrupo;
	private String mail;
	private String usuario;
	
	public String getCodGrupo() {
		return codGrupo;
	}
	public void setCodGrupo(String codGrupo) {
		this.codGrupo = codGrupo;
	}
	public String getMail() {
		return mail;
	}
	public void setMail(String mail) {
		this.mail = mail;
	}
	public String getUsuario() {
		return usuario;
	}
	public void setUsuario(String usuario) {
		this.usuario = usuario;
	}
	
	
}
