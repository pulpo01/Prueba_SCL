/**
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 18/07/2007	     	Elizabeth Vera        				Versión Inicial
 */
package com.tmmas.scl.framework.serviceDomain.dataTransferObject;

import java.io.Serializable;

public class ConsultaPrepagosDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	private long numCelular;
	private String numSerie;
	private long numAbonado;
	private String codTecnologia;
	private String codPlanTarifActual;
	private String codPlanTarif;
	private String codPlanServ;
	private String codActAbo;
	private float vnSaldo;
	private float impTarifa;
	
	public String getCodActAbo() {
		return codActAbo;
	}
	public void setCodActAbo(String codActAbo) {
		this.codActAbo = codActAbo;
	}
	public String getCodPlanServ() {
		return codPlanServ;
	}
	public void setCodPlanServ(String codPlanServ) {
		this.codPlanServ = codPlanServ;
	}
	public String getCodPlanTarif() {
		return codPlanTarif;
	}
	public void setCodPlanTarif(String codPlanTarif) {
		this.codPlanTarif = codPlanTarif;
	}
	public String getCodPlanTarifActual() {
		return codPlanTarifActual;
	}
	public void setCodPlanTarifActual(String codPlanTarifActual) {
		this.codPlanTarifActual = codPlanTarifActual;
	}
	public String getCodTecnologia() {
		return codTecnologia;
	}
	public void setCodTecnologia(String codTecnologia) {
		this.codTecnologia = codTecnologia;
	}
	public float getImpTarifa() {
		return impTarifa;
	}
	public void setImpTarifa(float impTarifa) {
		this.impTarifa = impTarifa;
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
	public String getNumSerie() {
		return numSerie;
	}
	public void setNumSerie(String numSerie) {
		this.numSerie = numSerie;
	}
	public float getVnSaldo() {
		return vnSaldo;
	}
	public void setVnSaldo(float vnSaldo) {
		this.vnSaldo = vnSaldo;
	}
}
