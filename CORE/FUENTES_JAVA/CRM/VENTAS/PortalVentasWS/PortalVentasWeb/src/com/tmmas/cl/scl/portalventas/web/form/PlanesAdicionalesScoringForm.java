package com.tmmas.cl.scl.portalventas.web.form;

import org.apache.struts.action.ActionForm;

import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.ProductoOfertadoDTO;

public class PlanesAdicionalesScoringForm extends ActionForm {

	/**
	 * © 2010 - TM-mAs
	 */
	private static final long serialVersionUID = -4134560441678277007L;

	private String desEstadoActual;

	private String mensajeError;

	private long numSolScoring;

	private ProductoOfertadoDTO[] productos;

	private String productosSeleccionadosEnCSV;

	public String getDesEstadoActual() {
		return desEstadoActual;
	}

	public String getMensajeError() {
		return mensajeError;
	}

	public long getNumSolScoring() {
		return numSolScoring;
	}

	public ProductoOfertadoDTO[] getProductos() {
		return productos;
	}

	public String getProductosSeleccionadosEnCSV() {
		return productosSeleccionadosEnCSV;
	}

	public void setDesEstadoActual(String desEstadoActual) {
		this.desEstadoActual = desEstadoActual;
	}

	public void setMensajeError(String mensajeError) {
		this.mensajeError = mensajeError;
	}

	public void setNumSolScoring(long numSolScoring) {
		this.numSolScoring = numSolScoring;
	}

	public void setProductos(ProductoOfertadoDTO[] productos) {
		this.productos = productos;
	}

	public void setProductosSeleccionadosEnCSV(String csvSeleccionados) {
		this.productosSeleccionadosEnCSV = csvSeleccionados;
	}

}
