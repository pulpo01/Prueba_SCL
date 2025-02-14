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
 * 09-07-2007     			 Cristian Toledo              		Versión Inicial
 */
package com.tmmas.scl.framework.productDomain.dataTransferObject;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.Calendar;
import java.util.Date;

import com.tmmas.scl.framework.serviceDomain.dataTransferObject.EspecServicioClienteListDTO;

public class EspecProductoDTO implements Serializable
{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String idEspecProducto;
	private String indProdPadre;
	private String nombre;
	private String descripcion;
	private Date fecIniVig;
	private Date fecTerVig;
	private String idEspecProdPadre;
	private String indTipoPlataforma;
	private String tipoComportamiento;
	
	private EspecServicioClienteListDTO especServicioClienteList;	
	
	public Object[] toStruct_PF_ESPEC_PRODUCTO_QT()
	{	
		/**
		 *   COD_ESP_PROD NUMBER,
  			 ID_ESPEC_PROD VARCHAR2(10),
  			 DES_ESPEC_PROD VARCHAR2(30),
  			 FEC_INI_VIG DATE,
  			 FEC_TER_VIG DATE,
  			 TIPO_COMPORTAMIENTO VARCHAR2(5),
  			 IND_TIPO_PLATAFORMA VARCHAR2(5)
		 */
		
		Object[] obj={	idEspecProducto,
						nombre,
						descripcion,
						fecIniVig!=null?new Timestamp(fecIniVig.getTime()):null,
						fecTerVig!=null?new Timestamp(fecTerVig.getTime()):null,
					  	null,
					  	indTipoPlataforma
					 };
		return obj;
	}
	
	public Object[] toStruct_SE_DETALLE_ESPEC_TO_QT()
	{
		/**
		 COD_ESPEC_PROD NUMBER(8),
		 COD_SERVICIO_BASE CHAR,
		 IND_TIPO_SERVICIO CHAR,
		 COD_PROV_SERV NUMBER(8),
		 COD_PERFIL_LISTA NUMBER(8)
		 **/
		Object[] obj={	idEspecProducto,
						null,
						null,
						null,
						null
					 };
		return obj;
	}
	
	
	public EspecProductoDTO()
	{
		Calendar cal=Calendar.getInstance();
		cal.set(2003, 11, 31);
		this.fecIniVig=new Date();
		this.fecTerVig=new Date(cal.getTimeInMillis());
	}
	
	
	
	public String getTipoComportamiento() {
		return tipoComportamiento;
	}

	public void setTipoComportamiento(String tipoComportamiento) {
		this.tipoComportamiento = tipoComportamiento;
	}

	public String getDescripcion() {
		return descripcion;
	}
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
	
	public EspecServicioClienteListDTO getEspecServicioClienteList() {
		return especServicioClienteList;
	}
	public void setEspecServicioClienteList(
			EspecServicioClienteListDTO especServicioClienteList) {
		this.especServicioClienteList = especServicioClienteList;
	}
	public String getIdEspecProdPadre() {
		return idEspecProdPadre;
	}
	public void setIdEspecProdPadre(String idEspecProdPadre) {
		this.idEspecProdPadre = idEspecProdPadre;
	}
	public String getIdEspecProducto() {
		return idEspecProducto;
	}
	public void setIdEspecProducto(String idEspecProducto) {
		this.idEspecProducto = idEspecProducto;
	}
	public String getIndProdPadre() {
		return indProdPadre;
	}
	public void setIndProdPadre(String indProdPadre) {
		this.indProdPadre = indProdPadre;
	}
	public String getNombre() {
		return nombre;
	}
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	public Date getFecIniVig() {
		return fecIniVig;
	}
	public void setFecIniVig(Date fecIniVig) {
		this.fecIniVig = fecIniVig;
	}
	public Date getFecTerVig() {
		return fecTerVig;
	}
	public void setFecTerVig(Date fecTerVig) {
		this.fecTerVig = fecTerVig;
	}

	public String getIndTipoPlataforma() {
		return indTipoPlataforma;
	}

	public void setIndTipoPlataforma(String indTipoPlataforma) {
		this.indTipoPlataforma = indTipoPlataforma;
	}

}
