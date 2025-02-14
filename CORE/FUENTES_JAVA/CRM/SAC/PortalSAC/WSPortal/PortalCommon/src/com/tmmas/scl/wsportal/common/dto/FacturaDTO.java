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

public class FacturaDTO implements Serializable
{

	private static final long serialVersionUID = 1L;

	private Long numFolio;

	private String desTipDocumento;

	private String fecEmision;

	private String fecVencimiento;

	private Double acumIva;

	private Double totFactura;

	private Long codCiclo;

	//Son para el ordenamiento de la tabla
	private String fecEmisionOrd;
	private String fecVencimientoOrd;
	
	public Long getCodCiclo()
	{
		return codCiclo;
	}

	public void setCodCiclo(Long codCiclo)
	{
		this.codCiclo = codCiclo;
	}

	public Double getAcumIva()
	{
		return acumIva;
	}

	public void setAcumIva(Double acumIva)
	{
		this.acumIva = acumIva;
	}

	public String getDesTipDocumento()
	{
		return desTipDocumento;
	}

	public void setDesTipDocumento(String desTipDocumento)
	{
		this.desTipDocumento = desTipDocumento;
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

	public Long getNumFolio()
	{
		return numFolio;
	}

	public void setNumFolio(Long numFolio)
	{
		this.numFolio = numFolio;
	}

	public Double getTotFactura()
	{
		return totFactura;
	}

	public void setTotFactura(Double totFactura)
	{
		this.totFactura = totFactura;
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
	
}
