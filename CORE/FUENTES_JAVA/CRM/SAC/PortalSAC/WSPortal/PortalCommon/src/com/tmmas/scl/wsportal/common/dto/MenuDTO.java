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

public class MenuDTO implements Serializable
{

	private static final long serialVersionUID = 1L;

	private OOSSXUsuarioDTO[] arrayOOSSXUsuario;

	private OOSSXClienteDTO[] arrayOOSSXCliente;

	private OOSSXCuentaDTO[] arrayOOSSXCuenta;

	private OOSSXAbonadoDTO[] arrayOOSSXAbonado;

	private String nombreOperador;

	private String oficina;

	private String codUsuario;

	private String codError;

	private String desError;

	public String getNombreOperador()
	{
		return nombreOperador;
	}

	public void setNombreOperador(String nombreOperador)
	{
		this.nombreOperador = nombreOperador;
	}

	public String getOficina()
	{
		return oficina;
	}

	public void setOficina(String oficina)
	{
		this.oficina = oficina;
	}

	public MenuDTO()
	{

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

	public OOSSXAbonadoDTO[] getArrayOOSSXAbonado()
	{
		return arrayOOSSXAbonado;
	}

	public void setArrayOOSSXAbonado(OOSSXAbonadoDTO[] arrayOOSSXAbonado)
	{
		this.arrayOOSSXAbonado = arrayOOSSXAbonado;
	}

	public OOSSXClienteDTO[] getArrayOOSSXCliente()
	{
		return arrayOOSSXCliente;
	}

	public void setArrayOOSSXCliente(OOSSXClienteDTO[] arrayOOSSXCliente)
	{
		this.arrayOOSSXCliente = arrayOOSSXCliente;
	}

	public OOSSXCuentaDTO[] getArrayOOSSXCuenta()
	{
		return arrayOOSSXCuenta;
	}

	public void setArrayOOSSXCuenta(OOSSXCuentaDTO[] arrayOOSSXCuenta)
	{
		this.arrayOOSSXCuenta = arrayOOSSXCuenta;
	}

	public OOSSXUsuarioDTO[] getArrayOOSSXUsuario()
	{
		return arrayOOSSXUsuario;
	}

	public void setArrayOOSSXUsuario(OOSSXUsuarioDTO[] arrayOOSSXUsuario)
	{
		this.arrayOOSSXUsuario = arrayOOSSXUsuario;
	}

	public String getCodUsuario()
	{
		return codUsuario;
	}

	public void setCodUsuario(String codUsuario)
	{
		this.codUsuario = codUsuario;
	}

}
