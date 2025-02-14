package com.tmmas.scl.framework.customerDomain.dataTransferObject;

import java.io.Serializable;

public class DescuentoDTO implements Serializable{

	private static final long serialVersionUID = 1L;
	private float monto;
	private String tipo;
	private String codigoConceptoCargo;
	private String codigoConcepto;
	private String descripcionConcepto;
	private float minDescuento;
	private float maxDescuento;
	private boolean aprobacion;
	private String tipoAplicacion;
	private float montoCalculado;
	private String codigoMoneda;
	private String numTransaccion;
	
	public String getNumTransaccion() {
		return numTransaccion;
	}
	public void setNumTransaccion(String numTransaccion) {
		this.numTransaccion = numTransaccion;
	}
	public String getCodigoMoneda() {
		return codigoMoneda;
	}
	public void setCodigoMoneda(String codMoneda) {
		this.codigoMoneda = codMoneda;
	}
	public float getMontoCalculado() {
		return montoCalculado;
	}
	public void setMontoCalculado(float montoCalculado) {
		this.montoCalculado = montoCalculado;
	}
	public boolean isAprobacion() {
		return aprobacion;
	}
	public void setAprobacion(boolean aprobacion) {
		this.aprobacion = aprobacion;
	}
	public String getCodigoConcepto() {
		return codigoConcepto;
	}
	public void setCodigoConcepto(String codigoConcepto) {
		this.codigoConcepto = codigoConcepto;
	}
	public String getDescripcionConcepto() {
		return descripcionConcepto;
	}
	public void setDescripcionConcepto(String descripcionConcepto) {
		this.descripcionConcepto = descripcionConcepto;
	}
	public float getMaxDescuento() {
		return maxDescuento;
	}
	public void setMaxDescuento(float maxDescuento) {
		this.maxDescuento = maxDescuento;
	}
	public float getMinDescuento() {
		return minDescuento;
	}
	public void setMinDescuento(float minDescuento) {
		this.minDescuento = minDescuento;
	}
	public float getMonto() {
		return monto;
	}
	public void setMonto(float monto) {
		this.monto = monto;
	}
	public String getTipo() {
		return tipo;
	}
	public void setTipo(String tipo) {
		this.tipo = tipo;
	}
	public String getTipoAplicacion() {
		return tipoAplicacion;
	}
	public void setTipoAplicacion(String tipoAplicacion) {
		this.tipoAplicacion = tipoAplicacion;
	}
	public String getCodigoConceptoCargo() {
		return codigoConceptoCargo;
	}
	public void setCodigoConceptoCargo(String codigoConceptoCargo) {
		this.codigoConceptoCargo = codigoConceptoCargo;
	}
	
	
	
}
