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
 * 11/04/2007     Wildo Ramos      					Versión Inicial
 */

package com.tmmas.cl.scl.frameworkcargossrv.service.dto;



import java.sql.Date;

import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosReglaDTO;

public class ParametrosReglasAbonadoCeroDTO extends ParametrosReglaDTO {
	
	private static final long serialVersionUID = 1L;
	
	private String codigoModulo;
	private String nombreTabla;
	private String nombreColumna;
	private Date fechaVigenciaAbonadoCero;
	private long codigoProducto;
	
	
	public long getCodigoProducto() {
		return codigoProducto;
	}
	public void setCodigoProducto(long codigoProducto) {
		this.codigoProducto = codigoProducto;
	}
	public Date getFechaVigenciaAbonadoCero() {
		return fechaVigenciaAbonadoCero;
	}
	public void setFechaVigenciaAbonadoCero(Date fechaVigenciaAbonadoCero) {
		this.fechaVigenciaAbonadoCero = fechaVigenciaAbonadoCero;
	}
	public String getCodigoModulo() {
		return codigoModulo;
	}
	public void setCodigoModulo(String codigoModulo) {
		this.codigoModulo = codigoModulo;
	}
	public String getNombreColumna() {
		return nombreColumna;
	}
	public void setNombreColumna(String nombreColumna) {
		this.nombreColumna = nombreColumna;
	}
	public String getNombreTabla() {
		return nombreTabla;
	}
	public void setNombreTabla(String nombreTabla) {
		this.nombreTabla = nombreTabla;
	}

	
}
