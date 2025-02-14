/**
 * Copyright © 2008 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 14/07/2008 09:31     Nicol&aacute;s Contreras    		Versión Inicial 
 * 
 *
 * 
 * @author Nicolas Contreras
 * @version 1.0
 **/
package com.tmmas.cl.scl.productdomain.businessobject.dto;

import java.io.Serializable;

/**
 * @author mwn90113
 *
 */
public class SeleccionNumeroCelularDTO implements Serializable {
private static final long serialVersionUID = 5905596713255716020L;
private Long numCelular;
private String codCategoria;
private String fechaBaja;

public String getFechaBaja() {
	return fechaBaja;
}
public void setFechaBaja(String fechaBaja) {
	this.fechaBaja = fechaBaja;
}
public String getCodCategoria() {
	return codCategoria;
}
public void setCodCategoria(String codCategoria) {
	this.codCategoria = codCategoria;
}
/**
 * @return the numCelular
 */
public Long getNumCelular() {
	return numCelular;
}
/**
 * @param numCelular the numCelular to set
 */
public void setNumCelular(Long numCelular) {
	this.numCelular = numCelular;
}

}
