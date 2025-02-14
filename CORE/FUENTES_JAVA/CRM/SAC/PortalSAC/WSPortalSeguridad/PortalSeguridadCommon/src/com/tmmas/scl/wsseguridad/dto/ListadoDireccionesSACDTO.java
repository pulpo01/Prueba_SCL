package com.tmmas.scl.wsseguridad.dto;

import java.io.Serializable;

public class ListadoDireccionesSACDTO implements Serializable
{

	private static final long serialVersionUID = 1080055402373842569L;

	private DireccionSACDTO[] arrayDirecciones;

	private String codError;

	private String desError;

	public DireccionSACDTO[] getArrayDirecciones()
	{
		return arrayDirecciones;
	}

	public void setArrayDirecciones(DireccionSACDTO[] direcciones)
	{
		this.arrayDirecciones = direcciones;
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
