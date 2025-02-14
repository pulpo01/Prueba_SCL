package com.tmmas.scl.operations.crm.f.s.manpro.frmk.dataTransferObject;

import java.io.Serializable;

public class RespuestaValidacionNumeroDTO implements Serializable {
	
	private static final long serialVersionUID = 1L;
	private long numero;
	private String tipo;
	private String mensaje;
	private String codTipo;
	public String getMensaje() {
		return mensaje;
	}
	public void setMensaje(String mensaje) {
		this.mensaje = mensaje;
	}
	public long getNumero() {
		return numero;
	}
	public void setNumero(long numero) {
		this.numero = numero;
	}
	public String getTipo() {
		return tipo;
	}
	public void setTipo(String tipo) {
		this.tipo = tipo;
	}
	public String getCodTipo() {
		return codTipo;
	}
	public void setCodTipo(String codTipo) {
		this.codTipo = codTipo;
	}

}
