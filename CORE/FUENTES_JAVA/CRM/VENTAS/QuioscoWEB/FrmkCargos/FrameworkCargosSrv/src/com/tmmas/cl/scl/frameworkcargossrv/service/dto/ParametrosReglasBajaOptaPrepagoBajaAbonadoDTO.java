package com.tmmas.cl.scl.frameworkcargossrv.service.dto;

import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosReglaDTO;

public class ParametrosReglasBajaOptaPrepagoBajaAbonadoDTO extends ParametrosReglaDTO{
	private static final long serialVersionUID = 1L;
	
	
	private long cod_Producto;
	private String cod_Actabo;
	private String cod_TipServ;
	private String cod_PlanServ;
	private String cod_Penaliza;
	private String ind_Causa;
	private String cod_ModVenta;
	private String cod_Causa;
	private String mod_Pago;
	private String cod_EstadoDev;
	private boolean codEstDev_D;
	private String ind_Comodato; 
	private boolean indComodato;
	private String equipCargador;
	private boolean equipCargador_N;
	private String cod_Modulo;
	private String codPlanComercial;
	private String codCargoBasico;
	private String numAbonado;

	
	
	
	public String getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(String numAbonado) {
		this.numAbonado = numAbonado;
	}
	public String getCod_Actabo() {
		return cod_Actabo;
	}
	public void setCod_Actabo(String cod_Actabo) {
		this.cod_Actabo = cod_Actabo;
	}
	public String getCod_Causa() {
		return cod_Causa;
	}
	public void setCod_Causa(String cod_Causa) {
		this.cod_Causa = cod_Causa;
	}
	public String getCod_EstadoDev() {
		return cod_EstadoDev;
	}
	public void setCod_EstadoDev(String cod_EstadoDev) {
		this.cod_EstadoDev = cod_EstadoDev;
	}
	public String getCod_Modulo() {
		return cod_Modulo;
	}
	public void setCod_Modulo(String cod_Modulo) {
		this.cod_Modulo = cod_Modulo;
	}
	public String getCod_ModVenta() {
		return cod_ModVenta;
	}
	public void setCod_ModVenta(String cod_ModVenta) {
		this.cod_ModVenta = cod_ModVenta;
	}
	public String getCod_Penaliza() {
		return cod_Penaliza;
	}
	public void setCod_Penaliza(String cod_Penaliza) {
		this.cod_Penaliza = cod_Penaliza;
	}
	public String getCod_PlanServ() {
		return cod_PlanServ;
	}
	public void setCod_PlanServ(String cod_PlanServ) {
		this.cod_PlanServ = cod_PlanServ;
	}
	public long getCod_Producto() {
		return cod_Producto;
	}
	public void setCod_Producto(long cod_Producto) {
		this.cod_Producto = cod_Producto;
	}
	public String getCod_TipServ() {
		return cod_TipServ;
	}
	public void setCod_TipServ(String cod_TipServ) {
		this.cod_TipServ = cod_TipServ;
	}
	public String getCodCargoBasico() {
		return codCargoBasico;
	}
	public void setCodCargoBasico(String codCargoBasico) {
		this.codCargoBasico = codCargoBasico;
	}
	public String getCodPlanComercial() {
		return codPlanComercial;
	}
	public void setCodPlanComercial(String codPlanComercial) {
		this.codPlanComercial = codPlanComercial;
	}
	public String getEquipCargador() {
		return equipCargador;
	}
	public void setEquipCargador(String equipCargador) {
		this.equipCargador = equipCargador;
	}
	public String getInd_Causa() {
		return ind_Causa;
	}
	public void setInd_Causa(String ind_Causa) {
		this.ind_Causa = ind_Causa;
	}
	public String getInd_Comodato() {
		return ind_Comodato;
	}
	public void setInd_Comodato(String ind_Comodato) {
		this.ind_Comodato = ind_Comodato;
	}
	public String getMod_Pago() {
		return mod_Pago;
	}
	public void setMod_Pago(String mod_Pago) {
		this.mod_Pago = mod_Pago;
	}
	public boolean isCodEstDev_D() {
		return codEstDev_D;
	}
	public void setCodEstDev_D(boolean codEstDev_D) {
		this.codEstDev_D = codEstDev_D;
	}
	public boolean isIndComodato() {
		return indComodato;
	}
	public void setIndComodato(boolean indComodato) {
		this.indComodato = indComodato;
	}
	public boolean isEquipCargador_N() {
		return equipCargador_N;
	}
	public void setEquipCargador_N(boolean equipCargador_N) {
		this.equipCargador_N = equipCargador_N;
	}
}
