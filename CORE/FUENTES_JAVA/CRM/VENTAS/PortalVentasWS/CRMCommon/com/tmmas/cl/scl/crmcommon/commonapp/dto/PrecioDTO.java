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

import com.tmmas.cl.scl.crmcommon.commonapp.dto.AtributosMigracionDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.MonedaDTO;

public class PrecioDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	private double monto;
	private String codigoConcepto;
	private String descripcionConcepto;
	private String fechaAplicacion;
	private MonedaDTO unidad;
	private AtributosMigracionDTO datosAnexos;
	private String nroSerie;
	private String codBodega;
	private String tipoCobro;
	
	
	
	public String getTipoCobro() {
		return tipoCobro;
	}
	public void setTipoCobro(String tipoCobro) {
		this.tipoCobro = tipoCobro;
	}
	public String getCodBodega() {
		return codBodega;
	}
	public void setCodBodega(String codBodega) {
		this.codBodega = codBodega;
	}
	public String getNroSerie() {
		return nroSerie;
	}
	public void setNroSerie(String nroSerie) {
		this.nroSerie = nroSerie;
	}
	public MonedaDTO getUnidad() {
		return unidad;
	}
	public void setUnidad(MonedaDTO unidad) {
		this.unidad = unidad;
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
	public String getFechaAplicacion() {
		return fechaAplicacion;
	}
	public void setFechaAplicacion(String fechaAplicacion) {
		this.fechaAplicacion = fechaAplicacion;
	}
	public AtributosMigracionDTO getDatosAnexos() {
		return datosAnexos;
	}
	public void setDatosAnexos(AtributosMigracionDTO datosAnexos) {
		this.datosAnexos = datosAnexos;
	}
	public double getMonto() {
		return monto;
	}
	public void setMonto(double monto) {
		this.monto = monto;
	}
}
