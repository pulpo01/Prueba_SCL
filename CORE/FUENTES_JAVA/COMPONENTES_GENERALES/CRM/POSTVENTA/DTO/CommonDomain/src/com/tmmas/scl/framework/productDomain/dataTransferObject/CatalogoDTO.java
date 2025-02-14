/**
 * Copyright © 2006 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 27/07/2007     			 Cristian Toledo              		Versión Inicial
 */
package com.tmmas.scl.framework.productDomain.dataTransferObject;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.Calendar;
import java.util.Date;

public class CatalogoDTO implements Serializable
{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String codProdOfertado;
	private String codCanal;
	private String codCargo;
	private Date  fecInicioVigencia;
	private Date  fecTerminoVigencia;	
	private String codConcepto;
	private String indNivelAplica;	
	
	
//	------------------------------------------------------------------------------------------------	
	public Object[] toStruct_PF_CATALOGO_OFER_TD_QT()
	{		 
		Object[] obj={	codProdOfertado,
						codCanal,
						codCargo,
						fecInicioVigencia!=null?new Timestamp(fecInicioVigencia.getTime()):null,
						fecTerminoVigencia!=null?new Timestamp(fecTerminoVigencia.getTime()):null,
						codConcepto,
						indNivelAplica
					  };
		return obj;
	}
//------------------------------------------------------------------------------------------------	
	public Object[] toStruct_PF_DESC_CONCEPTOS_TD_QT()
	{
		Object[] obj={	codConcepto,
						null,
						codCanal,
						null,
						null,
						fecInicioVigencia!=null?new Timestamp(fecInicioVigencia.getTime()):null,
						fecTerminoVigencia!=null?new Timestamp(fecTerminoVigencia.getTime()):null,
						null,
						null,
						null,
						null
					 };
		
		return obj;
	}	
	
//	------------------------------------------------------------------------------------------------	
	public String getIndNivelAplica() {
		return indNivelAplica;
	}
	public void setIndNivelAplica(String indNivelAplica) {
		this.indNivelAplica = indNivelAplica;
	}
	public CatalogoDTO()
	{
		Calendar cal=Calendar.getInstance();
		cal.set(3000,11, 31);
		this.fecInicioVigencia=new Date();
		this.fecTerminoVigencia=new Date(cal.getTimeInMillis());
	}
	
	public String getCodConcepto() {
		return codConcepto;
	}

	public void setCodConcepto(String codConcepto) {
		this.codConcepto = codConcepto;
	}

	public String getCodCanal() {
		return codCanal;
	}

	public void setCodCanal(String codCanal) {
		this.codCanal = codCanal;
	}

	public String getCodCargo() {
		return codCargo;
	}


	public void setCodCargo(String codCargo) {
		this.codCargo = codCargo;
	}

	public String getCodProdOfertado() {
		return codProdOfertado;
	}

	public void setCodProdOfertado(String codProdOfertado) {
		this.codProdOfertado = codProdOfertado;
	}

	public Date getFecInicioVigencia() {
		return fecInicioVigencia;
	}

	public void setFecInicioVigencia(Date fecInicioVigencia) {
		this.fecInicioVigencia = fecInicioVigencia;
	}

	public Date getFecTerminoVigencia() {
		return fecTerminoVigencia;
	}

	public void setFecTerminoVigencia(Date fecTerminoVigencia) {
		this.fecTerminoVigencia = fecTerminoVigencia;
	}

}
