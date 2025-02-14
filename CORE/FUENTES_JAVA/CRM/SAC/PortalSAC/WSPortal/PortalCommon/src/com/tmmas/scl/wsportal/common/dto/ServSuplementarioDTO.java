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

public class ServSuplementarioDTO implements Serializable
{
	private static final long serialVersionUID = 7885307770689633405L;

	private Long numAbonado;

	private String codServicio;

	private String desServicio;

	private String fecAltaBD;

	private String fecAltaCEN;

	private String desConcepto;

	private Double impTarifa;

	private String aplica;

	public String getCodServicio()
	{
		return codServicio;
	}

	public void setCodServicio(String codServicio)
	{
		this.codServicio = codServicio;
	}

	public String getDesConcepto()
	{
		return desConcepto;
	}

	public void setDesConcepto(String desConcepto)
	{
		this.desConcepto = desConcepto;
	}

	public String getDesServicio()
	{
		return desServicio;
	}

	public void setDesServicio(String desServicio)
	{
		this.desServicio = desServicio;
	}

	public String getFecAltaBD()
	{
		return fecAltaBD;
	}

	public void setFecAltaBD(String fecAltaBD)
	{
		this.fecAltaBD = fecAltaBD;
	}

	public String getFecAltaCEN()
	{
		return fecAltaCEN;
	}

	public void setFecAltaCEN(String fecAltaCEN)
	{
		this.fecAltaCEN = fecAltaCEN;
	}

	public Double getImpTarifa()
	{
		return impTarifa;
	}

	public void setImpTarifa(Double impTarifa)
	{
		this.impTarifa = impTarifa;
	}

	public Long getNumAbonado()
	{
		return numAbonado;
	}

	public void setNumAbonado(Long numAbonado)
	{
		this.numAbonado = numAbonado;
	}

	public final String getAplica()
	{
		return aplica;
	}

	public final void setAplica(String aplica)
	{
		this.aplica = aplica;
	}

}
