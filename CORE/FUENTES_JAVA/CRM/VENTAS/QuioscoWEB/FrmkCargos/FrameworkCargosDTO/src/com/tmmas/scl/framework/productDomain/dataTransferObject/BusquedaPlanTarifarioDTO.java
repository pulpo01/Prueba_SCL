package com.tmmas.scl.framework.productDomain.dataTransferObject;

import java.io.Serializable;

public class BusquedaPlanTarifarioDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private String codTipoPlan;
	private int codTipoCliente;
	private String cambioPlanFamiliar;
	private String codPlanTarif;
	private boolean flgPermisos;
	private String codClaPlanTarif;
	private long numAbonado;
	private String codTecnologia;
	private long numSolicitudEval;
	private String codPlanTarifEval;
	private boolean flgCargaComboPlanEval;
	private String codTipoMovimiento;
	private String codTipoPostPago;
	private String codTipoHibrido;
	private int codUsoPlanCuentaSegura;
	private int codUsoUsoLinea;
	private String codActAbo;
	
	private String tipPlanTarif;
	private String usuarioOracle;
	
	private long codCliente;

	  
	public long getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(long codCliente) {
		this.codCliente = codCliente;
	}
	public String getUsuarioOracle() {
		return usuarioOracle;
	}
	public void setUsuarioOracle(String usuarioOracle) {
		this.usuarioOracle = usuarioOracle;
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
	public String getCodClaPlanTarif() {
		return codClaPlanTarif;
	}
	public void setCodClaPlanTarif(String codClaPlanTarif) {
		this.codClaPlanTarif = codClaPlanTarif;
	}
	public String getCodPlanTarif() {
		return codPlanTarif;
	}
	public void setCodPlanTarif(String codPlanTarif) {
		this.codPlanTarif = codPlanTarif;
	}
	public String getCodPlanTarifEval() {
		return codPlanTarifEval;
	}
	public void setCodPlanTarifEval(String codPlanTarifEval) {
		this.codPlanTarifEval = codPlanTarifEval;
	}
	public String getCodTecnologia() {
		return codTecnologia;
	}
	public void setCodTecnologia(String codTecnologia) {
		this.codTecnologia = codTecnologia;
	}
	public int getCodTipoCliente() {
		return codTipoCliente;
	}
	public void setCodTipoCliente(int codTipoCliente) {
		this.codTipoCliente = codTipoCliente;
	}
	public String getCodTipoHibrido() {
		return codTipoHibrido;
	}
	public void setCodTipoHibrido(String codTipoHibrido) {
		this.codTipoHibrido = codTipoHibrido;
	}
	public String getCodTipoMovimiento() {
		return codTipoMovimiento;
	}
	public void setCodTipoMovimiento(String codTipoMovimiento) {
		this.codTipoMovimiento = codTipoMovimiento;
	}
	public String getCodTipoPlan() {
		return codTipoPlan;
	}
	public void setCodTipoPlan(String codTipoPlan) {
		this.codTipoPlan = codTipoPlan;
	}
	public String getCodTipoPostPago() {
		return codTipoPostPago;
	}
	public void setCodTipoPostPago(String codTipoPostPago) {
		this.codTipoPostPago = codTipoPostPago;
	}
	public int getCodUsoPlanCuentaSegura() {
		return codUsoPlanCuentaSegura;
	}
	public void setCodUsoPlanCuentaSegura(int codUsoPlanCuentaSegura) {
		this.codUsoPlanCuentaSegura = codUsoPlanCuentaSegura;
	}
	public int getCodUsoUsoLinea() {
		return codUsoUsoLinea;
	}
	public void setCodUsoUsoLinea(int codUsoUsoLinea) {
		this.codUsoUsoLinea = codUsoUsoLinea;
	}
	public String getCambioPlanFamiliar() {
		return cambioPlanFamiliar;
	}
	public void setCambioPlanFamiliar(String cambioPlanFamiliar) {
		this.cambioPlanFamiliar = cambioPlanFamiliar;
	}
	public boolean isFlgCargaComboPlanEval() {
		return flgCargaComboPlanEval;
	}
	public void setFlgCargaComboPlanEval(boolean flgCargaComboPlanEval) {
		this.flgCargaComboPlanEval = flgCargaComboPlanEval;
	}
	public boolean isFlgPermisos() {
		return flgPermisos;
	}
	public void setFlgPermisos(boolean flgPermisos) {
		this.flgPermisos = flgPermisos;
	}
	public long getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(long numAbonado) {
		this.numAbonado = numAbonado;
	}
	public long getNumSolicitudEval() {
		return numSolicitudEval;
	}
	public void setNumSolicitudEval(long numSolicitudEval) {
		this.numSolicitudEval = numSolicitudEval;
	}
	
	
}
