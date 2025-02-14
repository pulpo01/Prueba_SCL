package com.tmmas.scl.operations.crm.fab.cusintman.web.form;

import org.apache.struts.action.ActionForm;

public class CambioNumYSimForm extends ActionForm {
	private static final long serialVersionUID = 1L;

	private String celda;
	private String central;
	private String seleccion;
	private String nroCelular;
	private String hlr;
	private String centralHlr;
	private String usoVenta;
	private String nroSerie;
	private String tecnologia;	
	private String condicionError;
	private String mensajeError;
	private String mensajeStackTrace;
	private String btnSeleccionado;
	
	public String getBtnSeleccionado() {
		return btnSeleccionado;
	}
	public void setBtnSeleccionado(String btnSeleccionado) {
		this.btnSeleccionado = btnSeleccionado;
	}
	public String getCondicionError() {
		return condicionError;
	}
	public void setCondicionError(String condicionError) {
		this.condicionError = condicionError;
	}
	public String getMensajeError() {
		return mensajeError;
	}
	public void setMensajeError(String mensajeError) {
		this.mensajeError = mensajeError;
	}
	public String getMensajeStackTrace() {
		return mensajeStackTrace;
	}
	public void setMensajeStackTrace(String mensajeStackTrace) {
		this.mensajeStackTrace = mensajeStackTrace;
	}
	public String getTecnologia() {
		return tecnologia;
	}
	public void setTecnologia(String tecnologia) {
		this.tecnologia = tecnologia;
	}
	
	public String getCentralHlr() {
		return centralHlr;
	}
	public void setCentralHlr(String centralSim) {
		this.centralHlr = centralSim;
	}
	public String getHlr() {
		return hlr;
	}
	public void setHlr(String hlr) {
		this.hlr = hlr;
	}
	public String getNroSerie() {
		return nroSerie;
	}
	public void setNroSerie(String nroSerie) {
		this.nroSerie = nroSerie;
	}
	public String getUsoVenta() {
		return usoVenta;
	}
	public void setUsoVenta(String usoVenta) {
		this.usoVenta = usoVenta;
	}
	public String getCelda() {
		return celda;
	}
	public void setCelda(String celda) {
		this.celda = celda;
	}
	public String getCentral() {
		return central;
	}
	public void setCentral(String central) {
		this.central = central;
	}
	public String getNroCelular() {
		return nroCelular;
	}
	public void setNroCelular(String nroCelular) {
		this.nroCelular = nroCelular;
	}
	public String getSeleccion() {
		return seleccion;
	}
	public void setSeleccion(String seleccion) {
		this.seleccion = seleccion;
	}
	
}
