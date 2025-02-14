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
 * 04/04/2007     Héctor Hermosilla      					Versión Inicial
 */

package com.tmmas.cl.scl.crmcommon.commonapp.dto;

import java.io.Serializable;

public class DescuentoDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	private float monto;
	private String tipo;
	private String codigoConcepto;
	private String descripcionConcepto;
	private float minDescuento;
	private float maxDescuento;
	private boolean aprobacion;
	private String tipoAplicacion;
	private String codMoneda;
	
	public String getCodMoneda() {
		return codMoneda;
	}
	public void setCodMoneda(String codMoneda) {
		this.codMoneda = codMoneda;
	}
	public boolean isAprobacion() {
		return aprobacion;
	}
	public void setAprobacion(boolean aprobacion) {
		this.aprobacion = aprobacion;
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
	public String getTipo() {
		return tipo;
	}
	public void setTipo(String tipo) {
		this.tipo = tipo;
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
	public float getMonto() {
		return monto;
	}
	public void setMonto(float monto) {
		this.monto = monto;
	}
	public String getTipoAplicacion() {
		return tipoAplicacion;
	}
	public void setTipoAplicacion(String tipoAplicacion) {
		this.tipoAplicacion = tipoAplicacion;
	}

}
