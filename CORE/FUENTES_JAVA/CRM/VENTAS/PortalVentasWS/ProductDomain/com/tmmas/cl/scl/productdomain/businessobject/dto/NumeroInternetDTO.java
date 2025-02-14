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


public class NumeroInternetDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private String numero;
	private String codOperadorMin;
	private String procedencia;
	private long codCliente;
	private String rowId;
	
	
	public long getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(long codCliente) {
		this.codCliente = codCliente;
	}
	public String getCodOperadorMin() {
		return codOperadorMin;
	}
	public void setCodOperadorMin(String codOperadorMin) {
		this.codOperadorMin = codOperadorMin;
	}
	public String getNumero() {
		return numero;
	}
	public void setNumero(String numero) {
		this.numero = numero;
	}
	public String getProcedencia() {
		return procedencia;
	}
	public void setProcedencia(String procedencia) {
		this.procedencia = procedencia;
	}
	public String getRowId() {
		return rowId;
	}
	public void setRowId(String rowId) {
		this.rowId = rowId;
	}
	
	
}
