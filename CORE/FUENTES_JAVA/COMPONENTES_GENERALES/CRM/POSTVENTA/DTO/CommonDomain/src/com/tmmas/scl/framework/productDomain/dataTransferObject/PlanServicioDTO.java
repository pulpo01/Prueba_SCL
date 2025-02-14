/**
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 17/05/2007	     	Elizabeth Vera        				Versión Inicial
 */
package com.tmmas.scl.framework.productDomain.dataTransferObject;

import java.io.Serializable;

public class PlanServicioDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	private long idSecuencia;
	private String codActAbo;
	private int codProducto;
	private long numAbonado;
	private String codPlanServicio;
	private String parametro1;
	private String parametro2;
	
	private String tipPlanTarif;
	private String codPlanTarifNuevo;
	private long codHolding;
	
	private String codTipPlan;
	
	public String getCodTipPlan() {
		return codTipPlan;
	}
	public void setCodTipPlan(String codTipPlan) {
		this.codTipPlan = codTipPlan;
	}
	public long getCodHolding() {
		return codHolding;
	}
	public void setCodHolding(long codHolding) {
		this.codHolding = codHolding;
	}
	public String getCodPlanTarifNuevo() {
		return codPlanTarifNuevo;
	}
	public void setCodPlanTarifNuevo(String codPlanTarifNuevo) {
		this.codPlanTarifNuevo = codPlanTarifNuevo;
	}
	public String getTipPlanTarif() {
		return tipPlanTarif;
	}
	public void setTipPlanTarif(String tipPlanTarif) {
		this.tipPlanTarif = tipPlanTarif;
	}
	public String getCodActAbo() {
		return codActAbo;
	}
	public void setCodActAbo(String codActAbo) {
		this.codActAbo = codActAbo;
	}
	public String getCodPlanServicio() {
		return codPlanServicio;
	}
	public void setCodPlanServicio(String codPlanServicio) {
		this.codPlanServicio = codPlanServicio;
	}
	public int getCodProducto() {
		return codProducto;
	}
	public void setCodProducto(int codProducto) {
		this.codProducto = codProducto;
	}
	public long getIdSecuencia() {
		return idSecuencia;
	}
	public void setIdSecuencia(long idSecuencia) {
		this.idSecuencia = idSecuencia;
	}
	public long getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(long numAbonado) {
		this.numAbonado = numAbonado;
	}
	public String getParametro1() {
		return parametro1;
	}
	public void setParametro1(String parametro1) {
		this.parametro1 = parametro1;
	}
	public String getParametro2() {
		return parametro2;
	}
	public void setParametro2(String parametro2) {
		this.parametro2 = parametro2;
	}
	

}
