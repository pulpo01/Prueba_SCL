package com.tmmas.cl.scl.commonbusinessentities.dto;

import java.io.Serializable;

public class CargoXMLDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private int tipoProducto;
	private String idProducto;
	private int cantidad;
	private String codigoDescuento;
	private String descripcionDescuento;
	private String tipoDescuento;
	private double montoDescuento;
	private double montoDescuentoSinImpuesto;
	private int descuentoManual;
	private String tipoDescuentoManual;
	private double montoDescuentoManual;
	private String codigoConceptoPrecio;
	private String descripcionConceptoPrecio;
	private String clase;
	private String codigoMoneda;
	private double montoConceptoPrecio;
	private double montoConceptoTotal;
	private double saldoUnitario;
	private double saldoTotal;
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
	
	public int getEsCobroAdelantado() {
		return esCobroAdelantado;
	}
	public void setEsCobroAdelantado(int esCobroAdelantado) {
		this.esCobroAdelantado = esCobroAdelantado;
	}
	public boolean isHabilitaDescuento() {
		return habilitaDescuento;
	}
	public void setHabilitaDescuento(boolean habilitaDescuento) {
		this.habilitaDescuento = habilitaDescuento;
	}
	public String getInfringeRangoDescuento() {
		return infringeRangoDescuento;
	}
	public void setInfringeRangoDescuento(String infringeRangoDescuento) {
		this.infringeRangoDescuento = infringeRangoDescuento;
	}
	public int getCantidad() {
		return cantidad;
	}
	public void setCantidad(int cantidad) {
		this.cantidad = cantidad;
	}
	public String getClase() {
		return clase;
	}
	public void setClase(String clase) {
		this.clase = clase;
	}
	public String getCod_bodega() {
		return cod_bodega;
	}
	public void setCod_bodega(String cod_bodega) {
		this.cod_bodega = cod_bodega;
	}
	public String getCod_tecnologia() {
		return cod_tecnologia;
	}
	public void setCod_tecnologia(String cod_tecnologia) {
		this.cod_tecnologia = cod_tecnologia;
	}
	public String getCodigoArticuloServicio() {
		return codigoArticuloServicio;
	}
	public void setCodigoArticuloServicio(String codigoArticuloServicio) {
		this.codigoArticuloServicio = codigoArticuloServicio;
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
	public String getCodigoMoneda() {
		return codigoMoneda;
	}
	public void setCodigoMoneda(String codigoMoneda) {
		this.codigoMoneda = codigoMoneda;
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
	public String getIdProducto() {
		return idProducto;
	}
	public void setIdProducto(String idProducto) {
		this.idProducto = idProducto;
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
	public double getMontoConceptoPrecio() {
		return montoConceptoPrecio;
	}
	public void setMontoConceptoPrecio(double montoConceptoPrecio) {
		this.montoConceptoPrecio = montoConceptoPrecio;
	}
	public double getMontoConceptoTotal() {
		return montoConceptoTotal;
	}
	public void setMontoConceptoTotal(double montoConceptoTotal) {
		this.montoConceptoTotal = montoConceptoTotal;
	}
	public double getMontoDescuento() {
		return montoDescuento;
	}
	public void setMontoDescuento(double montoDescuento) {
		this.montoDescuento = montoDescuento;
	}
	public double getMontoDescuentoManual() {
		return montoDescuentoManual;
	}
	public void setMontoDescuentoManual(double montoDescuentoManual) {
		this.montoDescuentoManual = montoDescuentoManual;
	}
	public Long getNum_abonado() {
		return num_abonado;
	}
	public void setNum_abonado(Long num_abonado) {
		this.num_abonado = num_abonado;
	}
	public String getNum_serie() {
		return num_serie;
	}
	public void setNum_serie(String num_serie) {
		this.num_serie = num_serie;
	}
	public Long getNum_terminal() {
		return num_terminal;
	}
	public void setNum_terminal(Long num_terminal) {
		this.num_terminal = num_terminal;
	}
	public long getNumCargo() {
		return numCargo;
	}
	public void setNumCargo(long numCargo) {
		this.numCargo = numCargo;
	}
	public double getSaldoTotal() {
		return saldoTotal;
	}
	public void setSaldoTotal(double saldoTotal) {
		this.saldoTotal = saldoTotal;
	}
	public double getSaldoUnitario() {
		return saldoUnitario;
	}
	public void setSaldoUnitario(double saldoUnitario) {
		this.saldoUnitario = saldoUnitario;
	}
	public String getTipoCargo() {
		return tipoCargo;
	}
	public void setTipoCargo(String tipoCargo) {
		this.tipoCargo = tipoCargo;
	}
	public String getTipoDescuento() {
		return tipoDescuento;
	}
	public void setTipoDescuento(String tipoDescuento) {
		this.tipoDescuento = tipoDescuento;
	}
	public String getTipoDescuentoManual() {
		return tipoDescuentoManual;
	}
	public void setTipoDescuentoManual(String tipoDescuentoManual) {
		this.tipoDescuentoManual = tipoDescuentoManual;
	}
	public int getTipoProducto() {
		return tipoProducto;
	}
	public void setTipoProducto(int tipoProducto) {
		this.tipoProducto = tipoProducto;
	}
	public double getMontoDescuentoSinImpuesto() {
		return montoDescuentoSinImpuesto;
	}
	public void setMontoDescuentoSinImpuesto(double montoDescuentoSinImpuesto) {
		this.montoDescuentoSinImpuesto = montoDescuentoSinImpuesto;
	}
}
