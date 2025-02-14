package com.tmmas.cl.scl.altacliente.presentacion.dto;

import java.io.Serializable;

public class CuentaAjaxDTO implements Serializable
{

	/**
	 * 
	 */
	private static final long serialVersionUID = 4661961838613641219L;

	private String codigoCuenta;

	private String codigoTipoIdentificacion;

	private String numeroIdentificacion;

	private String tipoCuenta;

	private String nombreResponsable;

	private String nombreCuenta;

	private String telefonoContacto;

	private String glsTipoCuenta;

	public String getGlsTipoCuenta()
	{
		return glsTipoCuenta;
	}

	public void setGlsTipoCuenta(String glsTipoCliente)
	{
		this.glsTipoCuenta = glsTipoCliente;
	}

	public String getCodigoCuenta()
	{
		return codigoCuenta;
	}

	public void setCodigoCuenta(String codigoCliente)
	{
		this.codigoCuenta = codigoCliente;
	}

	public String getCodigoTipoIdentificacion()
	{
		return codigoTipoIdentificacion;
	}

	public void setCodigoTipoIdentificacion(String codigoTipoIdentificacion)
	{
		this.codigoTipoIdentificacion = codigoTipoIdentificacion;
	}

	public String getNombreResponsable()
	{
		return nombreResponsable;
	}

	public void setNombreResponsable(String nombreCliente)
	{
		this.nombreResponsable = nombreCliente;
	}

	public String getNumeroIdentificacion()
	{
		return numeroIdentificacion;
	}

	public void setNumeroIdentificacion(String numeroIdentificacion)
	{
		this.numeroIdentificacion = numeroIdentificacion;
	}

	public String getTelefonoContacto()
	{
		return telefonoContacto;
	}

	public void setTelefonoContacto(String numeroTelefono1)
	{
		this.telefonoContacto = numeroTelefono1;
	}

	public String getTipoCuenta()
	{
		return tipoCuenta;
	}

	public void setTipoCuenta(String tipoCliente)
	{
		this.tipoCuenta = tipoCliente;
	}

	public String getNombreCuenta()
	{
		return nombreCuenta;
	}

	public void setNombreCuenta(String nombreCuenta)
	{
		this.nombreCuenta = nombreCuenta;
	}

}
