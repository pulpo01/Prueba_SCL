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

public class PuebloDTO implements Serializable
{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -6938316986983871454L;

	private String codPueblo;

	private String desPueblo;

	public String getCodPueblo() {
		return codPueblo;
	}

	public void setCodPueblo(String codPueblo) {
		this.codPueblo = codPueblo;
	}

	public String getDesPueblo() {
		return desPueblo;
	}

	public void setDesPueblo(String desPueblo) {
		this.desPueblo = desPueblo;
	}


	public String toXml()
	{
		StringBuffer b = new StringBuffer();
		b.append("<PuebloDTO>");
		b.append("<codPueblo>");
		b.append(getCodPueblo());
		b.append("</codPueblo>");
		b.append("<desPueblo>");
		b.append(getDesPueblo());
		b.append("</desPueblo>");
		b.append("</PuebloDTO>");
		return b.toString();
	}
}
