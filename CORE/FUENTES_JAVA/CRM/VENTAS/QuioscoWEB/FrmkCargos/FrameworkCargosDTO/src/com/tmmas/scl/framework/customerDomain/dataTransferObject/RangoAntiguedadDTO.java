package com.tmmas.scl.framework.customerDomain.dataTransferObject;

import java.io.Serializable;
import java.util.Date;

public class RangoAntiguedadDTO implements Serializable {
	
	private static final long serialVersionUID = 1L;
	private String codCausaBaja;
	private Date fechaProrroga;
	private Date fechaAlta;
	private String numSerie;
	private String rangoAntiguedad;
	
	public String getRangoAntiguedad() {
		return rangoAntiguedad;
	}
	public void setRangoAntiguedad(String rangoAntiguedad) {
		this.rangoAntiguedad = rangoAntiguedad;
	}
	public String getCodCausaBaja() {
		return codCausaBaja;
	}
	public void setCodCausaBaja(String codCausaBaja) {
		this.codCausaBaja = codCausaBaja;
	}
	public Date getFechaAlta() {
		return fechaAlta;
	}
	public void setFechaAlta(Date fechaAlta) {
		this.fechaAlta = fechaAlta;
	}
	public Date getFechaProrroga() {
		return fechaProrroga;
	}
	public void setFechaProrroga(Date fechaProrroga) {
		this.fechaProrroga = fechaProrroga;
	}
	public String getNumSerie() {
		return numSerie;
	}
	public void setNumSerie(String numSerie) {
		this.numSerie = numSerie;
	}  

}
