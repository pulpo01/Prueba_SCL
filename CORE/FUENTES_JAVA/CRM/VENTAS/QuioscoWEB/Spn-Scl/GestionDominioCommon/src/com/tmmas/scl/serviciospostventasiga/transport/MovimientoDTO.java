package com.tmmas.scl.serviciospostventasiga.transport;

import java.io.Serializable;

public class MovimientoDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private Long numAbonado;
	private String nomUsuario;
	private Long codCentral;
	private Long numCelular;
	private Long numSerie;
	private String codActabo;
	private Long numImei;
	private Long carga;
	private String codServSupl;
	private String plan;
	private String valorPlan;
	private String codError;
	private String desError;
	
	public String getCodActabo() {
		return codActabo;
	}
	public void setCodActabo(String codActabo) {
		this.codActabo = codActabo;
	}
	public String getCodError() {
		return codError;
	}
	public void setCodError(String codError) {
		this.codError = codError;
	}
	public String getDesError() {
		return desError;
	}
	public void setDesError(String desError) {
		this.desError = desError;
	}
	public String getNomUsuario() {
		return nomUsuario;
	}
	public void setNomUsuario(String nomUsuario) {
		this.nomUsuario = nomUsuario;
	}
	public Long getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(Long numAbonado) {
		this.numAbonado = numAbonado;
	}
	public Long getNumCelular() {
		return numCelular;
	}
	public void setNumCelular(Long codCelular) {
		this.numCelular = codCelular;
	}
	public Long getCodCentral() {
		return codCentral;
	}
	public void setCodCentral(Long codCentral) {
		this.codCentral = codCentral;
	}
	public Long getNumImei() {
		return numImei;
	}
	public void setNumImei(Long numImei) {
		this.numImei = numImei;
	}
	public Long getNumSerie() {
		return numSerie;
	}
	public void setNumSerie(Long numSerie) {
		this.numSerie = numSerie;
	}
	public String getCodServSupl() {
		return codServSupl;
	}
	public void setCodServSupl(String codServSupl) {
		this.codServSupl = codServSupl;
	}
	public Long getCarga() {
		return carga;
	}
	public void setCarga(Long carga) {
		this.carga = carga;
	}
	public String getPlan() {
		return plan;
	}
	public void setPlan(String plan) {
		this.plan = plan;
	}
	public String getValorPlan() {
		return valorPlan;
	}
	public void setValorPlan(String valorPlan) {
		this.valorPlan = valorPlan;
	}
	
	
}
