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

public class EstadoDTO implements Serializable
{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -6938316986983871454L;

	private String codEstado;

	private String desEstado;


	
	public String getCodEstado() {
		return codEstado;
	}


	public void setCodEstado(String codEstado) {
		this.codEstado = codEstado;
	}



	public String getDesEstado() {
		return desEstado;
	}



	public void setDesEstado(String desEstado) {
		this.desEstado = desEstado;
	}



	public String toXml()
	{
		StringBuffer b = new StringBuffer();
		b.append("<EstadoDTO>");
		b.append("<codEstado>");
		b.append(getCodEstado());
		b.append("</codEstado>");
		b.append("<desEstado>");
		b.append(getDesEstado());
		b.append("</desEstado>");
		b.append("</EstadoDTO>");
		return b.toString();
	}
}
