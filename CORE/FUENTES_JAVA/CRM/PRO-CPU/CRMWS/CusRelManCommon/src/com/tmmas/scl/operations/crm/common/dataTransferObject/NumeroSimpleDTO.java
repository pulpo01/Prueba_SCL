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
 * 22-06-2007     			 Cristian Toledo              		Versión Inicial
 */

package com.tmmas.scl.operations.crm.common.dataTransferObject;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.Calendar;
import java.util.Date;

public class NumeroSimpleDTO implements Serializable
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String idProductoContratado;
	private String nro;
	private String codCategoriaDest;
	private String desCategoria;
	private String fecInicioVigencia;
	private String fecTerminoVigencia;
	private String numProceso;
	public String getCodCategoriaDest() {
		return codCategoriaDest;
	}
	public void setCodCategoriaDest(String codCategoriaDest) {
		this.codCategoriaDest = codCategoriaDest;
	}
	public String getDesCategoria() {
		return desCategoria;
	}
	public void setDesCategoria(String desCategoria) {
		this.desCategoria = desCategoria;
	}
	public String getFecInicioVigencia() {
		return fecInicioVigencia;
	}
	public void setFecInicioVigencia(String fecInicioVigencia) {
		this.fecInicioVigencia = fecInicioVigencia;
	}
	public String getFecTerminoVigencia() {
		return fecTerminoVigencia;
	}
	public void setFecTerminoVigencia(String fecTerminoVigencia) {
		this.fecTerminoVigencia = fecTerminoVigencia;
	}
	public String getIdProductoContratado() {
		return idProductoContratado;
	}
	public void setIdProductoContratado(String idProductoContratado) {
		this.idProductoContratado = idProductoContratado;
	}
	public String getNro() {
		return nro;
	}
	public void setNro(String nro) {
		this.nro = nro;
	}
	public String getNumProceso() {
		return numProceso;
	}
	public void setNumProceso(String numProceso) {
		this.numProceso = numProceso;
	}
	
}
