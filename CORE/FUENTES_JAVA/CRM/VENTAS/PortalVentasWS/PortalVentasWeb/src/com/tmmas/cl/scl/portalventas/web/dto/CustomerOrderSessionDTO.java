package com.tmmas.cl.scl.portalventas.web.dto;

import java.io.Serializable;

public class CustomerOrderSessionDTO implements Serializable {
    private static final long serialVersionUID = 1L;
    private long code;
    private String names;
    private String lastName1;
    private String lastName2;
    private String codePlanRate;
    private String desPlanRate;
    private long numeroAbonado;
    private long numeroCelular;
    private long numeroOrdenServicio;
    private long ordenServicio;
    private long freeUnits;
    private String measuredUnit;
    private String codePlanRateAbonado;
    private String desPlanRateAbonado;
    private SecurityDTO security;
    private boolean datosdeCliente;
    private String forward;
    private String userName;
	public long getCode() {
		return code;
	}
	public void setCode(long code) {
		this.code = code;
	}
	public String getCodePlanRate() {
		return codePlanRate;
	}
	public void setCodePlanRate(String codePlanRate) {
		this.codePlanRate = codePlanRate;
	}
	public String getCodePlanRateAbonado() {
		return codePlanRateAbonado;
	}
	public void setCodePlanRateAbonado(String codePlanRateAbonado) {
		this.codePlanRateAbonado = codePlanRateAbonado;
	}
	public boolean isDatosdeCliente() {
		return datosdeCliente;
	}
	public void setDatosdeCliente(boolean datosdeCliente) {
		this.datosdeCliente = datosdeCliente;
	}
	public String getDesPlanRate() {
		return desPlanRate;
	}
	public void setDesPlanRate(String desPlanRate) {
		this.desPlanRate = desPlanRate;
	}
	public String getDesPlanRateAbonado() {
		return desPlanRateAbonado;
	}
	public void setDesPlanRateAbonado(String desPlanRateAbonado) {
		this.desPlanRateAbonado = desPlanRateAbonado;
	}
	public String getForward() {
		return forward;
	}
	public void setForward(String forward) {
		this.forward = forward;
	}
	public long getFreeUnits() {
		return freeUnits;
	}
	public void setFreeUnits(long freeUnits) {
		this.freeUnits = freeUnits;
	}
	public String getLastName1() {
		return lastName1;
	}
	public void setLastName1(String lastName1) {
		this.lastName1 = lastName1;
	}
	public String getLastName2() {
		return lastName2;
	}
	public void setLastName2(String lastName2) {
		this.lastName2 = lastName2;
	}
	public String getMeasuredUnit() {
		return measuredUnit;
	}
	public void setMeasuredUnit(String measuredUnit) {
		this.measuredUnit = measuredUnit;
	}
	public String getNames() {
		return names;
	}
	public void setNames(String names) {
		this.names = names;
	}
	public long getNumeroAbonado() {
		return numeroAbonado;
	}
	public void setNumeroAbonado(long numeroAbonado) {
		this.numeroAbonado = numeroAbonado;
	}
	public long getNumeroCelular() {
		return numeroCelular;
	}
	public void setNumeroCelular(long numeroCelular) {
		this.numeroCelular = numeroCelular;
	}
	public long getNumeroOrdenServicio() {
		return numeroOrdenServicio;
	}
	public void setNumeroOrdenServicio(long numeroOrdenServicio) {
		this.numeroOrdenServicio = numeroOrdenServicio;
	}
	public long getOrdenServicio() {
		return ordenServicio;
	}
	public void setOrdenServicio(long ordenServicio) {
		this.ordenServicio = ordenServicio;
	}
	public SecurityDTO getSecurity() {
		return security;
	}
	public void setSecurity(SecurityDTO security) {
		this.security = security;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
}
