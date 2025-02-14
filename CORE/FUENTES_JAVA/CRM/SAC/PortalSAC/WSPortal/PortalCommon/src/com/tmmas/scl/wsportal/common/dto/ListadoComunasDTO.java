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

public class ListadoComunasDTO implements Serializable
{

	
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -4964692164850100670L;

	private ComunaDTO[] arrayComunas;

	private String codError;

	private String desError;

	public ComunaDTO[] getArrayComunas()
	{
		return arrayComunas;
	}

	public void setArrayComunas(ComunaDTO[] array)
	{
		this.arrayComunas = array;
	}

	public String getCodError()
	{
		return codError;
	}

	public void setCodError(String codError)
	{
		this.codError = codError;
	}

	public String getDesError()
	{
		return desError;
	}

	public void setDesError(String desError)
	{
		this.desError = desError;
	}
	
	public String toXml()
	{
		StringBuffer b = new StringBuffer();
		b.append("<ListadoComunasDTO>");
		ComunaDTO dto = null;
		for (int i = 0; i < getArrayComunas().length; i++)
		{
			dto = (ComunaDTO) getArrayComunas()[i];
			b.append(dto.toXml());
		}
		b.append("</ListadoComunasDTO>");
		return b.toString();
	}
	

}
