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

public class DetalleAbonadoDTO implements Serializable
{

	private static final long serialVersionUID = 1L;

	private Long numAbonado;

	private Long numCelular;

	private Long codUsuario;

	private String nomUsuario;

	private String codSituacion;

	private String desSituacion;

	private String codTipContrato;

	private String desTipContrato;

	private String tipoPlan;

	private String codPlanTarif;

	private String desPlanTarif;

	private String fecAlta;

	private String fecBaja;

	private String fecActCen;

	private String fecAceptVenta;

	private String fecFinContrato;

	private Long numVenta;

	private String codUso;

	private String gama;

	private String codError;

	private String desError;

	public String getCodPlanTarif()
	{
		return codPlanTarif;
	}

	public void setCodPlanTarif(String codPlanTarif)
	{
		this.codPlanTarif = codPlanTarif;
	}

	public String getCodSituacion()
	{
		return codSituacion;
	}

	public void setCodSituacion(String codSituacion)
	{
		this.codSituacion = codSituacion;
	}

	public String getCodTipContrato()
	{
		return codTipContrato;
	}

	public void setCodTipContrato(String codTipContrato)
	{
		this.codTipContrato = codTipContrato;
	}

	public Long getCodUsuario()
	{
		return codUsuario;
	}

	public void setCodUsuario(Long codUsuario)
	{
		this.codUsuario = codUsuario;
	}

	public String getDesPlanTarif()
	{
		return desPlanTarif;
	}

	public void setDesPlanTarif(String desPlanTarif)
	{
		this.desPlanTarif = desPlanTarif;
	}

	public String getDesTipContrato()
	{
		return desTipContrato;
	}

	public void setDesTipContrato(String desTipContrato)
	{
		this.desTipContrato = desTipContrato;
	}

	public String getFecAceptVenta()
	{
		return fecAceptVenta;
	}

	public void setFecAceptVenta(String fecAceptVenta)
	{
		this.fecAceptVenta = fecAceptVenta;
	}

	public String getFecFinContrato()
	{
		return fecFinContrato;
	}

	public void setFecFinContrato(String fecFinContrato)
	{
		this.fecFinContrato = fecFinContrato;
	}

	public String getTipoPlan()
	{
		return tipoPlan;
	}

	public void setTipoPlan(String tipoPlan)
	{
		this.tipoPlan = tipoPlan;
	}

	public String getDesSituacion()
	{
		return desSituacion;
	}

	public void setDesSituacion(String desSituacion)
	{
		this.desSituacion = desSituacion;
	}

	public String getFecAlta()
	{
		return fecAlta;
	}

	public void setFecAlta(String fecAlta)
	{
		this.fecAlta = fecAlta;
	}

	public String getFecBaja()
	{
		return fecBaja;
	}

	public void setFecBaja(String fecBaja)
	{
		this.fecBaja = fecBaja;
	}

	public String getNomUsuario()
	{
		return nomUsuario;
	}

	public void setNomUsuario(String nomUsuario)
	{
		this.nomUsuario = nomUsuario;
	}

	public Long getNumAbonado()
	{
		return numAbonado;
	}

	public void setNumAbonado(Long numAbonado)
	{
		this.numAbonado = numAbonado;
	}

	public Long getNumCelular()
	{
		return numCelular;
	}

	public void setNumCelular(Long numCelular)
	{
		this.numCelular = numCelular;
	}

	public Long getNumVenta()
	{
		return numVenta;
	}

	public void setNumVenta(Long numVenta)
	{
		this.numVenta = numVenta;
	}

	public String getCodUso()
	{
		return codUso;
	}

	public void setCodUso(String codUso)
	{
		this.codUso = codUso;
	}

	public String getFecActCen()
	{
		return fecActCen;
	}

	public void setFecActCen(String fecActCen)
	{
		this.fecActCen = fecActCen;
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

	public String getGama()
	{
		return gama;
	}

	public void setGama(String gama)
	{
		this.gama = gama;
	}
}
