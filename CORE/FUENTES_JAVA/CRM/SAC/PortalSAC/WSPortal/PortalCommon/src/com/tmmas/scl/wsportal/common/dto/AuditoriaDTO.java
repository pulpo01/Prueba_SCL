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

public class AuditoriaDTO implements Serializable
{
	private static final long serialVersionUID = 1L;

	private String codEvento;

	private String nomUsuarioSCL;

	private Long numCelular;

	private Long numAbonado;

	private Long codCliente;

	private Long codCuenta;

	public AuditoriaDTO()
	{
		super();
		this.numCelular = new Long(0);
		this.numAbonado = new Long(0);
		this.codCliente = new Long(0);
		this.codCuenta = new Long(0);
	}

	public String getCodEvento()
	{
		return codEvento;
	}

	public void setCodEvento(String codEvento)
	{
		this.codEvento = codEvento;
	}

	public String getNomUsuarioSCL()
	{
		return nomUsuarioSCL;
	}

	public void setNomUsuarioSCL(String nomUsuarioSCL)
	{
		this.nomUsuarioSCL = nomUsuarioSCL;
	}

	public void setNumCelular(Long numCelular)
	{
		this.numCelular = numCelular;
	}

	public Long getNumCelular()
	{
		return numCelular;
	}

	public void setNumAbonado(Long numAbonado)
	{
		this.numAbonado = numAbonado;
	}

	public Long getNumAbonado()
	{
		return numAbonado;
	}

	public void setCodCliente(Long codCliente)
	{
		this.codCliente = codCliente;
	}

	public Long getCodCliente()
	{
		return codCliente;
	}

	public void setCodCuenta(Long codCuenta)
	{
		this.codCuenta = codCuenta;
	}

	public Long getCodCuenta()
	{
		return codCuenta;
	}

}
