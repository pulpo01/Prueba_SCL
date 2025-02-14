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

public class DocCtaCteClienteDTO implements Serializable
{

	private static final long serialVersionUID = 1L;

	private Long codCliente;

	private Long numFolio;

	private String codTipDocum;

	private String desTipDocum;

	private String desObserva;

	private String fecEmision;

	private String fecVencimiento;

	private Float totalIVA;

	private Float importeDebe;

	private Long indOrdenTotal;

	String textoDetalle;

	//Son para el ordenamiento de la tabla
	private String fecEmisionOrd;
	private String fecVencimientoOrd;
	
	private Float acumNetoGrav; //Acumulado del Neto Gravado
	
	public final String getTextoDetalle()
	{
		return textoDetalle;
	}

	public final void setTextoDetalle(String textoDetalle)
	{
		this.textoDetalle = textoDetalle;
	}

	public Long getCodCliente()
	{
		return codCliente;
	}

	public void setCodCliente(Long codCliente)
	{
		this.codCliente = codCliente;
	}

	public String getCodTipDocum()
	{
		return codTipDocum;
	}

	public void setCodTipDocum(String codTipDocum)
	{
		this.codTipDocum = codTipDocum;
	}

	public String getDesObserva()
	{
		return desObserva;
	}

	public void setDesObserva(String desObserva)
	{
		this.desObserva = desObserva;
	}

	public String getDesTipDocum()
	{
		return desTipDocum;
	}

	public void setDesTipDocum(String desTipDocum)
	{
		this.desTipDocum = desTipDocum;
	}

	public String getFecEmision()
	{
		return fecEmision;
	}

	public void setFecEmision(String fecEmision)
	{
		this.fecEmision = fecEmision;
	}

	public String getFecVencimiento()
	{
		return fecVencimiento;
	}

	public void setFecVencimiento(String fecVencimiento)
	{
		this.fecVencimiento = fecVencimiento;
	}

	public Float getImporteDebe()
	{
		return importeDebe;
	}

	public void setImporteDebe(Float importeDebe)
	{
		this.importeDebe = importeDebe;
	}

	public Long getNumFolio()
	{
		return numFolio;
	}

	public void setNumFolio(Long numFolio)
	{
		this.numFolio = numFolio;
	}

	public Float getTotalIVA()
	{
		return totalIVA;
	}

	public void setTotalIVA(Float totalIVA)
	{
		this.totalIVA = totalIVA;
	}

	/**
	 * @return the indOrdenTotal
	 */
	public final Long getIndOrdenTotal()
	{
		return indOrdenTotal;
	}

	/**
	 * @param indOrdenTotal the indOrdenTotal to set
	 */
	public final void setIndOrdenTotal(Long indOrdenTotal)
	{
		this.indOrdenTotal = indOrdenTotal;
	}

	public String getFecEmisionOrd() {
		return fecEmisionOrd;
	}

	public void setFecEmisionOrd(String fecEmisionOrd) {
		this.fecEmisionOrd = fecEmisionOrd;
	}

	public String getFecVencimientoOrd() {
		return fecVencimientoOrd;
	}

	public void setFecVencimientoOrd(String fecVencimientoOrd) {
		this.fecVencimientoOrd = fecVencimientoOrd;
	}

	public Float getAcumNetoGrav() {
		return acumNetoGrav;
	}

	public void setAcumNetoGrav(Float acumNetoGrav) {
		this.acumNetoGrav = acumNetoGrav;
	}

} // DocCtaCteClienteDTO
