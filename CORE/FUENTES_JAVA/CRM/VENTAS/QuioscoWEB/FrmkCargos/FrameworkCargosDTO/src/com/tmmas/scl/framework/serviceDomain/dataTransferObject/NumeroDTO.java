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
 * 22-06-2007     			 Cristian Toledo              		Versión Inicial
 */

package com.tmmas.scl.framework.serviceDomain.dataTransferObject;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.Calendar;
import java.util.Date;

public class NumeroDTO implements Serializable
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String idProductoContratado;
	private String nro;
	private String idPerfilLista;
	private String idCliente;
	private String idAbonado;
	private String codCategoriaDest;
	private String desCategoria;
	private Date fecInicioVigencia;
	private Date fecTerminoVigencia;
	private String numProceso;
	private String origenProceso;
	private Date fecProceso;
	private String origenProcDescontrata;
	private String numProcesoDescontrata;
	
	
	/**
	create or replace TYPE SV_LISTA_CONTRA_TO_QT AS OBJECT
	(
	  COD_PROD_CONTRATADO NUMBER(38),
	  VALOR_ELEMENTO NUMBER(15),
	  FEC_INICIO_VIGENCIA DATE,
	  FEC_TERMINO_VIGENCIA DATE,
	  COD_CATEGORIA_DESTINO VARCHAR2(20),
	  NUM_PROCESO VARCHAR2(10),
	  ORIGEN_PROCESO VARCHAR2(5),
	  FEC_PROCESO DATE,
	  ORIGEN_PROC_DESCONTRATA VARCHAR2(5),
	  NUM_PROC_DESCONTRATA VARCHAR2(10)
	)	
	**/
	
	public Object[] toStruct_SV_LISTA_CONTRA_TO_QT()
	{			
		Object[] obj={	idProductoContratado,
						nro,						
						new Timestamp(fecInicioVigencia.getTime()),
						fecTerminoVigencia!=null?new Timestamp(this.fecTerminoVigencia.getTime()):null,
						codCategoriaDest,
						numProceso,
						origenProceso,
						fecProceso!=null?new Timestamp(this.fecProceso.getTime()):null,
						origenProcDescontrata,
						numProcesoDescontrata								
					 };
		
		return obj;
	}
	
	
	public Object[] toStruct_SV_TOL_LISTA_CONTRATADA_QT()
	{
		Object[] obj={	nro,
						new Timestamp(fecInicioVigencia.getTime()),
						fecTerminoVigencia!=null?new Timestamp(this.fecTerminoVigencia.getTime()):null,
						codCategoriaDest
					 };
		return obj;
	}
	
	public Object[] toStruct_PV_CLIENTE_QT()
	{
		Object[] obj={	idCliente,
						null,
						null,
						null,
						null,
						null,
						null,
						null,
						null,
						null,
						null,
						null,
						null,
						null,
						null,
						null,
						null,
						null,
						null,
						null,
						null,
						null,
						null,
						null,
						null,
						null,
						nro ,
						null
		};
		return obj;
	}	
	
	public NumeroDTO()
	{
		Calendar cal=Calendar.getInstance();
				
		fecInicioVigencia=new Date();		
		fecProceso=new Date();
		cal.set(3000, 11, 31);
		fecTerminoVigencia=new Date(cal.getTimeInMillis());
		cal.setTime(fecInicioVigencia);
	}
	
	
	public String getCodCategoriaDest() {
		return codCategoriaDest;
	}



	public void setCodCategoriaDest(String codCategoriaDest) {
		this.codCategoriaDest = codCategoriaDest;
	}



	public String getDesCategoria() {
		return desCategoria;
	}



	public void setDesCategoria(String desCategoria) {
		this.desCategoria = desCategoria;
	}



	public String getNumProcesoDescontrata() {
		return numProcesoDescontrata;
	}


	public void setNumProcesoDescontrata(String numProcesoDescontrata) {
		this.numProcesoDescontrata = numProcesoDescontrata;
	}


	public String getOrigenProcDescontrata() {
		return origenProcDescontrata;
	}


	public void setOrigenProcDescontrata(String origenProcDescontrata) {
		this.origenProcDescontrata = origenProcDescontrata;
	}


	public String getIdAbonado() {
		return idAbonado;
	}
	public void setIdAbonado(String idAbonado) {
		this.idAbonado = idAbonado;
	}
	public String getIdCliente() {
		return idCliente;
	}
	public void setIdCliente(String idCliente) {
		this.idCliente = idCliente;
	}	
	public String getIdPerfilLista() {
		return idPerfilLista;
	}
	public void setIdPerfilLista(String idPerfilLista) {
		this.idPerfilLista = idPerfilLista;
	}
	public String getIdProductoContratado() {
		return idProductoContratado;
	}
	public void setIdProductoContratado(String idProductoContratado) {
		this.idProductoContratado = idProductoContratado;
	}
	public String getNro() {
		return nro;
	}
	public void setNro(String nro) {
		this.nro = nro;
	}



	public Date getFecInicioVigencia() {
		return fecInicioVigencia;
	}



	public void setFecInicioVigencia(Date fecInicioVigencia) 
	{
		Calendar cal=Calendar.getInstance();
		cal.setTime(fecInicioVigencia);
		cal.setTimeZone(null);		
		this.fecInicioVigencia =  new Date(cal.getTimeInMillis());
	}



	public Date getFecProceso() {
		return fecProceso;
	}



	public void setFecProceso(Date fecProceso) {
		this.fecProceso = fecProceso;
	}



	public Date getFecTerminoVigencia() {
		return fecTerminoVigencia;
	}



	public void setFecTerminoVigencia(Date fecTerminoVigencia) 
	{
		Calendar cal=Calendar.getInstance();
		cal.setTime(fecTerminoVigencia);			
		this.fecTerminoVigencia =  new Date(cal.getTimeInMillis());
	}



	public String getNumProceso() {
		return numProceso;
	}



	public void setNumProceso(String numProceso) {
		this.numProceso = numProceso;
	}



	public String getOrigenProceso() {
		return origenProceso;
	}



	public void setOrigenProceso(String origenProceso) {
		this.origenProceso = origenProceso;
	}	
	
}
