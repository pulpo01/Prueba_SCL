package com.tmmas.cl.scl.frameworkcargossrv.service.dto;


import java.sql.Date;

import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosReglaDTO;

public class ParametrosReglasSSAdelantadoDTO extends ParametrosReglaDTO{
	private static final long serialVersionUID = 1L;
	private String codigoPlanTarifOrigen;
	private String codigoPlanTarifDestino;
	private String codigoProducto;
	private String codigoTecnologia;
	private String codigoModulo;
	private String nombreParametro1;
	private String nombreParametro2;
	private String codCausaCambioPlan;
	private Date fechaAceptacionVenta;
	private String tipoCargo1;
	private String tipoCargo4;
	private long codClienteOrig;
	private long codClienteDes;
	private String nombreClaseDescuento;
	private String tipoSegOrigen;
	private String tipoSegDestino;
	private String codSegOrigen;
	private String codSegDestino;
	private String numAbonado;
	private String gedCodigoTipoCargoSegm;
	private String codOS;
	private String tipoPantalla;
	private String codPlanServ;
	
	
	
	public String getCodPlanServ() {
		return codPlanServ;
	}
	public void setCodPlanServ(String codPlanServ) {
		this.codPlanServ = codPlanServ;
	}
	public String getTipoPantalla() {
		return tipoPantalla;
	}
	public void setTipoPantalla(String tipoPantalla) {
		this.tipoPantalla = tipoPantalla;
	}
	public String getCodOS() {
		return codOS;
	}
	public void setCodOS(String codOS) {
		this.codOS = codOS;
	}
	public String getGedCodigoTipoCargoSegm() {
		return gedCodigoTipoCargoSegm;
	}
	public void setGedCodigoTipoCargoSegm(String gedCodigoTipoCargoSegm) {
		this.gedCodigoTipoCargoSegm = gedCodigoTipoCargoSegm;
	}
	public String getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(String numAbonado) {
		this.numAbonado = numAbonado;
	}
	public String getNombreClaseDescuento() {
		return nombreClaseDescuento;
	}
	public void setNombreClaseDescuento(String nombreClaseDescuento) {
		this.nombreClaseDescuento = nombreClaseDescuento;
	}
	public String getTipoCargo1() {
		return tipoCargo1;
	}
	public void setTipoCargo1(String tipoCargo1) {
		this.tipoCargo1 = tipoCargo1;
	}
	public String getTipoCargo4() {
		return tipoCargo4;
	}
	public void setTipoCargo4(String tipoCargo4) {
		this.tipoCargo4 = tipoCargo4;
	}
	public String getCodigoModulo() {
		return codigoModulo;
	}
	public void setCodigoModulo(String codigoModulo) {
		this.codigoModulo = codigoModulo;
	}
	public String getCodigoProducto() {
		return codigoProducto;
	}
	public void setCodigoProducto(String codigoProducto) {
		this.codigoProducto = codigoProducto;
	}
	public String getCodigoTecnologia() {
		return codigoTecnologia;
	}
	public void setCodigoTecnologia(String codigoTecnologia) {
		this.codigoTecnologia = codigoTecnologia;
	}
	public String getCodigoPlanTarifDestino() {
		return codigoPlanTarifDestino;
	}
	public void setCodigoPlanTarifDestino(String codigoPlanTarifDestino) {
		this.codigoPlanTarifDestino = codigoPlanTarifDestino;
	}
	public String getCodigoPlanTarifOrigen() {
		return codigoPlanTarifOrigen;
	}
	public void setCodigoPlanTarifOrigen(String codigoPlanTarifOrigen) {
		this.codigoPlanTarifOrigen = codigoPlanTarifOrigen;
	}
	public String getNombreParametro1() {
		return nombreParametro1;
	}
	public void setNombreParametro1(String nombreParametro1) {
		this.nombreParametro1 = nombreParametro1;
	}
	public String getNombreParametro2() {
		return nombreParametro2;
	}
	public void setNombreParametro2(String nombreParametro2) {
		this.nombreParametro2 = nombreParametro2;
	}
	public String getCodCausaCambioPlan() {
		return codCausaCambioPlan;
	}
	public void setCodCausaCambioPlan(String codCausaCambioPlan) {
		this.codCausaCambioPlan = codCausaCambioPlan;
	}
	public Date getFechaAceptacionVenta() {
		return fechaAceptacionVenta;
	}
	public void setFechaAceptacionVenta(Date fechaAceptacionVenta) {
		this.fechaAceptacionVenta = fechaAceptacionVenta;
	}
	public long getCodClienteDes() {
		return codClienteDes;
	}
	public void setCodClienteDes(long codClienteDes) {
		this.codClienteDes = codClienteDes;
	}
	public long getCodClienteOrig() {
		return codClienteOrig;
	}
	public void setCodClienteOrig(long codClienteOrig) {
		this.codClienteOrig = codClienteOrig;
	}
	public String getCodSegDestino() {
		return codSegDestino;
	}
	public void setCodSegDestino(String codSegDestino) {
		this.codSegDestino = codSegDestino;
	}
	public String getCodSegOrigen() {
		return codSegOrigen;
	}
	public void setCodSegOrigen(String codSegOrigen) {
		this.codSegOrigen = codSegOrigen;
	}
	public String getTipoSegDestino() {
		return tipoSegDestino;
	}
	public void setTipoSegDestino(String tipoSegDestino) {
		this.tipoSegDestino = tipoSegDestino;
	}
	public String getTipoSegOrigen() {
		return tipoSegOrigen;
	}
	public void setTipoSegOrigen(String tipoSegOrigen) {
		this.tipoSegOrigen = tipoSegOrigen;
	}
	

}
