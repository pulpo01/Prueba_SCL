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
 * 21/11/2007     			 Daniel Sagredo           		Versión Inicial
 */
package com.tmmas.scl.framework.customerDomain.dataTransferObject;

import java.io.Serializable;

public class CausaExcepcionDTO implements Serializable{
	private static final long serialVersionUID = 1L;
	private int codCausa;
	private String desCausa;
	public int getCodCausa() {
		return codCausa;
	}
	public void setCodCausa(int codCausa) {
		this.codCausa = codCausa;
	}
	public String getDesCausa() {
		return desCausa;
	}
	public void setDesCausa(String desCausa) {
		this.desCausa = desCausa;
	}
}
