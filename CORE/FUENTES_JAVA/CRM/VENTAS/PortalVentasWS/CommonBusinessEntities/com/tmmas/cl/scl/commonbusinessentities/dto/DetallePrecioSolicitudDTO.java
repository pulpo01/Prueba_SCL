package com.tmmas.cl.scl.commonbusinessentities.dto;

import java.io.Serializable;

public class DetallePrecioSolicitudDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	private String codConcepto;
	private String desConcepto;
	private float precio;
	private String codMoneda;
	private String desMoneda;
	private String codigoServicio;
	private String tipoCobro;
	
	public String getTipoCobro() {
		return tipoCobro;
	}
	public void setTipoCobro(String tipoCobro) {
		this.tipoCobro = tipoCobro;
	}
	public final String getCodigoServicio() {
		return codigoServicio;
	}
	public final void setCodigoServicio(String codigoServicio) {
		this.codigoServicio = codigoServicio;
	}
	public String getCodMoneda() {
		return codMoneda;
	}
	public void setCodMoneda(String codMoneda) {
		this.codMoneda = codMoneda;
	}
	public String getDesConcepto() {
		return desConcepto;
	}
	public void setDesConcepto(String desConcepto) {
		this.desConcepto = desConcepto;
	}
	public float getPrecio() {
		return precio;
	}
	public void setPrecio(float precio) {
		this.precio = precio;
	}
	public String getCodConcepto() {
		return codConcepto;
	}
	public void setCodConcepto(String codConcepto) {
		this.codConcepto = codConcepto;
	}
	public String getDesMoneda() {
		return desMoneda;
	}
	public void setDesMoneda(String desMoneda) {
		this.desMoneda = desMoneda;
	}
	
	
}
