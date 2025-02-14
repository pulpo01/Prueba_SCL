package com.tmmas.cl.scl.commonapp.dto;

import java.io.Serializable;

public class WsUsuarioInDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	
	private String tipIdentificacion;
	private String numeroIdentificacion;
	private String nombre;
	private String primerApellido;
	private String segundoApellido;
	private String codDireccion;
	private String nomEmpresa;
	private String ocupacion;
	private String ingresosBrutosAnuales;
	
	
	public String getIngresosBrutosAnuales() {
		return ingresosBrutosAnuales;
	}
	public void setIngresosBrutosAnuales(String ingresosBrutosAnuales) {
		this.ingresosBrutosAnuales = ingresosBrutosAnuales;
	}
	public String getCodDireccion() {
		return codDireccion;
	}
	public void setCodDireccion(String codDireccion) {
		this.codDireccion = codDireccion;
	}
	public String getNombre() {
		return nombre;
	}
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	public String getNomEmpresa() {
		return nomEmpresa;
	}
	public void setNomEmpresa(String nomEmpresa) {
		this.nomEmpresa = nomEmpresa;
	}
	public String getNumeroIdentificacion() {
		return numeroIdentificacion;
	}
	public void setNumeroIdentificacion(String numeroIdentificacion) {
		this.numeroIdentificacion = numeroIdentificacion;
	}
	public String getOcupacion() {
		return ocupacion;
	}
	public void setOcupacion(String ocupacion) {
		this.ocupacion = ocupacion;
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
	public String getTipIdentificacion() {
		return tipIdentificacion;
	}
	public void setTipIdentificacion(String tipIdentificacion) {
		this.tipIdentificacion = tipIdentificacion;
	}


}
