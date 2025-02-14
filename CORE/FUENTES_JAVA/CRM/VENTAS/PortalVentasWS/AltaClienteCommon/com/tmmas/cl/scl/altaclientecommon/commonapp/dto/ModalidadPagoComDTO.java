/**
 * Copyright © 2006 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 09/01/2007     Héctor Hermosilla      					Versión Inicial
 */
package com.tmmas.cl.scl.altaclientecommon.commonapp.dto;

import java.io.Serializable;

import com.tmmas.cl.scl.commonbusinessentities.dto.ProgramaDTO;

public class ModalidadPagoComDTO  implements Serializable{
	
	
	private static final long serialVersionUID = 1L;
	private String codigoModalidadPago;
	private String descripcionModalidadPago;
	private String usuarioArchivo;
	private String vendedorArchivo;
	private String tipoContrato;
	private String meses;
	private String indicadorCuotas;
	private ProgramaDTO datosPrograma;
	private int codigoProducto;
	private String codigoOperacion;
	
	private int indicadorManual;
	
	public String getCodigoOperacion() {
		return codigoOperacion;
	}
	public void setCodigoOperacion(String codigoOperacion) {
		this.codigoOperacion = codigoOperacion;
	}
	public int getCodigoProducto() {
		return codigoProducto;
	}
	public void setCodigoProducto(int codigoProducto) {
		this.codigoProducto = codigoProducto;
	}
	public String getIndicadorCuotas() {
		return indicadorCuotas;
	}
	public void setIndicadorCuotas(String indicadorCuotas) {
		this.indicadorCuotas = indicadorCuotas;
	}
	public String getMeses() {
		return meses;
	}
	public void setMeses(String meses) {
		this.meses = meses;
	}
	public String getTipoContrato() {
		return tipoContrato;
	}
	public void setTipoContrato(String tipoContrato) {
		this.tipoContrato = tipoContrato;
	}
	public String getCodigoModalidadPago(){
		return codigoModalidadPago;
	}
	public void setCodigoModalidadPago(String codigoModalidadPago){
		this.codigoModalidadPago = codigoModalidadPago;
	}
	public String getDescripcionModalidadPago(){
		return descripcionModalidadPago;
	}
	
	public void setDescripcionModalidadPago(String descripcionModalidadPago){
		this.descripcionModalidadPago = descripcionModalidadPago;
	}
	public String getUsuarioArchivo() {
		return usuarioArchivo;
	}
	public void setUsuarioArchivo(String usuarioArchivo) {
		this.usuarioArchivo = usuarioArchivo;
	}
	public String getVendedorArchivo() {
		return vendedorArchivo;
	}
	public void setVendedorArchivo(String vendedorArchivo) {
		this.vendedorArchivo = vendedorArchivo;
	}
	public ProgramaDTO getDatosPrograma() {
		return datosPrograma;
	}
	public void setDatosPrograma(ProgramaDTO datosPrograma) {
		this.datosPrograma = datosPrograma;
	}
	public int getIndicadorManual() {
		return indicadorManual;
	}
	public void setIndicadorManual(int indicadorManual) {
		this.indicadorManual = indicadorManual;
	}
	
}
