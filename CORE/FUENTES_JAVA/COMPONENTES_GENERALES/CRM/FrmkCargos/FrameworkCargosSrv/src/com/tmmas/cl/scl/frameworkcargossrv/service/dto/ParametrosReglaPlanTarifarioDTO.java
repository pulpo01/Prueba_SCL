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

package com.tmmas.cl.scl.frameworkcargossrv.service.dto;

import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosReglaDTO;

//import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosReglaDTO;

public class ParametrosReglaPlanTarifarioDTO extends ParametrosReglaDTO {
	
	private static final long serialVersionUID = 1L;
	private String codigoPlanTarifario;
	private String codigoCargoBasico;
	private String codigoUsoLinea;
	private String codigoProducto;
	private String codigoTecnologia;
	private String indicadorCargoHabilitacion;

	public String getIndicadorCargoHabilitacion() {
		return indicadorCargoHabilitacion;
	}
	public void setIndicadorCargoHabilitacion(String indicadorCargoHabilitacion) {
		this.indicadorCargoHabilitacion = indicadorCargoHabilitacion;
	}
	public String getCodigoProducto() {
		return codigoProducto;
	}
	public void setCodigoProducto(String codigoProducto) {
		this.codigoProducto = codigoProducto;
	}
	public String getCodigoTecnologia() {
		return codigoTecnologia;
	}
	public void setCodigoTecnologia(String codigoTecnologia) {
		this.codigoTecnologia = codigoTecnologia;
	}
	public String getCodigoUsoLinea() {
		return codigoUsoLinea;
	}
	public void setCodigoUsoLinea(String codigoUsoLinea) {
		this.codigoUsoLinea = codigoUsoLinea;
	}
	public String getCodigoCargoBasico() {
		return codigoCargoBasico;
	}
	public void setCodigoCargoBasico(String codigoCargoBasico) {
		this.codigoCargoBasico = codigoCargoBasico;
	}
	public String getCodigoPlanTarifario() {
		return codigoPlanTarifario;
	}
	public void setCodigoPlanTarifario(String codigoPlanTarifario) {
		this.codigoPlanTarifario = codigoPlanTarifario;
	}

}
