package com.tmmas.scl.operations.frmkooss.web.dto;

import java.io.Serializable;

public class SerieAjaxDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private String numSerie;
	private String numTelefono;
	private String fecha;
	private String codProcedencia;
	private String codArticuloEquipo;
	private String glsArticloEquipo;

	public String getGlsArticloEquipo() {
		return glsArticloEquipo;
	}
	public void setGlsArticloEquipo(String glsArticloEquipo) {
		this.glsArticloEquipo = glsArticloEquipo;
	}
	public String getCodArticuloEquipo() {
		return codArticuloEquipo;
	}
	public void setCodArticuloEquipo(String codArticuloEquipo) {
		this.codArticuloEquipo = codArticuloEquipo;
	}
	public String getFecha() {
		return fecha;
	}
	public void setFecha(String fecha) {
		this.fecha = fecha;
	}
	public String getNumSerie() {
		return numSerie;
	}
	public void setNumSerie(String numSerie) {
		this.numSerie = numSerie;
	}
	public String getNumTelefono() {
		return numTelefono;
	}
	public void setNumTelefono(String numTelefono) {
		this.numTelefono = numTelefono;
	}
	public String getCodProcedencia() {
		return codProcedencia;
	}
	public void setCodProcedencia(String codProcedencia) {
		this.codProcedencia = codProcedencia;
	}
	
}
