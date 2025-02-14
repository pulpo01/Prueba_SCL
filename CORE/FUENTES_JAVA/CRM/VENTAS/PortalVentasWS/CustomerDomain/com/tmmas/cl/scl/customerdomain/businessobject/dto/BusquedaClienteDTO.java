package com.tmmas.cl.scl.customerdomain.businessobject.dto;

import java.io.Serializable;

public class BusquedaClienteDTO implements Serializable
{

	private static final long serialVersionUID = 1L;

	private String codCliente;

	private String codTipoIdentificacion;

	private String numIdentificacion;

	private String codTipoCliente;

	private String numTelefono;

	private String nombreCliente;

	private String primerApellido;

	private String segundoApellido;

	private String nombreEmpresa;

	public String getCodCliente()
	{
		return codCliente;
	}

	public void setCodCliente(String codCliente)
	{
		this.codCliente = codCliente;
	}

	public String getCodTipoCliente()
	{
		return codTipoCliente;
	}

	public void setCodTipoCliente(String codTipoCliente)
	{
		this.codTipoCliente = codTipoCliente;
	}

	public String getCodTipoIdentificacion()
	{
		return codTipoIdentificacion;
	}

	public void setCodTipoIdentificacion(String codTipoIdentificacion)
	{
		this.codTipoIdentificacion = codTipoIdentificacion;
	}

	public String getNombreCliente()
	{
		return nombreCliente;
	}

	public void setNombreCliente(String nombreCliente)
	{
		this.nombreCliente = nombreCliente;
	}

	public String getNombreEmpresa()
	{
		return nombreEmpresa;
	}

	public void setNombreEmpresa(String nombreEmpresa)
	{
		this.nombreEmpresa = nombreEmpresa;
	}

	public String getNumIdentificacion()
	{
		return numIdentificacion;
	}

	public void setNumIdentificacion(String numIdentificacion)
	{
		this.numIdentificacion = numIdentificacion;
	}

	public String getNumTelefono()
	{
		return numTelefono;
	}

	public void setNumTelefono(String numTelefono)
	{
		this.numTelefono = numTelefono;
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

}
