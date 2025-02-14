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
 * 20/03/2007     Héctor Hermosilla     					Versión Inicial
 */
package com.tmmas.cl.scl.resourcedomain.businessobject.dto;

import java.io.Serializable;

public class CeldaDTO implements Serializable{
	private static final long serialVersionUID = 1L;
	private String codigoCelda;
	private String descripcionCelda;
	private String codSubAlm;
	private String central;
	private String codigoProducto;
	private String codigoPrestacion;
	
	public String getCodigoPrestacion() {
		return codigoPrestacion;
	}
	public void setCodigoPrestacion(String codigoPrestacion) {
		this.codigoPrestacion = codigoPrestacion;
	}
	public String getCodigoProducto() {
		return codigoProducto;
	}
	public void setCodigoProducto(String codigoProducto) {
		this.codigoProducto = codigoProducto;
	}
	public String getCodigoCelda() {
		return codigoCelda;
	}
	public void setCodigoCelda(String codigoCelda) {
		this.codigoCelda = codigoCelda;
	}
	public String getCentral() {
		return central;
	}
	public void setCentral(String central) {
		this.central = central;
	}
	public String getCodSubAlm() {
		return codSubAlm;
	}
	public void setCodSubAlm(String codSubAlm) {
		this.codSubAlm = codSubAlm;
	}
	public String getDescripcionCelda() {
		return descripcionCelda;
	}
	public void setDescripcionCelda(String descripcionCelda) {
		this.descripcionCelda = descripcionCelda;
	}
}
