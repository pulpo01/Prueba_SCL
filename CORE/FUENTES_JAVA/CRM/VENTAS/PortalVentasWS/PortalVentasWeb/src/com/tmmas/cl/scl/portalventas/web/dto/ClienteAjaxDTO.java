package com.tmmas.cl.scl.portalventas.web.dto;

import java.io.Serializable;

import com.tmmas.cl.scl.portalventas.web.helper.Utilidades;

public class ClienteAjaxDTO implements Serializable {

	private static final long serialVersionUID = 1L;

	private String codigoCliente;

	private String codigoTipoIdentificacion;

	private String desTipoIdentificacion;

	private String numeroIdentificacion;

	private String tipoCliente;

	private String nombreCliente;

	private String nombreApellido1;

	private String nombreApellido2;

	private String numeroTelefono1;

	private String direccionEMail;

	private String fechaNacimiento;

	private String glsTipoCliente;

	private String codCrediticia;

	private double montoPreAutorizado;

	private String codCalificacion;

	private String descripcionColor;

	private String descripcionSegmento;

	public String getDescripcionColor() {
		return descripcionColor;
	}

	public void setDescripcionColor(String descripcionColor) {
		this.descripcionColor = descripcionColor;
	}

	public String getDescripcionSegmento() {
		return descripcionSegmento;
	}

	public void setDescripcionSegmento(String descripcionSegmento) {
		this.descripcionSegmento = descripcionSegmento;
	}

	public String getCodCalificacion() {
		return codCalificacion;
	}

	public void setCodCalificacion(String codCalificacion) {
		this.codCalificacion = codCalificacion;
	}

	public String getCodCrediticia() {
		return codCrediticia;
	}

	public void setCodCrediticia(String codCrediticia) {
		this.codCrediticia = codCrediticia;
	}

	public double getMontoPreAutorizado() {
		return montoPreAutorizado;
	}

	public void setMontoPreAutorizado(double montoPreAutorizado) {
		this.montoPreAutorizado = montoPreAutorizado;
	}

	public String getGlsTipoCliente() {
		return glsTipoCliente;
	}

	public void setGlsTipoCliente(String glsTipoCliente) {
		this.glsTipoCliente = glsTipoCliente;
	}

	public String getCodigoCliente() {
		return codigoCliente;
	}

	public void setCodigoCliente(String codigoCliente) {
		this.codigoCliente = codigoCliente;
	}

	public String getCodigoTipoIdentificacion() {
		return codigoTipoIdentificacion;
	}

	public void setCodigoTipoIdentificacion(String codigoTipoIdentificacion) {
		this.codigoTipoIdentificacion = codigoTipoIdentificacion;
	}

	public String getDireccionEMail() {
		return direccionEMail;
	}

	public void setDireccionEMail(String direccionEMail) {
		this.direccionEMail = direccionEMail;
	}

	public String getFechaNacimiento() {
		return fechaNacimiento;
	}

	public void setFechaNacimiento(String fechaNacimiento) {
		this.fechaNacimiento = fechaNacimiento;
	}

	public String getNombreApellido1() {
		return nombreApellido1;
	}

	public void setNombreApellido1(String nombreApellido1) {
		this.nombreApellido1 = nombreApellido1;
	}

	public String getNombreApellido2() {
		return nombreApellido2;
	}

	public void setNombreApellido2(String nombreApellido2) {
		this.nombreApellido2 = nombreApellido2;
	}

	public String getNombreCliente() {
		return nombreCliente;
	}

	public void setNombreCliente(String nombreCliente) {
		this.nombreCliente = nombreCliente;
	}

	public String getNumeroIdentificacion() {
		return numeroIdentificacion;
	}

	public void setNumeroIdentificacion(String numeroIdentificacion) {
		this.numeroIdentificacion = numeroIdentificacion;
	}

	public String getNumeroTelefono1() {
		return numeroTelefono1;
	}

	public void setNumeroTelefono1(String numeroTelefono1) {
		this.numeroTelefono1 = numeroTelefono1;
	}

	public String getTipoCliente() {
		return tipoCliente;
	}

	public void setTipoCliente(String tipoCliente) {
		this.tipoCliente = tipoCliente;
	}

	public String getDesTipoIdentificacion() {
		return desTipoIdentificacion;
	}

	public void setDesTipoIdentificacion(String desTipoIdentificacion) {
		this.desTipoIdentificacion = desTipoIdentificacion;
	}

	public String getNombreCompleto() {
		return Utilidades.concatenar(nombreCliente, nombreApellido1, nombreApellido2);
	}
}
