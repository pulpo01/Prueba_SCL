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
 * 14/05/2007     Héctor Hermosilla      					Versión Inicial
 */
package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class WsListArticuloVendedorOutDTO extends RetornoDTO implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private WsArticuloVendedorOutDTO[] wsArticuloVendedorArrOutDTO;

	public WsArticuloVendedorOutDTO[] getWsArticuloVendedorArrOutDTO() {
		return wsArticuloVendedorArrOutDTO;
	}

	public void setWsArticuloVendedorArrOutDTO(
			WsArticuloVendedorOutDTO[] wsArticuloVendedorArrOutDTO) {
		this.wsArticuloVendedorArrOutDTO = wsArticuloVendedorArrOutDTO;
	}
}
