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
 * 14/05/2007     Héctor Hermosilla      					Versión Inicial
 */
package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class WsArticuloVendedorOutDTO implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private long  codArticulo;
	private String desArticulo;
	private String codModelo;
	private long cantStock;
	private int codBodega;
	private int cantReservada;
	public int getCantReservada() {
		return cantReservada;
	}
	public void setCantReservada(int cantReservada) {
		this.cantReservada = cantReservada;
	}
	public long getCantStock() {
		return cantStock;
	}
	public void setCantStock(long cantStock) {
		this.cantStock = cantStock;
	}
	public long getCodArticulo() {
		return codArticulo;
	}
	public void setCodArticulo(long codArticulo) {
		this.codArticulo = codArticulo;
	}
	public int getCodBodega() {
		return codBodega;
	}
	public void setCodBodega(int codBodega) {
		this.codBodega = codBodega;
	}
	public String getCodModelo() {
		return codModelo;
	}
	public void setCodModelo(String codModelo) {
		this.codModelo = codModelo;
	}
	public String getDesArticulo() {
		return desArticulo;
	}
	public void setDesArticulo(String desArticulo) {
		this.desArticulo = desArticulo;
	}
}
