/**
 * Copyright � 2007 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal informaci�n y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 15/06/2007     H�ctor Hermosilla      					Versi�n Inicial
 */
package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;


public class WsListModalidadPagoOutDTO extends RetornoDTO implements Serializable {
	
	private static final long serialVersionUID = 1L;

	private WsModalidadPagoOutDTO[] wsModalidadPagoArrOutDTO;
	private String resultadoTransaccion="0";

	public String getResultadoTransaccion() {
		return resultadoTransaccion;
	}

	public void setResultadoTransaccion(String resultadoTransaccion) {
		this.resultadoTransaccion = resultadoTransaccion;
	}

	public WsModalidadPagoOutDTO[] getWsModalidadPagoArrOutDTO() {
		return wsModalidadPagoArrOutDTO;
	}

	public void setWsModalidadPagoArrOutDTO(
			WsModalidadPagoOutDTO[] wsModalidadPagoArrOutDTO) {
		this.wsModalidadPagoArrOutDTO = wsModalidadPagoArrOutDTO;
	}

}
