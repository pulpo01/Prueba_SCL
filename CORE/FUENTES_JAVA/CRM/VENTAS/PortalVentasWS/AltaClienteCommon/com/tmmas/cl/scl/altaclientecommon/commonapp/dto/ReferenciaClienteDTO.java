package com.tmmas.cl.scl.altaclientecommon.commonapp.dto;

import java.io.Serializable;

public class ReferenciaClienteDTO implements Serializable
{

	private static final long serialVersionUID = 1L;

	private long codigoCliente;

	private long numeroReferencia;

	private String nomCliente;

	private String apellido1;

	private String apellido2;

	private long telefonoReferenciaFijo;

	private long telefonoReferenciaMovil;

	private String nomUsuario;

	public String getApellido1()
	{
		return apellido1;
	}

	public void setApellido1(String apellido1)
	{
		this.apellido1 = apellido1;
	}

	public String getApellido2()
	{
		return apellido2;
	}

	public void setApellido2(String apellido2)
	{
		this.apellido2 = apellido2;
	}

	public long getCodigoCliente()
	{
		return codigoCliente;
	}

	public void setCodigoCliente(long codigoCliente)
	{
		this.codigoCliente = codigoCliente;
	}

	public String getNomCliente()
	{
		return nomCliente;
	}

	public void setNomCliente(String nomCliente)
	{
		this.nomCliente = nomCliente;
	}

	public String getNomUsuario()
	{
		return nomUsuario;
	}

	public void setNomUsuario(String nomUsuario)
	{
		this.nomUsuario = nomUsuario;
	}

	public long getNumeroReferencia()
	{
		return numeroReferencia;
	}

	public void setNumeroReferencia(long numeroReferencia)
	{
		this.numeroReferencia = numeroReferencia;
	}

	public long getTelefonoReferenciaFijo()
	{
		return telefonoReferenciaFijo;
	}

	public void setTelefonoReferenciaFijo(long telefono)
	{
		this.telefonoReferenciaFijo = telefono;
	}

	public long getTelefonoReferenciaMovil()
	{
		return telefonoReferenciaMovil;
	}

	public void setTelefonoReferenciaMovil(long telefonoReferenciaMovil)
	{
		this.telefonoReferenciaMovil = telefonoReferenciaMovil;
	}

}// fin class ReferenciaClienteDTO
