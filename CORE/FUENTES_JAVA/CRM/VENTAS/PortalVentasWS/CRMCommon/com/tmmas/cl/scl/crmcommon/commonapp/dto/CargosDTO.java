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

public class CargosDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	private String idProducto;
	private int cantidad;
	private PrecioDTO precio;
	private DescuentoDTO[] descuento;
	private AtributosCargoDTO atributo;
	
	private Long num_terminal;
	private Long num_abonado;	
	
	
	public DescuentoDTO[] getDescuento() {
		return descuento;
	}
	
	public void setDescuento(DescuentoDTO[] descuento) {
		this.descuento = descuento;
	}
	
	public PrecioDTO getPrecio() {
		return precio;
	}
	
	public void setPrecio(PrecioDTO precio) {
		this.precio = precio;
	}
	
	public int getCantidad() {
		return cantidad;
	}
	
	public void setCantidad(int cantidad) {
		this.cantidad = cantidad;
	}
	
	public String getIdProducto() {
		return idProducto;
	}
	
	public void setIdProducto(String idProducto) {
		this.idProducto = idProducto;
	}
	
	public AtributosCargoDTO getAtributo() {
		return atributo;
	}
	
	public void setAtributo(AtributosCargoDTO atributo) {
		this.atributo = atributo;
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
