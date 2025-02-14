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
 * 25/10/2007     			 Fernando Mateluna                Versión Inicial
 */
package com.tmmas.scl.framework.serviceDomain.dataTransferObject;

import java.io.Serializable;


public class SaldoProductoTasacionDTO implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String codCliente;
	private String idAbonado;
	private String codProducdo;
	private String valorInicial;
	private String valorConsumido;
	private String valorDisponible;
	
	public String getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(String codCliente) {
		this.codCliente = codCliente;
	}
	public String getCodProducdo() {
		return codProducdo;
	}
	public void setCodProducdo(String codProducdo) {
		this.codProducdo = codProducdo;
	}
	public String getIdAbonado() {
		return idAbonado;
	}
	public void setIdAbonado(String idAbonado) {
		this.idAbonado = idAbonado;
	}
	public String getValorConsumido() {
		return valorConsumido;
	}
	public void setValorConsumido(String valorConsumido) {
		this.valorConsumido = valorConsumido;
	}
	public String getValorDisponible() {
		return valorDisponible;
	}
	public void setValorDisponible(String valorDisponible) {
		this.valorDisponible = valorDisponible;
	}
	public String getValorInicial() {
		return valorInicial;
	}
	public void setValorInicial(String valorInicial) {
		this.valorInicial = valorInicial;
	}
	
	
}
