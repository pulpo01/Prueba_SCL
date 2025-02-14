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
 * 11/08/2007     			 Elizabeth Vera              		Versión Inicial
 */
package com.tmmas.scl.framework.productDomain.dataTransferObject;

import java.io.Serializable;

public class CausaBajaListDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private CausaBajaDTO[] causas;

	public CausaBajaDTO[] getCausas() {
		return causas;
	}

	public void setCausas(CausaBajaDTO[] causas) {
		this.causas = causas;
	}
}
