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
 * 10-07-2007     			 Cristian Toledo              		Versión Inicial
 */
package com.tmmas.scl.framework.serviceDomain.dataTransferObject;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.Calendar;
import java.util.Date;

public class EspecServicioClienteDTO implements Serializable
{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String idEspecProducto;
	private String idServicioBase;
	private String tipoServicio;
	private String idEspecProvision;
	private String idProductoServicio;
	private String codPerfilLista; 
	
	private Date fecIniVig;
	private Date fecTerVig;
	
	private ReglasListaNumerosListDTO regLisNumList;
	private EspecProvisionamientoListDTO especProList;
	
	private EspecPlanTasacionListDTO   		especPlanTasList;
	private EspecPromAtlantidaListDTO 		especProAtlList;
	private EspecServicioAltamiraListDTO 	especSerAltList;
	private EspecServicioListaListDTO       especSerLisList;
	
	public Object[] toStruct_SE_DETALLE_ESPEC_TO_QT()
	{
		Object[] obj={	idEspecProducto,
						idServicioBase,
						tipoServicio,
						idEspecProvision,
						codPerfilLista
					  };
		return obj;
	}	
	
	public Object[] toStruct_SE_PLANES_ATLANTIDA_TD_QT()
	{
		/**
		 * COD_PLAN_ATL CHAR,
  			NOM_PLAN_ATL VARCHAR2(15),
  			DES_PLAN_ATL VARCHAR2(30),
  			IND_TIPO_PLATAFORMA CHAR,
  			FEC_INI_VIG DATE,
  			FEC_TER_VIG VARCHAR2(255),
  			COD_DEFINE_PLAN_ATL NUMBER
		 */
		
		Object[] obj={ idServicioBase,
						null,
						null,
						null,
						fecIniVig!=null?new Timestamp(fecIniVig.getTime()):null,
						fecTerVig!=null?new Timestamp(fecTerVig.getTime()):null,
						null					   
					 };
		return obj;
	}
	
	public Object[] toStruct_SE_PLANES_ALTAMIRA_TD_QT()
	{
		/**
		 * 
		 *    COD_PLAN_AA CHAR,
			  NOM_PLAN_AA VARCHAR2(15),
			  DES_PLAN_AA VARCHAR2(30),
			  IND_TIP_PLATAFORMA CHAR,
			  FEC_INI_VIG DATE,
			  FEC_TER_VIG DATE,
			  COD_LISTA_AA CHAR,
			  CAN_BONIFICAR CHAR,
			  TIP_UNIDAD_BONIFICAR CHAR
		 * 
		 */
		
		Object[] obj={ idServicioBase,
						null,
						null,
						null,
						fecIniVig!=null?new Timestamp(fecIniVig.getTime()):null,
						fecTerVig!=null?new Timestamp(fecTerVig.getTime()):null,
						null,
						null,
						null
					 };
		return obj;
	}
	
	public Object[] toStruct_SE_PERFIL_LISTA_TD_QT()
	{
		/**
		 * 
		 *        COD_PERFIL_LISTA NUMBER(8),
				  NOM_PERFIL VARCHAR2(15),
				  DES_PERFIL VARCHAR2(30),
				  IND_TIP_PLATAFORMA CHAR,
				  FEC_INI_VIG VARCHAR2(255),
				  FEC_TER_VIG VARCHAR2(255),
				  NUM_MAXIMO_LISTA VARCHAR2(255),
				  IND_TIP_COMPORTA CHAR,
				  FLG_AUTO_AFIN CHAR
		 * 
		 */
		
		Object[] obj={  codPerfilLista,
						null,
						null,
						null,
						fecIniVig!=null?new Timestamp(fecIniVig.getTime()):null,
						fecTerVig!=null?new Timestamp(fecTerVig.getTime()):null,
						null,
						null,
						null
					 };
		return obj;
	}
	
	public EspecServicioClienteDTO()
	{
		Calendar cal=Calendar.getInstance();
		cal.set(3000, 11, 31);
		this.fecIniVig=new Date();
		this.fecTerVig=new Date(cal.getTimeInMillis());
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

	public String getCodPerfilLista() {
		return codPerfilLista;
	}

	public void setCodPerfilLista(String codPerfilLista) {
		this.codPerfilLista = codPerfilLista;
	}


	public String getIdEspecProducto() {
		return idEspecProducto;
	}
	public void setIdEspecProducto(String idEspecProducto) {
		this.idEspecProducto = idEspecProducto;
	}
	public String getIdEspecProvision() {
		return idEspecProvision;
	}
	public void setIdEspecProvision(String idEspecProvision) {
		this.idEspecProvision = idEspecProvision;
	}
	public String getIdProductoServicio() {
		return idProductoServicio;
	}
	public void setIdProductoServicio(String idProductoServicio) {
		this.idProductoServicio = idProductoServicio;
	}
	public String getIdServicioBase() {
		return idServicioBase;
	}
	public void setIdServicioBase(String idServicioBase) {
		this.idServicioBase = idServicioBase;
	}
	public ReglasListaNumerosListDTO getRegLisNumList() {
		return regLisNumList;
	}
	public void setRegLisNumList(ReglasListaNumerosListDTO regLisNumList) {
		this.regLisNumList = regLisNumList;
	}
	public String getTipoServicio() {
		return tipoServicio;
	}
	public void setTipoServicio(String tipoServicio) {
		this.tipoServicio = tipoServicio;
	}	
	public EspecProvisionamientoListDTO getEspecProList() {
		return especProList;
	}
	public void setEspecProList(EspecProvisionamientoListDTO especProList) {
		this.especProList = especProList;
	}
	public EspecPlanTasacionListDTO getEspecPlanTasList() {
		return especPlanTasList;
	}
	public void setEspecPlanTasList(EspecPlanTasacionListDTO especPlanTasList) {
		this.especPlanTasList = especPlanTasList;
	}
	public EspecPromAtlantidaListDTO getEspecProAtlList() {
		return especProAtlList;
	}
	public void setEspecProAtlList(EspecPromAtlantidaListDTO especProAtlList) {
		this.especProAtlList = especProAtlList;
	}
	public EspecServicioAltamiraListDTO getEspecSerAltList() {
		return especSerAltList;
	}
	public void setEspecSerAltList(EspecServicioAltamiraListDTO especSerAltList) {
		this.especSerAltList = especSerAltList;
	}
	public EspecServicioListaListDTO getEspecSerLisList() {
		return especSerLisList;
	}
	public void setEspecSerLisList(EspecServicioListaListDTO especSerLisList) {
		this.especSerLisList = especSerLisList;
	}
	
	
}
