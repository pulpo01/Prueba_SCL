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

public class ListadoClientesDTO implements Serializable
{

	/**
	 * 
	 */
	private static final long serialVersionUID = 8645117842815141913L;

	private ClienteDTO[] arrayClientes;

	private String codError;

	private String desError;

	public ClienteDTO[] getArrayClientes()
	{
		return arrayClientes;
	}

	public void setArrayClientes(ClienteDTO[] arrayClientes)
	{
		this.arrayClientes = arrayClientes;
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
		b.append("<clientes>");
		ClienteDTO dto = null;
		for (int i = 0; i < getArrayClientes().length; i++)
		{
			dto = (ClienteDTO) getArrayClientes()[i];
			b.append(dto.toXml());
		}
		b.append("</clientes>");
		return b.toString();
	}

}