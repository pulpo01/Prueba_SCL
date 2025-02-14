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

public class OOSSXAbonadoDTO implements Serializable
{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String codOOSS;

	private String desValor;

	private String descripcion;

	public String getCodOOSS()
	{
		return codOOSS;
	}

	public void setCodOOSS(String codOOSS)
	{
		this.codOOSS = codOOSS;
	}

	public String getDescripcion()
	{
		return descripcion;
	}

	public void setDescripcion(String descripcion)
	{
		this.descripcion = descripcion;
	}

	public String getDesValor()
	{
		return desValor;
	}

	public void setDesValor(String desValor)
	{
		this.desValor = desValor;
	}

}