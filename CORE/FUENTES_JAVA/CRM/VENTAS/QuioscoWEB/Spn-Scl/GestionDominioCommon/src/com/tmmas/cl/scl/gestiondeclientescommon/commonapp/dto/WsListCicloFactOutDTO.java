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
 * 07/08/2007     			 Elizabeth Vera              		Versión Inicial
 */
package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class WsListCicloFactOutDTO extends RetornoDTO implements Serializable {
	private static final long serialVersionUID = 1L;

	private WsCicloFactOutDTO[] wsCicloFactArrOutDTO;
	private String resultadoTransaccion="0";

	public String getResultadoTransaccion() {
		return resultadoTransaccion;
	}

	public void setResultadoTransaccion(String resultadoTransaccion) {
		this.resultadoTransaccion = resultadoTransaccion;
	}

	public WsCicloFactOutDTO[] getWsCicloFactArrOutDTO() {
		return wsCicloFactArrOutDTO;
	}

	public void setWsCicloFactArrOutDTO(WsCicloFactOutDTO[] wsCicloFactArrOutDTO) {
		this.wsCicloFactArrOutDTO = wsCicloFactArrOutDTO;
	}


}
