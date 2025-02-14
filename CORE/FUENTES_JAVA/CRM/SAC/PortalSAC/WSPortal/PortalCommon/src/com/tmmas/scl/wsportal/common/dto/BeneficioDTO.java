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

public class BeneficioDTO implements Serializable
{

	private static final long serialVersionUID = 1L;

	private Long cntPeriodos;

	private String fecIngreso;

	private String desEstado;

	private Double valAcumulado;

	private Double valBeneficio;

	private String fecEstado;

	private String desTiplan;
	
	private String codPlan;
	
	private String desPlan;

	
	//Son para el ordenamiento de la tabla
	private String fecIngresoOrd;
	private String fecEstadoOrd;
	
	
	public Long getCntPeriodos()
	{
		return cntPeriodos;
	}

	public void setCntPeriodos(Long cntPeriodos)
	{
		this.cntPeriodos = cntPeriodos;
	}

	public String getDesEstado()
	{
		return desEstado;
	}

	public void setDesEstado(String desEstado)
	{
		this.desEstado = desEstado;
	}

	public String getDesTiplan()
	{
		return desTiplan;
	}

	public void setDesTiplan(String desTiplan)
	{
		this.desTiplan = desTiplan;
	}

	public String getFecEstado()
	{
		return fecEstado;
	}

	public void setFecEstado(String fecEstado)
	{
		this.fecEstado = fecEstado;
	}

	public String getFecIngreso()
	{
		return fecIngreso;
	}

	public void setFecIngreso(String fecIngreso)
	{
		this.fecIngreso = fecIngreso;
	}

	public Double getValAcumulado()
	{
		return valAcumulado;
	}

	public void setValAcumulado(Double valAcumulado)
	{
		this.valAcumulado = valAcumulado;
	}

	public Double getValBeneficio()
	{
		return valBeneficio;
	}

	public void setValBeneficio(Double valBeneficio)
	{
		this.valBeneficio = valBeneficio;
	}

	public final String getCodPlan()
	{
		return codPlan;
	}

	public final void setCodPlan(String codPlan)
	{
		this.codPlan = codPlan;
	}

	public final String getDesPlan()
	{
		return desPlan;
	}

	public final void setDesPlan(String desPlan)
	{
		this.desPlan = desPlan;
	}

	public String getFecIngresoOrd() {
		return fecIngresoOrd;
	}

	public void setFecIngresoOrd(String fecIngresoOrd) {
		this.fecIngresoOrd = fecIngresoOrd;
	}

	public String getFecEstadoOrd() {
		return fecEstadoOrd;
	}

	public void setFecEstadoOrd(String fecEstadoOrd) {
		this.fecEstadoOrd = fecEstadoOrd;
	}

}
