package com.tmmas.cl.scl.portalventas.web.form;

import org.apache.struts.action.ActionForm;

public class ServiciosSuplementariosForm extends ActionForm {
	private static final long serialVersionUID = 1L;

	// (+) reserva y anulacion de numero celular
	private String numFax;

	private String tablaNumeracion;

	private String categoriaNumeracion;

	private String contactosTabla;

	private String moduloWebOrigen;

	private String moduloWebScoring;

	private String moduloWebSolicitudVenta;

	public String getModuloWebSolicitudVenta() {
		return moduloWebSolicitudVenta;
	}

	public void setModuloWebSolicitudVenta(String moduloWebSolicitudVenta) {
		this.moduloWebSolicitudVenta = moduloWebSolicitudVenta;
	}

	public String getModuloWebScoring() {
		return moduloWebScoring;
	}

	public void setModuloWebScoring(String moduloWebScoring) {
		this.moduloWebScoring = moduloWebScoring;
	}

	public String getModuloWebOrigen() {
		return moduloWebOrigen;
	}

	public void setModuloWebOrigen(String moduloOrigen) {
		this.moduloWebOrigen = moduloOrigen;
	}

	public String getContactosTabla() {
		return contactosTabla;
	}

	public void setContactosTabla(String contactosTabla) {
		this.contactosTabla = contactosTabla;
	}

	public String getCategoriaNumeracion() {
		return categoriaNumeracion;
	}

	public void setCategoriaNumeracion(String categoriaNumeracion) {
		this.categoriaNumeracion = categoriaNumeracion;
	}

	public String getTablaNumeracion() {
		return tablaNumeracion;
	}

	public void setTablaNumeracion(String tablaNumeracion) {
		this.tablaNumeracion = tablaNumeracion;
	}

	public String getNumFax() {
		return numFax;
	}

	public void setNumFax(String numFax) {
		this.numFax = numFax;
	}

}
