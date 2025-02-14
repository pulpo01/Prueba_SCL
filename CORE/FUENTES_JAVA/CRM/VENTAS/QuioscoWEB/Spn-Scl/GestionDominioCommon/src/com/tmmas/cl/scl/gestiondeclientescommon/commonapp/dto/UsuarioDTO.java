package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.DireccionNegocioDTO;


public class UsuarioDTO implements Serializable{

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
	private String CodigoCuenta;
	private String CodigoSubCuenta;
	
	private String numeroAboando;
	private String TipUsuario;  //prepago--- postpago
	private String codigoUsuario;
	
	private boolean exitoCreacionUsuario;
	
	public String getCodDireccion() {
		return codDireccion;
	}

	public void setCodDireccion(String codDireccion) {
		this.codDireccion = codDireccion;
	}

	public String getCodigoCuenta() {
		return CodigoCuenta;
	}

	public void setCodigoCuenta(String codigoCuenta) {
		CodigoCuenta = codigoCuenta;
	}

	public String getCodigoSubCuenta() {
		return CodigoSubCuenta;
	}

	public void setCodigoSubCuenta(String codigoSubCuenta) {
		CodigoSubCuenta = codigoSubCuenta;
	}

	public String getIngresosBrutosAnuales() {
		return ingresosBrutosAnuales;
	}

	public void setIngresosBrutosAnuales(String ingresosBrutosAnuales) {
		this.ingresosBrutosAnuales = ingresosBrutosAnuales;
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

	public boolean isExitoCreacionUsuario() {
		return exitoCreacionUsuario;
	}

	public boolean getExitoCreacionUusario() {
		return exitoCreacionUsuario;
	}

	public void setExitoCreacionUsuario(boolean exitoCreacionUsuario) {
		this.exitoCreacionUsuario = exitoCreacionUsuario;
	}

	

	public String getCodigoUsuario() {
		return codigoUsuario;
	}

	public void setCodigoUsuario(String codigoUsuario) {
		this.codigoUsuario = codigoUsuario;
	}

	public String getTipUsuario() {
		return TipUsuario;
	}

	public void setTipUsuario(String tipUsuario) {
		TipUsuario = tipUsuario;
	}

	public String getNumeroAboando() {
		return numeroAboando;
	}

	public void setNumeroAboando(String numeroAboando) {
		this.numeroAboando = numeroAboando;
	}
}
