/**
 * Copyright © 2009 Telefonica Moviles, Soluciones y Aplicaciones, S.A.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informacion propietaria y confidencial de T-mAs S.A.
 * Usted no debe develar tal informacion y solo debe usarla en concordancia
 * con los terminos de derechos de licencias que sean adquiridos con T-mAs S.A.
 */

package com.tmmas.scl.wsseguridad.dto;

import com.tmmas.scl.wsportal.common.exception.PortalSACException;

public class CargaOSGenericaDTO
{
	private String codError;

	private String desError;

	public CargaOSGenericaDTO()
	{

	}

	public CargaOSGenericaDTO(PortalSACException pe)
	{
		this.setCodError(pe.getCodigo());
		this.setDesError(pe.getMessage());
	}

	public String getCodError()
	{
		return codError;
	}

	public String getDesError()
	{
		return desError;
	}

	public void setCodError(String codError)
	{
		this.codError = codError;
	}

	public void setDesError(String desError)
	{
		this.desError = desError;
	}

}
