package com.tmmas.scl.wsseguridad.dto;

import java.io.Serializable;

public class ListadoOrdenesServicioSACDTO implements Serializable
{

	/**
	 * 
	 */
	private static final long serialVersionUID = -3270307290112502113L;

	private ConsultarOrdenServicioSACDTO[] arrayOOSS;

	private String codError;

	private String desError;

	public ConsultarOrdenServicioSACDTO[] getArrayOOSS()
	{
		return arrayOOSS;
	}

	public void setArrayOOSS(ConsultarOrdenServicioSACDTO[] ooss)
	{
		this.arrayOOSS = ooss;
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
}
