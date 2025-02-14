package com.tmmas.cl.scl.customerdomain.businessobject.dto;

import java.io.Serializable;
import java.sql.Date;

public class MatrizEstadosDTO implements Serializable{
	 
	private static final long serialVersionUID = 1L;
	private String codPrograma;
	private String indOfiter;
	private String codProceso;
	private String formulario;
	private String codestadoOrigen;
	private String codEstadoDestino;
	private Date fecDesde;
	private Date fecHasta;
	private Date fecVenta;
	private String nomUsuario;
	private Date fecUltmod;
	private Long indModif;
	
	public String getCodEstadoDestino() {
		return codEstadoDestino;
	}
	public void setCodEstadoDestino(String _codEstadoDestino) {
		this.codEstadoDestino = _codEstadoDestino;
	}
	public String getCodestadoOrigen() {
		return codestadoOrigen;
	}
	public void setCodestadoOrigen(String _codestadoOrigen) {
		this.codestadoOrigen = _codestadoOrigen;
	}
	public String getCodProceso() {
		return codProceso;
	}
	public void setCodProceso(String _codProceso) {
		this.codProceso = _codProceso;
	}
	public String getCodPrograma() {
		return codPrograma;
	}
	public void setCodPrograma(String _codPrograma) {
		this.codPrograma = _codPrograma;
	}
	public Date getFecDesde() {
		return fecDesde;
	}
	public void setFecDesde(Date _fecDesde) {
		this.fecDesde = _fecDesde;
	}
	public Date getFecHasta() {
		return fecHasta;
	}
	public void setFecHasta(Date _fecHasta) {
		this.fecHasta = _fecHasta;
	}
	public Date getFecUltmod() {
		return fecUltmod;
	}
	public void setFecUltmod(Date _fecUltmod) {
		this.fecUltmod = _fecUltmod;
	}
	public String getFormulario() {
		return formulario;
	}
	public void setFormulario(String _formulario) {
		this.formulario = _formulario;
	}
	public Long getIndModif() {
		return indModif;
	}
	public void setIndModif(Long _indModif) {
		this.indModif = _indModif;
	}
	public String getIndOfiter() {
		return indOfiter;
	}
	public void setIndOfiter(String _indOfiter) {
		this.indOfiter = _indOfiter;
	}
	public String getNomUsuario() {
		return nomUsuario;
	}
	public void setNomUsuario(String _nomUsuario) {
		this.nomUsuario = _nomUsuario;
	}
	public Date getFecVenta() {
		return fecVenta;
	}
	public void setFecVenta(Date _fecVenta) {
		this.fecVenta = _fecVenta;
	}
}
