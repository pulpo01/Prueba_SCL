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

public class ZipCodeDTO implements Serializable
{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	
	private String codZip;

	public String getCodZip() {
		return codZip;
	}

	public void setCodZip(String codZip) {
		this.codZip = codZip;
	}


	public String toXml()
	{
		StringBuffer b = new StringBuffer();
		b.append("<ZipCodeDTO>");
		b.append("<codZip>");
		b.append(getCodZip());
		b.append("</codZip>");
		b.append("</ZipCodeDTO>");
		return b.toString();
	}
}
