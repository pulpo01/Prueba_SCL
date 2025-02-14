package com.tmmas.scl.framework.customerDomain.dataTransferObject;
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
 * 09-08-2007     			 Esteban Conejeros              		Versión Inicial
 */


import java.io.Serializable;

public class TipIdentListDTO implements Serializable
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private TipIdentDTO tipIdentListList[];

	public TipIdentDTO[] tipIdentListList() {
		return tipIdentListList;
	}

	public void setTipIdentDTO(TipIdentDTO[] tipIdentListList) {
		this.tipIdentListList = tipIdentListList;
	}
	
}
