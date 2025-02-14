package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class CargosManualesDTO implements Serializable{
		
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String claseProducto; // 1 bien 2 servicio
	private String codigoArticulo;
	private String numAbonado;
	private String numSerie;
	private String numTerminal;
	private String tipoProducto;
	private String codigoConcepto;
	private String monto;
	private String cicloFacturacion;
	private String cuotas;
	private String ind_equipo;
	private String ind_paquete;
	private String cantidad;
	private String codigoMoneda;
	
	
	
	public String getCantidad() {
		return cantidad;
	}
	public void setCantidad(String cantidad) {
		this.cantidad = cantidad;
	}
	public String getCicloFacturacion() {
		return cicloFacturacion;
	}
	public void setCicloFacturacion(String cicloFacturacion) {
		this.cicloFacturacion = cicloFacturacion;
	}
	public String getClaseProducto() {
		return claseProducto;
	}
	public void setClaseProducto(String claseProducto) {
		this.claseProducto = claseProducto;
	}
	public String getCodigoArticulo() {
		return codigoArticulo;
	}
	public void setCodigoArticulo(String codigoArticulo) {
		this.codigoArticulo = codigoArticulo;
	}
	public String getCodigoConcepto() {
		return codigoConcepto;
	}
	public void setCodigoConcepto(String codigoConcepto) {
		this.codigoConcepto = codigoConcepto;
	}
	public String getCodigoMoneda() {
		return codigoMoneda;
	}
	public void setCodigoMoneda(String codigoMoneda) {
		this.codigoMoneda = codigoMoneda;
	}
	public String getCuotas() {
		return cuotas;
	}
	public void setCuotas(String cuotas) {
		this.cuotas = cuotas;
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
	public String getMonto() {
		return monto;
	}
	public void setMonto(String monto) {
		this.monto = monto;
	}
	public String getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(String numAbonado) {
		this.numAbonado = numAbonado;
	}
	public String getNumSerie() {
		return numSerie;
	}
	public void setNumSerie(String numSerie) {
		this.numSerie = numSerie;
	}
	public String getNumTerminal() {
		return numTerminal;
	}
	public void setNumTerminal(String numTerminal) {
		this.numTerminal = numTerminal;
	}
	public String getTipoProducto() {
		return tipoProducto;
	}
	public void setTipoProducto(String tipoProducto) {
		this.tipoProducto = tipoProducto;
	}
	
	
	
	
	

}
