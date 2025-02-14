/**
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 18/05/2007	     	Elizabeth Vera        				Versión Inicial
 */
package com.tmmas.scl.framework.serviceDomain.dataTransferObject;

import java.io.Serializable;

public class AprovisionamientoDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	private long numAbonado;
	private String codActAbo;
	private String tipoTecnologia;
	private String usuarioOracle;
	private String codTipoTerminal;
	private int codCentral;
	private long numCelular;
	private String numSerie;
	private String imei;
	private float valorOOSS;
	private String codPlanTarif;
	private long numOOSS;
	private long codOOSS;
	private String codTecnologia;
	private long seqNumMov;
	private String codTipPlan;
	private String codServicios;
	
	public String getCodServicios() {
		return codServicios;
	}
	public void setCodServicios(String codServicios) {
		this.codServicios = codServicios;
	}
	public String getCodTipPlan() {
		return codTipPlan;
	}
	public void setCodTipPlan(String codTipPlan) {
		this.codTipPlan = codTipPlan;
	}
	public String getCodActAbo() {
		return codActAbo;
	}
	public void setCodActAbo(String codActAbo) {
		this.codActAbo = codActAbo;
	}
	public int getCodCentral() {
		return codCentral;
	}
	public void setCodCentral(int codCentral) {
		this.codCentral = codCentral;
	}
	public long getCodOOSS() {
		return codOOSS;
	}
	public void setCodOOSS(long codOOSS) {
		this.codOOSS = codOOSS;
	}
	public String getCodPlanTarif() {
		return codPlanTarif;
	}
	public void setCodPlanTarif(String codPlanTarif) {
		this.codPlanTarif = codPlanTarif;
	}
	public String getCodTecnologia() {
		return codTecnologia;
	}
	public void setCodTecnologia(String codTecnologia) {
		this.codTecnologia = codTecnologia;
	}
	public String getCodTipoTerminal() {
		return codTipoTerminal;
	}
	public void setCodTipoTerminal(String codTipoTerminal) {
		this.codTipoTerminal = codTipoTerminal;
	}
	public String getImei() {
		return imei;
	}
	public void setImei(String imei) {
		this.imei = imei;
	}

	public String getUsuarioOracle() {
		return usuarioOracle;
	}
	public void setUsuarioOracle(String usuarioOracle) {
		this.usuarioOracle = usuarioOracle;
	}
	public long getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(long numAbonado) {
		this.numAbonado = numAbonado;
	}
	public long getNumCelular() {
		return numCelular;
	}
	public void setNumCelular(long numCelular) {
		this.numCelular = numCelular;
	}
	public long getNumOOSS() {
		return numOOSS;
	}
	public void setNumOOSS(long numOOSS) {
		this.numOOSS = numOOSS;
	}
	public String getNumSerie() {
		return numSerie;
	}
	public void setNumSerie(String numSerie) {
		this.numSerie = numSerie;
	}
	public long getSeqNumMov() {
		return seqNumMov;
	}
	public void setSeqNumMov(long seqNumMov) {
		this.seqNumMov = seqNumMov;
	}
	public String getTipoTecnologia() {
		return tipoTecnologia;
	}
	public void setTipoTecnologia(String tipoTecnologia) {
		this.tipoTecnologia = tipoTecnologia;
	}
	public float getValorOOSS() {
		return valorOOSS;
	}
	public void setValorOOSS(float valorOOSS) {
		this.valorOOSS = valorOOSS;
	}
	
	
}
