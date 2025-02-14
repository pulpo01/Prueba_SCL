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
 * 29/03/2007     Héctor Hermosilla      			Versión Inicial
 */
package com.tmmas.cl.scl.crmcommon.commonapp.dto;

import java.io.Serializable;

public class ResultadoValidacionDTO implements Serializable{
	
	
	private static final long serialVersionUID = 1L;
	private boolean resultado;
	private String estado;
	private String detalleEstado;
	private String numeroCelular;
	private int resultadoBase;
	private boolean bDireccionLinea;//Si es verdadero al crear la linea toma la dirección ingresada por el usuario en caso
	//contrario toma la dirección de la oficina del vendedor	
	private String codigoError;
	
	
	public int getResultadoBase() {
		return resultadoBase;
	}
	public void setResultadoBase(int resultadoBase) {
		this.resultadoBase = resultadoBase;
	}
	public String getDetalleEstado() {
		return detalleEstado;
	}
	public void setDetalleEstado(String detalleEstado) {
		this.detalleEstado = detalleEstado;
	}
	public String getEstado() {
		return estado;
	}
	public void setEstado(String estado) {
		this.estado = estado;
	}
	public boolean isResultado() {
		return resultado;
	}
	public void setResultado(boolean resultado) {
		this.resultado = resultado;
	}
	public String getNumeroCelular() {
		return numeroCelular;
	}
	public void setNumeroCelular(String numeroCelular) {
		this.numeroCelular = numeroCelular;
	}
	public boolean isBDireccionLinea() {
		return bDireccionLinea;
	}
	public void setBDireccionLinea(boolean direccionLinea) {
		bDireccionLinea = direccionLinea;
	}
	public String getCodigoError() {
		return codigoError;
	}
	public void setCodigoError(String codigoError) {
		this.codigoError = codigoError;
	}
	

}
