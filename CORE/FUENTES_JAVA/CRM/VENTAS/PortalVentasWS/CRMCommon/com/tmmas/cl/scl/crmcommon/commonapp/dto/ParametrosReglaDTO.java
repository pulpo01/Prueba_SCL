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


public class ParametrosReglaDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	private String nombre;
	private String codigoEjecutivo;
	private float maxDescuento;
	private float minDescuento;
	private String codigoCliente;
	private String numProceso;
	private AtributosCargoDTO atributos;
	//No declarados en el diagrama de diseño
	/*private String codigoTecnologia;
	private String tipoCargo;
	private String idProducto;*/
	private ParametrosDescuentoDTO parametrosDescuento;
	
	private Long num_terminal;
	private Long num_abonado;
	private int tipoServicioCobroAdelantado;
	
	public int getTipoServicioCobroAdelantado() {
		return tipoServicioCobroAdelantado;
	}
	public void setTipoServicioCobroAdelantado(int tipoServicioCobroAdelantado) {
		this.tipoServicioCobroAdelantado = tipoServicioCobroAdelantado;
	}
	public ParametrosDescuentoDTO getParametrosDescuento() {
		return parametrosDescuento;
	}
	public void setParametrosDescuento(ParametrosDescuentoDTO parametrosDescuento) {
		this.parametrosDescuento = parametrosDescuento;
	}
	/*public String getIdProducto() {
		return idProducto;
	}
	public void setIdProducto(String idProducto) {
		this.idProducto = idProducto;
	}
	public String getTipoCargo() {
		return tipoCargo;
	}
	public void setTipoCargo(String tipoCargo) {
		this.tipoCargo = tipoCargo;
	}

	public String getCodigoProducto() {
		return codigoProducto;
	}
	public void setCodigoProducto(String codigoProducto) {
		this.codigoProducto = codigoProducto;
	}*/
	public String getCodigoCliente() {
		return codigoCliente;
	}
	public void setCodigoCliente(String codigoCliente) {
		this.codigoCliente = codigoCliente;
	}
	public String getCodigoEjecutivo() {
		return codigoEjecutivo;
	}
	public void setCodigoEjecutivo(String codigoEjecutivo) {
		this.codigoEjecutivo = codigoEjecutivo;
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
	public String getNombre() {
		return nombre;
	}
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	public String getNumProceso() {
		return numProceso;
	}
	public void setNumProceso(String numProceso) {
		this.numProceso = numProceso;
	}
	/*public String getCodigoTecnologia() {
		return codigoTecnologia;
	}
	public void setCodigoTecnologia(String codigoTecnologia) {
		this.codigoTecnologia = codigoTecnologia;
	}*/
	public AtributosCargoDTO getAtributos() {
		return atributos;
	}
	public void setAtributos(AtributosCargoDTO atributos) {
		this.atributos = atributos;
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

}
