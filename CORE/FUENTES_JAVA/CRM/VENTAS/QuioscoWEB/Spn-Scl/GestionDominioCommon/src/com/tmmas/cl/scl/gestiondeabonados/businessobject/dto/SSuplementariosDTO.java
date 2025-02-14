package com.tmmas.cl.scl.gestiondeabonados.businessobject.dto;

import java.io.Serializable;

public class SSuplementariosDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	
	private String codigoServicio;
	private String descripcionServicioS;
	private String codigoServSupl;
	private String codigoNivel;
	private String codConceptoMensual;
	private String duracion;
	private String codConceptoActiva;
	private String importeActiva;
	private String tarifaMensual;
	
	

	public String getDuracion() {
		return duracion;
	}
	public void setDuracion(String duracion) {
		this.duracion = duracion;
	}
	public String getCodigoNivel() {
		return codigoNivel;
	}
	public void setCodigoNivel(String codigoNivel) {
		this.codigoNivel = codigoNivel;
	}
	public String getCodigoServicio() {
		return codigoServicio;
	}
	public void setCodigoServicio(String codigoServicio) {
		this.codigoServicio = codigoServicio;
	}
	public String getCodigoServSupl() {
		return codigoServSupl;
	}
	public void setCodigoServSupl(String codigoServSupl) {
		this.codigoServSupl = codigoServSupl;
	}
	public String getDescripcionServicioS() {
		return descripcionServicioS;
	}
	public void setDescripcionServicioS(String descripcionServicioS) {
		this.descripcionServicioS = descripcionServicioS;
	}
	public String getCodConceptoActiva() {
		return codConceptoActiva;
	}
	public void setCodConceptoActiva(String codConceptoActiva) {
		this.codConceptoActiva = codConceptoActiva;
	}
	public String getCodConceptoMensual() {
		return codConceptoMensual;
	}
	public void setCodConceptoMensual(String codConceptoMensual) {
		this.codConceptoMensual = codConceptoMensual;
	}
	public String getImporteActiva() {
		return importeActiva;
	}
	public void setImporteActiva(String importeActiva) {
		this.importeActiva = importeActiva;
	}
	public String getTarifaMensual() {
		return tarifaMensual;
	}
	public void setTarifaMensual(String tarifaMensual) {
		this.tarifaMensual = tarifaMensual;
	}

}
