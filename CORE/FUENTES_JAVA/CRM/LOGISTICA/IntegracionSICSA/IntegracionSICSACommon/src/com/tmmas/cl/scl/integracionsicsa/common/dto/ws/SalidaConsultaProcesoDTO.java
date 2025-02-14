package com.tmmas.cl.scl.integracionsicsa.common.dto.ws;

import java.io.Serializable;

public class SalidaConsultaProcesoDTO extends SalidaIntegracionSICSADTO implements Serializable{
	/**
     * 
     */
	private static final long serialVersionUID = 1L;

	private String codCliente;
	private String nomCliente;
	private String totalSeries;
	private String fecOperacion;
	private String estado;
	
	public String getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(String codCliente) {
		this.codCliente = codCliente;
	}
	public String getNomCliente() {
		return nomCliente;
	}
	public void setNomCliente(String nomCliente) {
		this.nomCliente = nomCliente;
	}
	public String getTotalSeries() {
		return totalSeries;
	}
	public void setTotalSeries(String totalSeries) {
		this.totalSeries = totalSeries;
	}
	public String getFecOperacion() {
		return fecOperacion;
	}
	public void setFecOperacion(String fecOperacion) {
		this.fecOperacion = fecOperacion;
	}
	public String getEstado() {
		return estado;
	}
	public void setEstado(String estado) {
		this.estado = estado;
	}

}
