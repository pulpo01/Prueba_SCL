package com.tmmas.gte.integraciongtecommon.dto;

import java.io.Serializable;

public class ConsultaLlamadasFacturadasInDTO implements Serializable {
	/**
	 * Autor : Leonardo Muñoz R.
	 */
	private static final long serialVersionUID = 1L;
	
	private long numTelefono;
	private String codCicloFact;
	private long numFolio;
	private String fecIni;
	private String fecTerm;
	private String usuario;
	private String campoOrden;
	private String tipoOrden;
	private long numAbonado;
	
	public long getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(long numAbonado) {
		this.numAbonado = numAbonado;
	}
	public String getCampoOrden() {
		return campoOrden;
	}
	public void setCampoOrden(String campoOrden) {
		this.campoOrden = campoOrden;
	}
	public String getFecIni() {
		return fecIni;
	}
	public void setFecIni(String fecIni) {
		this.fecIni = fecIni;
	}
	public String getFecTerm() {
		return fecTerm;
	}
	public void setFecTerm(String fecTerm) {
		this.fecTerm = fecTerm;
	}
	public long getNumFolio() {
		return numFolio;
	}
	public void setNumFolio(long numFolio) {
		this.numFolio = numFolio;
	}
	public long getNumTelefono() {
		return numTelefono;
	}
	public void setNumTelefono(long numTelefono) {
		this.numTelefono = numTelefono;
	}
	public String getTipoOrden() {
		return tipoOrden;
	}
	public void setTipoOrden(String tipoOrden) {
		this.tipoOrden = tipoOrden;
	}
	public String getUsuario() {
		return usuario;
	}
	public void setUsuario(String usuario) {
		this.usuario = usuario;
	}
	public String getCodCicloFact() {
		return codCicloFact;
	}
	public void setCodCicloFact(String codCicloFact) {
		this.codCicloFact = codCicloFact;
	}

	
	
}
