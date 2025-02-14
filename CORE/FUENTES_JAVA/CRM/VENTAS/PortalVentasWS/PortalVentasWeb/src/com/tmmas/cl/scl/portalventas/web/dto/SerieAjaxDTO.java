package com.tmmas.cl.scl.portalventas.web.dto;

import java.io.Serializable;

public class SerieAjaxDTO implements Serializable {

	private static final long serialVersionUID = 5024519897236536917L;

	private String numSerie;

	private String numTelefono;

	private String fecha;

	private String codProcedencia;

	private String codArticuloEquipo;

	private String glsArticloEquipo;

	private String tipoStock;

	private String codUso;

	/** 
	 * Incidencia 148144
	 * @author JIB
	 * Operadora solicita mostrar des_uso en la búsqueda de series */
	private String desUso;

	public String getTipoStock() {
		return tipoStock;
	}

	public void setTipoStock(String tipoStock) {
		this.tipoStock = tipoStock;
	}

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

	public String getCodUso() {
		return codUso;
	}

	public void setCodUso(String codUso) {
		this.codUso = codUso;
	}

	public String getDesUso() {
		return desUso;
	}

	public void setDesUso(String desUso) {
		this.desUso = desUso;
	}

}
