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

public class GetDocsClienteINDTO implements Serializable
{

	private static final long serialVersionUID = 1L;

	private Long codCliente;

	private String fecInicio;

	private String fecFin;

	public Long getCodCliente()
	{
		return codCliente;
	}

	public void setCodCliente(Long codCliente)
	{
		this.codCliente = codCliente;
	}

	public String getFecFin()
	{
		return fecFin;
	}

	public void setFecFin(String fecFin)
	{
		this.fecFin = fecFin;
	}

	public String getFecInicio()
	{
		return fecInicio;
	}

	public void setFecInicio(String fecInicio)
	{
		this.fecInicio = fecInicio;
	}

} // DocCtaCteClienteDTO
