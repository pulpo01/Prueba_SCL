package com.tmmas.scl.quiosco.web.form;

import org.apache.struts.action.ActionForm;

public class MantenedorClientizarForm extends ActionForm{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	//Datos Articulo
	private String codArticulo;
	private String codTipificacion;
	private String descripcion;
	private String tipificacion;
	private String clientizable;
	private String usuaSclClient;
	
	//Accion del Formulario
	private String accionMantClient;
	
	//Transporte data
	private String cadenaArticulos; //Cada parametro esta separado por # y cada linea esta $

	public String getCodArticulo() {
		return codArticulo;
	}

	public void setCodArticulo(String codArticulo) {
		this.codArticulo = codArticulo;
	}

	public String getCodTipificacion() {
		return codTipificacion;
	}

	public void setCodTipificacion(String codTipificacion) {
		this.codTipificacion = codTipificacion;
	}

	public String getDescripcion() {
		return descripcion;
	}

	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}

	public String getTipificacion() {
		return tipificacion;
	}

	public void setTipificacion(String tipificacion) {
		this.tipificacion = tipificacion;
	}

	public String getClientizable() {
		return clientizable;
	}

	public void setClientizable(String clientizable) {
		this.clientizable = clientizable;
	}

	public String getUsuaSclClient() {
		return usuaSclClient;
	}

	public void setUsuaSclClient(String usuaSclClient) {
		this.usuaSclClient = usuaSclClient;
	}

	public String getAccionMantClient() {
		return accionMantClient;
	}

	public void setAccionMantClient(String accionMantClient) {
		this.accionMantClient = accionMantClient;
	}

	public String getCadenaArticulos() {
		return cadenaArticulos;
	}

	public void setCadenaArticulos(String cadenaArticulos) {
		this.cadenaArticulos = cadenaArticulos;
	}

}
