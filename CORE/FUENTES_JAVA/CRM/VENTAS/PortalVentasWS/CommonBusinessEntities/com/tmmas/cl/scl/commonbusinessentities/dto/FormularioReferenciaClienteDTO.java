package com.tmmas.cl.scl.commonbusinessentities.dto;

import java.io.Serializable;

public class FormularioReferenciaClienteDTO implements Serializable
{
	private static final long serialVersionUID = -146735027062601810L;

	private String numReferencia;

	private String nombreReferencia;

	private String primerApellido;

	private String segundoApellido;

	private String telefonoReferenciaFijo;

	private String telefonoReferenciaMovil;

	public String getTelefonoReferenciaMovil()
	{
		return telefonoReferenciaMovil;
	}

	public void setTelefonoReferenciaMovil(String telefonoReferenciaMovil)
	{
		this.telefonoReferenciaMovil = telefonoReferenciaMovil;
	}

	public String getNombreReferencia()
	{
		return nombreReferencia;
	}

	public void setNombreReferencia(String nombreReferencia)
	{
		this.nombreReferencia = nombreReferencia;
	}

	public String getNumReferencia()
	{
		return numReferencia;
	}

	public void setNumReferencia(String numReferencia)
	{
		this.numReferencia = numReferencia;
	}

	public String getPrimerApellido()
	{
		return primerApellido;
	}

	public void setPrimerApellido(String primerApellido)
	{
		this.primerApellido = primerApellido;
	}

	public String getSegundoApellido()
	{
		return segundoApellido;
	}

	public void setSegundoApellido(String segundoApellido)
	{
		this.segundoApellido = segundoApellido;
	}

	public String getTelefonoReferenciaFijo()
	{
		return telefonoReferenciaFijo;
	}

	public void setTelefonoReferenciaFijo(String telefono)
	{
		this.telefonoReferenciaFijo = telefono;
	}

}