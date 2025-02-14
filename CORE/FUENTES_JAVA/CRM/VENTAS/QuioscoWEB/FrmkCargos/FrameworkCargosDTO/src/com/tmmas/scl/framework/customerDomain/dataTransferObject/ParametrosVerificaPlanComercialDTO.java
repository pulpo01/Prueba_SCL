package com.tmmas.scl.framework.customerDomain.dataTransferObject;

import java.io.Serializable;

public class ParametrosVerificaPlanComercialDTO implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 8687439211497295828L;
	
	private long numAbonado;
	private String nomUsuario;
	private String codPrograma;
	private String numVersion;
	private String codCausaServicio;
	private long codModVenta;
	private String codUso;
	private String tipTerminal;
	private String numSerie;
	private String codTipContrato;
	private String codTecnologia;
	
	public String getCodCausaServicio() {
		return codCausaServicio;
	}
	public void setCodCausaServicio(String codCausaServicio) {
		this.codCausaServicio = codCausaServicio;
	}
	public long getCodModVenta() {
		return codModVenta;
	}
	public void setCodModVenta(long codModVenta) {
		this.codModVenta = codModVenta;
	}
	public String getCodPrograma() {
		return codPrograma;
	}
	public void setCodPrograma(String codPrograma) {
		this.codPrograma = codPrograma;
	}
	public String getCodTecnologia() {
		return codTecnologia;
	}
	public void setCodTecnologia(String codTecnologia) {
		this.codTecnologia = codTecnologia;
	}
	public String getCodTipContrato() {
		return codTipContrato;
	}
	public void setCodTipContrato(String codTipContrato) {
		this.codTipContrato = codTipContrato;
	}
	public String getCodUso() {
		return codUso;
	}
	public void setCodUso(String codUso) {
		this.codUso = codUso;
	}
	public String getNomUsuario() {
		return nomUsuario;
	}
	public void setNomUsuario(String nomUsuario) {
		this.nomUsuario = nomUsuario;
	}
	public long getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(long numAbonado) {
		this.numAbonado = numAbonado;
	}
	public String getNumSerie() {
		return numSerie;
	}
	public void setNumSerie(String numSerie) {
		this.numSerie = numSerie;
	}
	public String getNumVersion() {
		return numVersion;
	}
	public void setNumVersion(String numVersion) {
		this.numVersion = numVersion;
	}
	public String getTipTerminal() {
		return tipTerminal;
	}
	public void setTipTerminal(String tipTerminal) {
		this.tipTerminal = tipTerminal;
	}
}
