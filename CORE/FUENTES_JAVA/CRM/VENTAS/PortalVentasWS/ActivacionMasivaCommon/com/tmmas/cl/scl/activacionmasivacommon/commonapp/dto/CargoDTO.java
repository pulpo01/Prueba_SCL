/**
 * Copyright © 2007 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 12/03/2007     Héctor Hermosilla             			Versión Inicial
 */
package com.tmmas.cl.scl.activacionmasivacommon.commonapp.dto;

import java.io.Serializable;


public class CargoDTO implements Serializable{
	private static final long serialVersionUID = 1L;
	
	private int tipoProducto;
	private String idProducto;
	private int cantidad;
	private String codigoDescuento;
	private String descripcionDescuento;
	private String tipoDescuento;
	private float montoDescuento;
	private int descuentoManual;
	private String tipoDescuentoManual;
	private float montoDescuentoManual;
	private String codigoConceptoPrecio;
	private String descripcionConceptoPrecio;
	private String clase;
	private String codigoMoneda;
	private float montoConceptoPrecio;
	private float montoConceptoTotal;
	private float saldoUnitario;
	private float saldoTotal;
	private String descripcionMoneda;
	private String ind_paquete;
	private String ind_cuota;
	private String ind_equipo;
	private String cod_tecnologia;
	private String codigoArticuloServicio;
	private String tipoCargo;
	
	private Long num_terminal;
	private Long num_abonado;
	private String num_serie;	
	private String cod_bodega;
	private long numCargo;
	
	private boolean habilitaDescuento;
	private String infringeRangoDescuento;
	private int esCobroAdelantado=0;
	private int tipoServicioCobroAdelantado;
	
	private String codigoMonedaDescuento;
	
	public String getCodigoMonedaDescuento() {
		return codigoMonedaDescuento;
	}
	public void setCodigoMonedaDescuento(String codigoMonedaDescuento) {
		this.codigoMonedaDescuento = codigoMonedaDescuento;
	}
	public int getTipoServicioCobroAdelantado() {
		return tipoServicioCobroAdelantado;
	}
	public void setTipoServicioCobroAdelantado(int tipoServicioCobroAdelantado) {
		this.tipoServicioCobroAdelantado = tipoServicioCobroAdelantado;
	}
	public int getEsCobroAdelantado() {
		return esCobroAdelantado;
	}
	public void setEsCobroAdelantado(int esCobroAdelantado) {
		this.esCobroAdelantado = esCobroAdelantado;
	}
	public String getInfringeRangoDescuento() {
		return infringeRangoDescuento;
	}
	public void setInfringeRangoDescuento(String infringeRangoDescuento) {
		this.infringeRangoDescuento = infringeRangoDescuento;
	}
	public boolean isHabilitaDescuento() {
		return habilitaDescuento;
	}
	public void setHabilitaDescuento(boolean habilitaDescuento) {
		this.habilitaDescuento = habilitaDescuento;
	}
	public String getCodigoArticuloServicio() {
		return codigoArticuloServicio;
	}
	public void setCodigoArticuloServicio(String codigoArticuloServicio) {
		this.codigoArticuloServicio = codigoArticuloServicio;
	}
	public String getCod_tecnologia() {
		return cod_tecnologia;
	}
	public void setCod_tecnologia(String cod_tecnologia) {
		this.cod_tecnologia = cod_tecnologia;
	}
	public String getInd_cuota() {
		return ind_cuota;
	}
	public void setInd_cuota(String ind_cuota) {
		this.ind_cuota = ind_cuota;
	}
	public String getInd_equipo() {
		return ind_equipo;
	}
	public void setInd_equipo(String ind_equipo) {
		this.ind_equipo = ind_equipo;
	}
	public String getInd_paquete() {
		return ind_paquete;
	}
	public void setInd_paquete(String ind_paquete) {
		this.ind_paquete = ind_paquete;
	}
	public int getCantidad() {
		return cantidad;
	}
	public void setCantidad(int cantidad) {
		this.cantidad = cantidad;
	}
	public String getCodigoConceptoPrecio() {
		return codigoConceptoPrecio;
	}
	public void setCodigoConceptoPrecio(String codigoConceptoPrecio) {
		this.codigoConceptoPrecio = codigoConceptoPrecio;
	}
	public String getCodigoDescuento() {
		return codigoDescuento;
	}
	public void setCodigoDescuento(String codigoDescuento) {
		this.codigoDescuento = codigoDescuento;
	}
	public String getDescripcionConceptoPrecio() {
		return descripcionConceptoPrecio;
	}
	public void setDescripcionConceptoPrecio(String descripcionConceptoPrecio) {
		this.descripcionConceptoPrecio = descripcionConceptoPrecio;
	}
	public String getDescripcionDescuento() {
		return descripcionDescuento;
	}
	public void setDescripcionDescuento(String descripcionDescuento) {
		this.descripcionDescuento = descripcionDescuento;
	}
	public String getIdProducto() {
		return idProducto;
	}
	public void setIdProducto(String idProducto) {
		this.idProducto = idProducto;
	}
	public float getMontoConceptoPrecio() {
		return montoConceptoPrecio;
	}
	public void setMontoConceptoPrecio(float montoConceptoPrecio) {
		this.montoConceptoPrecio = montoConceptoPrecio;
	}
	public float getMontoDescuento() {
		return montoDescuento;
	}
	public void setMontoDescuento(float montoDescuento) {
		this.montoDescuento = montoDescuento;
	}
	public String getTipoDescuento() {
		return tipoDescuento;
	}
	public void setTipoDescuento(String tipoDescuento) {
		this.tipoDescuento = tipoDescuento;
	}
	public int getTipoProducto() {
		return tipoProducto;
	}
	public void setTipoProducto(int tipoProducto) {
		this.tipoProducto = tipoProducto;
	}
	public String getClase() {
		return clase;
	}
	public void setClase(String clase) {
		this.clase = clase;
	}
	public float getMontoConceptoTotal() {
		return montoConceptoTotal;
	}
	public void setMontoConceptoTotal(float montoConceptoTotal) {
		this.montoConceptoTotal = montoConceptoTotal;
	}
	public float getSaldoTotal() {
		return saldoTotal;
	}
	public void setSaldoTotal(float saldoTotal) {
		this.saldoTotal = saldoTotal;
	}
	public float getSaldoUnitario() {
		return saldoUnitario;
	}
	public void setSaldoUnitario(float saldoUnitario) {
		this.saldoUnitario = saldoUnitario;
	}
	public String getCodigoMoneda() {
		return codigoMoneda;
	}
	public void setCodigoMoneda(String moneda) {
		this.codigoMoneda = moneda;
	}
	public String getDescripcionMoneda() {
		return descripcionMoneda;
	}
	public void setDescripcionMoneda(String descripcionMoneda) {
		this.descripcionMoneda = descripcionMoneda;
	}
	public int getDescuentoManual() {
		return descuentoManual;
	}
	public void setDescuentoManual(int descuentoManual) {
		this.descuentoManual = descuentoManual;
	}
	public float getMontoDescuentoManual() {
		return montoDescuentoManual;
	}
	public void setMontoDescuentoManual(float montoDescuentoManual) {
		this.montoDescuentoManual = montoDescuentoManual;
	}
	public String getTipoDescuentoManual() {
		return tipoDescuentoManual;
	}
	public void setTipoDescuentoManual(String tipoDescuentoManual) {
		this.tipoDescuentoManual = tipoDescuentoManual;
	}

	
	public String getTipoCargo() {
	  return tipoCargo;
	}

	public void setTipoCargo(String tipoCargo) {
	  this.tipoCargo = tipoCargo;
	}
	public Long getNum_abonado() {
		return num_abonado;
	}
	public void setNum_abonado(Long num_abonado) {
		this.num_abonado = num_abonado;
	}
	public Long getNum_terminal() {
		return num_terminal;
	}
	public void setNum_terminal(Long num_terminal) {
		this.num_terminal = num_terminal;
	}
	public String getNum_serie() {
		return num_serie;
	}
	public void setNum_serie(String num_serie) {
		this.num_serie = num_serie;
	}
	public String getCod_bodega() {
		return cod_bodega;
	}
	public void setCod_bodega(String cod_bodega) {
		this.cod_bodega = cod_bodega;
	}
	public long getNumCargo() {
		return numCargo;
	}
	public void setNumCargo(long numCargo) {
		this.numCargo = numCargo;
	}


}
