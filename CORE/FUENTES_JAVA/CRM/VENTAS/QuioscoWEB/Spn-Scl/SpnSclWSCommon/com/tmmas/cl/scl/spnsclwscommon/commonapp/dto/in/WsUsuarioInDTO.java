package com.tmmas.cl.scl.spnsclwscommon.commonapp.dto.in;

import java.io.Serializable;

public class WsUsuarioInDTO implements Serializable{
	

	private static final long serialVersionUID = 1L;
	private  String nombre;
	private  String primerApellido;
	private  String segundoApellido;
	private  String codigoTipident;
	private  String numeroIdent;
	private  String estadoCivil;
	private  String codigoSexo;
	
	
	public String getCodigoSexo() {
		return codigoSexo;
	}
	public void setCodigoSexo(String codigoSexo) {
		this.codigoSexo = codigoSexo;
	}
	public String getCodigoTipident() {
		return codigoTipident;
	}
	public void setCodigoTipident(String codigoTipident) {
		this.codigoTipident = codigoTipident;
	}
	public String getEstadoCivil() {
		return estadoCivil;
	}
	public void setEstadoCivil(String estadoCivil) {
		this.estadoCivil = estadoCivil;
	}
	public String getNombre() {
		return nombre;
	}
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	public String getNumeroIdent() {
		return numeroIdent;
	}
	public void setNumeroIdent(String numeroIdent) {
		this.numeroIdent = numeroIdent;
	}
	public String getPrimerApellido() {
		return primerApellido;
	}
	public void setPrimerApellido(String primerApellido) {
		this.primerApellido = primerApellido;
	}
	public String getSegundoApellido() {
		return segundoApellido;
	}
	public void setSegundoApellido(String segundoApellido) {
		this.segundoApellido = segundoApellido;
	}

}
