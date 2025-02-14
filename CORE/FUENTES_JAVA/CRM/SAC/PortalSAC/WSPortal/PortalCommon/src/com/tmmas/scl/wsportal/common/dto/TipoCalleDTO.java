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

public class TipoCalleDTO implements Serializable
{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -6938316986983871454L;

	private String codTipoCalle;

	private String desTipoCalle;


	public String getCodTipoCalle() {
		return codTipoCalle;
	}
	
	public void setCodTipoCalle(String codTipoCalle) {
		this.codTipoCalle = codTipoCalle;
	}

	public String getDesTipoCalle() {
		return desTipoCalle;
	}

	public void setDesTipoCalle(String desTipoCalle) {
		this.desTipoCalle = desTipoCalle;
	}

	public String toXml()
	{
		StringBuffer b = new StringBuffer();
		b.append("<TipoCalleDTO>");
		b.append("<codTipoCalle>");
		b.append(getCodTipoCalle());
		b.append("</codTipoCalle>");
		b.append("<desTipoCalle>");
		b.append(getDesTipoCalle());
		b.append("</desTipoCalle>");
		b.append("</TipoCalleDTO>");
		return b.toString();
	}
}
