package com.tmmas.scl.wsventaenlace.transport.vo;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.Hashtable;


public class ParametroGeneralVO implements Serializable {
	
	private static final long serialVersionUID = 1L;
	private String nomParametro;
	private String valParametro;
	private String codModulo;
	private long codProducto;
	private String desParametro;
	private String nomUsuario;
	private Timestamp fecAlta;
	public String getCodModulo() {
		return codModulo;
	}
	public void setCodModulo(String codModulo) {
		this.codModulo = codModulo;
	}
	public long getCodProducto() {
		return codProducto;
	}
	public void setCodProducto(long codProducto) {
		this.codProducto = codProducto;
	}
	public String getDesParametro() {
		return desParametro;
	}
	public void setDesParametro(String desParametro) {
		this.desParametro = desParametro;
	}
	public Timestamp getFecAlta() {
		return fecAlta;
	}
	public void setFecAlta(Timestamp fecAlta) {
		this.fecAlta = fecAlta;
	}
	public String getNomParametro() {
		return nomParametro;
	}
	public void setNomParametro(String nomParametro) {
		this.nomParametro = nomParametro;
	}
	public String getNomUsuario() {
		return nomUsuario;
	}
	public void setNomUsuario(String nomUsuario) {
		this.nomUsuario = nomUsuario;
	}
	public String getValParametro() {
		return valParametro;
	}
	public void setValParametro(String valParametro) {
		this.valParametro = valParametro;
	}
}
