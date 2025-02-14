/**
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 24/07/2007	     	Elizabeth Vera        				Versión Inicial
 */
package com.tmmas.scl.framework.productDomain.dataTransferObject;

import java.io.Serializable;

public class ConsultaHibridoDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	private long codCliente;
	private String codPlanTarif;
	private String tipPlanTarif;
	private String codTipPlan;
	private String codTecnologia;
	private long numAbonado;
	private String usuarioOracle;
	private int enCambioPlanFamiliar;
	private String codPlanTarifNuevo;
	
	public long getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(long codCliente) {
		this.codCliente = codCliente;
	}
	public String getCodPlanTarif() {
		return codPlanTarif;
	}
	public void setCodPlanTarif(String codPlanTarif) {
		this.codPlanTarif = codPlanTarif;
	}
	public String getCodPlanTarifNuevo() {
		return codPlanTarifNuevo;
	}
	public void setCodPlanTarifNuevo(String codPlanTarifNuevo) {
		this.codPlanTarifNuevo = codPlanTarifNuevo;
	}
	public String getCodTecnologia() {
		return codTecnologia;
	}
	public void setCodTecnologia(String codTecnologia) {
		this.codTecnologia = codTecnologia;
	}
	public String getCodTipPlan() {
		return codTipPlan;
	}
	public void setCodTipPlan(String codTipPlan) {
		this.codTipPlan = codTipPlan;
	}
	public int getEnCambioPlanFamiliar() {
		return enCambioPlanFamiliar;
	}
	public void setEnCambioPlanFamiliar(int enCambioPlanFamiliar) {
		this.enCambioPlanFamiliar = enCambioPlanFamiliar;
	}
	public long getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(long numAbonado) {
		this.numAbonado = numAbonado;
	}
	public String getTipPlanTarif() {
		return tipPlanTarif;
	}
	public void setTipPlanTarif(String tipPlanTarif) {
		this.tipPlanTarif = tipPlanTarif;
	}
	public String getUsuarioOracle() {
		return usuarioOracle;
	}
	public void setUsuarioOracle(String usuarioOracle) {
		this.usuarioOracle = usuarioOracle;
	}
	
}
