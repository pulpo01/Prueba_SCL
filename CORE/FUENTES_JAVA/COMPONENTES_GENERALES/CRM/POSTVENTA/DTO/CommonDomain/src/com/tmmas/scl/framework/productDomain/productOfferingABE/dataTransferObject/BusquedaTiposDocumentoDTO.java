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
 * 12/07/2007     			 Cristian Toledo              		Versión Inicial
 */
package com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject;

import java.io.Serializable;

public class BusquedaTiposDocumentoDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	private long codCliente;
	private String indAgente;
	private String indSituacion;
	private int codProducto;
	private String codAmiCiclo;
	private String codModulo;
	
	public String getCodAmiCiclo() {
		return codAmiCiclo;
	}
	public void setCodAmiCiclo(String codAmiCiclo) {
		this.codAmiCiclo = codAmiCiclo;
	}
	public long getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(long codCliente) {
		this.codCliente = codCliente;
	}
	public String getCodModulo() {
		return codModulo;
	}
	public void setCodModulo(String codModulo) {
		this.codModulo = codModulo;
	}
	public int getCodProducto() {
		return codProducto;
	}
	public void setCodProducto(int codProducto) {
		this.codProducto = codProducto;
	}
	public String getIndAgente() {
		return indAgente;
	}
	public void setIndAgente(String indAgente) {
		this.indAgente = indAgente;
	}
	public String getIndSituacion() {
		return indSituacion;
	}
	public void setIndSituacion(String indSituacion) {
		this.indSituacion = indSituacion;
	}
}
