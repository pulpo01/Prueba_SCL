/**
 * Copyright © 2009 Telefonica Moviles, Soluciones y Aplicaciones, S.A.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informacion propietaria y confidencial de T-mAs S.A.
 * Usted no debe develar tal informacion y solo debe usarla en concordancia
 * con los terminos de derechos de licencias que sean adquiridos con T-mAs S.A.
 */
package com.tmmas.scl.wsportal.common.dto;

import java.io.Serializable;

public class ParametrosKioscoDTO implements Serializable
{
	private static final long serialVersionUID = 1L;

	private String flagKiosco;
	private String dominioKiosco;
	private String codError;
	private String desError;

	public String getFlagKiosco() {
		return flagKiosco;
	}

	public void setFlagKiosco(String flagKiosco) {
		this.flagKiosco = flagKiosco;
	}

	public String getDominioKiosco() {
		return dominioKiosco;
	}

	public void setDominioKiosco(String dominioKiosco) {
		this.dominioKiosco = dominioKiosco;
	}

	public String getCodError() {
		return codError;
	}

	public void setCodError(String codError) {
		this.codError = codError;
	}

	public String getDesError() {
		return desError;
	}

	public void setDesError(String desError) {
		this.desError = desError;
	}


}
