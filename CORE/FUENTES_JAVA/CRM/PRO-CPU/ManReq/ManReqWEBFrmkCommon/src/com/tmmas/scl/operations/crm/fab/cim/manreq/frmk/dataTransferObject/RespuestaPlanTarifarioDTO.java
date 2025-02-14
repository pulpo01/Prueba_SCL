package com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject;

import java.io.Serializable;

public class RespuestaPlanTarifarioDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private String mensaje;
	private String codMensaje;
	private long codTipMensaje;
	private String codPlanTarif;
	private String desPlanTarif;
	private String codLimiteConsumo;
	private String desLimiteConsumo;
	private String codCargoBasico;
	private String desCargoBasico;
	private float  impCargoBasico;
	private int numDias;
	private String tipPlanTarif;
	private float impLimiteConsumo;
	private int cantidadAbonadosPermitidos;
	private long numFrecFijos;
	private long numFrecMovil;
	private int indFf;
	private int numFrecIng;
	
	public int getCantidadAbonadosPermitidos() {
		return cantidadAbonadosPermitidos;
	}
	public void setCantidadAbonadosPermitidos(int cantidadAbonadosPermitidos) {
		this.cantidadAbonadosPermitidos = cantidadAbonadosPermitidos;
	}
	public String getCodCargoBasico() {
		return codCargoBasico;
	}
	public void setCodCargoBasico(String codCargoBasico) {
		this.codCargoBasico = codCargoBasico;
	}
	public String getCodLimiteConsumo() {
		return codLimiteConsumo;
	}
	public void setCodLimiteConsumo(String codLimiteConsumo) {
		this.codLimiteConsumo = codLimiteConsumo;
	}
	public String getCodMensaje() {
		return codMensaje;
	}
	public void setCodMensaje(String codMensaje) {
		this.codMensaje = codMensaje;
	}
	public String getCodPlanTarif() {
		return codPlanTarif;
	}
	public void setCodPlanTarif(String codPlanTarif) {
		this.codPlanTarif = codPlanTarif;
	}
	public long getCodTipMensaje() {
		return codTipMensaje;
	}
	public void setCodTipMensaje(long codTipMensaje) {
		this.codTipMensaje = codTipMensaje;
	}
	public String getDesCargoBasico() {
		return desCargoBasico;
	}
	public void setDesCargoBasico(String desCargoBasico) {
		this.desCargoBasico = desCargoBasico;
	}
	public String getDesLimiteConsumo() {
		return desLimiteConsumo;
	}
	public void setDesLimiteConsumo(String desLimiteConsumo) {
		this.desLimiteConsumo = desLimiteConsumo;
	}
	public String getDesPlanTarif() {
		return desPlanTarif;
	}
	public void setDesPlanTarif(String desPlanTarif) {
		this.desPlanTarif = desPlanTarif;
	}
	public float getImpCargoBasico() {
		return impCargoBasico;
	}
	public void setImpCargoBasico(float impCargoBasico) {
		this.impCargoBasico = impCargoBasico;
	}
	public float getImpLimiteConsumo() {
		return impLimiteConsumo;
	}
	public void setImpLimiteConsumo(float impLimiteConsumo) {
		this.impLimiteConsumo = impLimiteConsumo;
	}
	public int getNumDias() {
		return numDias;
	}
	public void setNumDias(int numDias) {
		this.numDias = numDias;
	}
	public String getTipPlanTarif() {
		return tipPlanTarif;
	}
	public void setTipPlanTarif(String tipPlanTarif) {
		this.tipPlanTarif = tipPlanTarif;
	}
	public String getMensaje() {
		return mensaje;
	}
	public void setMensaje(String mensaje) {
		this.mensaje = mensaje;
	}
	public int getIndFf() {
		return indFf;
	}
	public void setIndFf(int indFf) {
		this.indFf = indFf;
	}
	public long getNumFrecFijos() {
		return numFrecFijos;
	}
	public void setNumFrecFijos(long numFrecFijos) {
		this.numFrecFijos = numFrecFijos;
	}
	public int getNumFrecIng() {
		return numFrecIng;
	}
	public void setNumFrecIng(int numFrecIng) {
		this.numFrecIng = numFrecIng;
	}
	public long getNumFrecMovil() {
		return numFrecMovil;
	}
	public void setNumFrecMovil(long numFrecMovil) {
		this.numFrecMovil = numFrecMovil;
	}
	
	
	
}
