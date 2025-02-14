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

public class CuentaCorrienteDTO implements Serializable
{

	private static final long serialVersionUID = 1L;

	private Long codCliente;

	private Long numAbonado;

	private Long codTipDocumento;

	private String desTipDocumento;

	private Double importeDebe;

	private Double importeHaber;

	/*
	 * Modificacion
	 * Proyecto: P-MIX-10008 Mejoras al Portal SAC y Evolución Gestor Posventa MIX-10008
	 * Requisito: RSis_008
	 * Caso de uso: CU-014 Modificar Cuenta Corriente del Cliente
	 * Developer: Gabriel Moraga L.
	 * Fecha: 12/07/2010
	 * 
	 */
	
	private Double acumNetoGrav; //Acumulado del Neto Gravado
	
	public Long getCodCliente()
	{
		return codCliente;
	}

	public void setCodCliente(Long codCliente)
	{
		this.codCliente = codCliente;
	}

	public Long getCodTipDocumento()
	{
		return codTipDocumento;
	}

	public void setCodTipDocumento(Long codTipDocumento)
	{
		this.codTipDocumento = codTipDocumento;
	}

	public String getDesTipDocumento()
	{
		return desTipDocumento;
	}

	public void setDesTipDocumento(String desTipDocumento)
	{
		this.desTipDocumento = desTipDocumento;
	}

	public Double getImporteDebe()
	{
		return importeDebe;
	}

	public void setImporteDebe(Double importeDebe)
	{
		this.importeDebe = importeDebe;
	}

	public Double getImporteHaber()
	{
		return importeHaber;
	}

	public void setImporteHaber(Double importeHaber)
	{
		this.importeHaber = importeHaber;
	}

	public Long getNumAbonado()
	{
		return numAbonado;
	}

	public void setNumAbonado(Long numAbonado)
	{
		this.numAbonado = numAbonado;
	}

	public Double getAcumNetoGrav() {
		return acumNetoGrav;
	}

	public void setAcumNetoGrav(Double acumNetoGrav) {
		this.acumNetoGrav = acumNetoGrav;
	}
	
}
