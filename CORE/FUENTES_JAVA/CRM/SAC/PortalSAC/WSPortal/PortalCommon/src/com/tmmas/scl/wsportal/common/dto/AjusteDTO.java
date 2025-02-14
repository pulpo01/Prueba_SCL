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

public class AjusteDTO implements Serializable
{

	private static final long serialVersionUID = 1L;

	private Long numSecuencia;

	private String fecEfectividad;

	private Long codTipDocum;

	private String desTipDocum;

	private Double importeDebe;

	private String factura;

	private String concepto;

	public Long getCodTipDocum()
	{
		return codTipDocum;
	}

	public void setCodTipDocum(Long codTipDocum)
	{
		this.codTipDocum = codTipDocum;
	}

	public String getDesTipDocum()
	{
		return desTipDocum;
	}

	public void setDesTipDocum(String desTipDocum)
	{
		this.desTipDocum = desTipDocum;
	}

	public String getFecEfectividad()
	{
		return fecEfectividad;
	}

	public void setFecEfectividad(String fecEfectividad)
	{
		this.fecEfectividad = fecEfectividad;
	}

	public Double getImporteDebe()
	{
		return importeDebe;
	}

	public void setImporteDebe(Double importeDebe)
	{
		this.importeDebe = importeDebe;
	}

	public Long getNumSecuencia()
	{
		return numSecuencia;
	}

	public void setNumSecuencia(Long numSecuencia)
	{
		this.numSecuencia = numSecuencia;
	}

	public String getFactura()
	{
		return factura;
	}

	public void setFactura(String factura)
	{
		this.factura = factura;
	}

	public String getConcepto()
	{
		return concepto;
	}

	public void setConcepto(String concepto)
	{
		this.concepto = concepto;
	}

}
