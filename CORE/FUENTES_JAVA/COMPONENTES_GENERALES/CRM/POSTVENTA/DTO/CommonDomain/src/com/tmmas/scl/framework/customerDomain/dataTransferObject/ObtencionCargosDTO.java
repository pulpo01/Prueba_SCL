package com.tmmas.scl.framework.customerDomain.dataTransferObject;

import java.io.Serializable;

public class ObtencionCargosDTO implements Serializable{
	
	private static final long serialVersionUID = 1L;
	private float monto;
	private String tipo;
	private String codigoConcepto;
	private String descripcionConcepto;
	private float minDescuento;
	private float maxDescuento;
	private boolean aprobacion;
	private String tipoAplicacion;
	private CargosDTO[] cargos;
	private String numAbonado;
		
	
	public String getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(String numAbonado) {
		this.numAbonado = numAbonado;
	}
	public CargosDTO[] getCargos() {
		return cargos;
	}
	public void setCargos(CargosDTO[] cargos) {
		this.cargos = cargos;
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
	
	
}
