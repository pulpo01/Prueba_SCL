package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class DescuentosManualesDTO implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String codigoConceptoDescuento;
	private String codigoConceptoCargo;
	private String codigoMoneda;
	private String descripcionConcepto;
	private String monto;
	private String numTransaccion;
	private String tipo;
	private String tipoAplicacion;
	
	
	public String getCodigoConceptoCargo() {
		return codigoConceptoCargo;
	}
	public void setCodigoConceptoCargo(String codigoConceptoCargo) {
		this.codigoConceptoCargo = codigoConceptoCargo;
	}
	public String getCodigoConceptoDescuento() {
		return codigoConceptoDescuento;
	}
	public void setCodigoConceptoDescuento(String codigoConceptoDescuento) {
		this.codigoConceptoDescuento = codigoConceptoDescuento;
	}
	public String getCodigoMoneda() {
		return codigoMoneda;
	}
	public void setCodigoMoneda(String codigoMoneda) {
		this.codigoMoneda = codigoMoneda;
	}
	public String getDescripcionConcepto() {
		return descripcionConcepto;
	}
	public void setDescripcionConcepto(String descripcionConcepto) {
		this.descripcionConcepto = descripcionConcepto;
	}	
	public String getMonto() {
		return monto;
	}
	public void setMonto(String monto) {
		this.monto = monto;
	}
	public String getNumTransaccion() {
		return numTransaccion;
	}
	public void setNumTransaccion(String numTransaccion) {
		this.numTransaccion = numTransaccion;
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
