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

public class DetalleCuentaDTO implements Serializable
{

	private static final long serialVersionUID = 1L;

	private Long codCuenta;

	private String desCuenta;

	private String nomResponsable;

	private String desTipIdent;

	private String numIdent;

	private String fecAlta;

	private String tipCuenta;

	private String desCategoria;

	private Long telContacto;

	private String codError;

	private String desError;

	private Long totClientes;

	public Long getTotClientes()
	{
		return totClientes;
	}

	public void setTotClientes(Long totClientes)
	{
		this.totClientes = totClientes;
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

	public String getDesCuenta()
	{
		return desCuenta;
	}

	public void setDesCuenta(String desCuenta)
	{
		this.desCuenta = desCuenta;
	}

	public String getFecAlta()
	{
		return fecAlta;
	}

	public void setFecAlta(String fecAlta)
	{
		this.fecAlta = fecAlta;
	}

	public String getTipCuenta()
	{
		return tipCuenta;
	}

	public void setTipCuenta(String tipCuenta)
	{
		this.tipCuenta = tipCuenta;
	}

	public Long getCodCuenta()
	{
		return codCuenta;
	}

	public void setCodCuenta(Long codCuenta)
	{
		this.codCuenta = codCuenta;
	}

	public String getDesCategoria()
	{
		return desCategoria;
	}

	public void setDesCategoria(String desCategoria)
	{
		this.desCategoria = desCategoria;
	}

	public String getDesTipIdent()
	{
		return desTipIdent;
	}

	public void setDesTipIdent(String desTipIdent)
	{
		this.desTipIdent = desTipIdent;
	}

	public String getNomResponsable()
	{
		return nomResponsable;
	}

	public void setNomResponsable(String nomResponsable)
	{
		this.nomResponsable = nomResponsable;
	}

	public String getNumIdent()
	{
		return numIdent;
	}

	public void setNumIdent(String numIdent)
	{
		this.numIdent = numIdent;
	}

	public Long getTelContacto()
	{
		return telContacto;
	}

	public void setTelContacto(Long telContacto)
	{
		this.telContacto = telContacto;
	}

}
