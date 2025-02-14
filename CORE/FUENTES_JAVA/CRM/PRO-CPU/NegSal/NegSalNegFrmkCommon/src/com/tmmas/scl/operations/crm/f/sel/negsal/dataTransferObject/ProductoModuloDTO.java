package com.tmmas.scl.operations.crm.f.sel.negsal.dataTransferObject;

import java.io.Serializable;

public class ProductoModuloDTO implements Serializable
{		
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String idClienteBeneficiario;
	private String idAbonadoBeneficiario;
	private String fechaInicioVigencia;	
	private String numProceso;
	private String origenProceso;	
	private String indCondicionContratacion;
	private String idClienteContratante;
	private String numAbonadoContratante;
	private String fechaTerminoVigencia;
	private String idProductoOfertado;
	public String getFechaInicioVigencia() {
		return fechaInicioVigencia;
	}
	public void setFechaInicioVigencia(String fechaInicioVigencia) {
		this.fechaInicioVigencia = fechaInicioVigencia;
	}
	public String getFechaTerminoVigencia() {
		return fechaTerminoVigencia;
	}
	public void setFechaTerminoVigencia(String fechaTerminoVigencia) {
		this.fechaTerminoVigencia = fechaTerminoVigencia;
	}
	public String getIdAbonadoBeneficiario() {
		return idAbonadoBeneficiario;
	}
	public void setIdAbonadoBeneficiario(String idAbonadoBeneficiario) {
		this.idAbonadoBeneficiario = idAbonadoBeneficiario;
	}
	public String getIdClienteBeneficiario() {
		return idClienteBeneficiario;
	}
	public void setIdClienteBeneficiario(String idClienteBeneficiario) {
		this.idClienteBeneficiario = idClienteBeneficiario;
	}
	public String getIdClienteContratante() {
		return idClienteContratante;
	}
	public void setIdClienteContratante(String idClienteContratante) {
		this.idClienteContratante = idClienteContratante;
	}
	public String getIdProductoOfertado() {
		return idProductoOfertado;
	}
	public void setIdProductoOfertado(String idProductoOfertado) {
		this.idProductoOfertado = idProductoOfertado;
	}
	public String getIndCondicionContratacion() {
		return indCondicionContratacion;
	}
	public void setIndCondicionContratacion(String indCondicionContratacion) {
		this.indCondicionContratacion = indCondicionContratacion;
	}
	public String getNumAbonadoContratante() {
		return numAbonadoContratante;
	}
	public void setNumAbonadoContratante(String numAbonadoContratante) {
		this.numAbonadoContratante = numAbonadoContratante;
	}
	public String getNumProceso() {
		return numProceso;
	}
	public void setNumProceso(String numProceso) {
		this.numProceso = numProceso;
	}
	public String getOrigenProceso() {
		return origenProceso;
	}
	public void setOrigenProceso(String origenProceso) {
		this.origenProceso = origenProceso;
	}	
}
