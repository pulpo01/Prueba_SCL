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
import java.sql.Connection;
import java.sql.SQLException;

import oracle.sql.STRUCT;
import oracle.sql.StructDescriptor;

public class EspecServicioClienteListDTO implements Serializable
{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private EspecServicioClienteDTO[] espServCliList;
	private ReglasListaNumerosListDTO reglasNumList;
	private EspecProvisionamientoListDTO especProList;
	
	private EspecPlanTasacionListDTO  		especPlanTasList;
	private EspecPromAtlantidaListDTO 		especPromAtlList;
	private EspecServicioAltamiraListDTO	especSerAltList;
	private EspecServicioListaListDTO       especSerLisList;
	
	

	public EspecServicioClienteDTO[] getEspServCliList() {		
		return espServCliList;
	}

	public void setEspServCliList(EspecServicioClienteDTO[] espServCliList) {
		this.espServCliList = espServCliList;
	}

	public EspecProvisionamientoListDTO getEspecProList() {
		return especProList;
	}

	public void setEspecProList(EspecProvisionamientoListDTO especProList) {
		this.especProList = especProList;
	}

	public ReglasListaNumerosListDTO getReglasNumList() {
		return reglasNumList;
	}

	public void setReglasNumList(ReglasListaNumerosListDTO reglasNumList) {
		this.reglasNumList = reglasNumList;
	}

	public EspecPlanTasacionListDTO getEspecPlanTasList() {
		return especPlanTasList;
	}

	public void setEspecPlanTasList(EspecPlanTasacionListDTO especPlanTasList) {
		this.especPlanTasList = especPlanTasList;
	}

	public EspecPromAtlantidaListDTO getEspecPromAtlList() {
		return especPromAtlList;
	}

	public void setEspecPromAtlList(EspecPromAtlantidaListDTO especPromAtlList) {
		this.especPromAtlList = especPromAtlList;
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
	
	public STRUCT[] getOracleArray_SE_DETALLE_ESPEC_TO_LST_QT(StructDescriptor sd,Connection DBCon) throws SQLException
	{
		STRUCT[] arreglo = null;		
		if(sd!=null && DBCon!=null)
		{
			arreglo=new STRUCT [this.espServCliList.length];			
			for (int i=0;i<this.espServCliList.length; i++) 
			{						
				arreglo[i] = new STRUCT(sd, DBCon, this.espServCliList[i].toStruct_SE_DETALLE_ESPEC_TO_QT());	
			}
		}
		return arreglo;
   }
	
	public STRUCT[] getOracleArray_SE_PLANES_ATLANTIDA_TD_LST_QT(StructDescriptor sd,Connection DBCon) throws SQLException
	{
		STRUCT[] arreglo = null;		
		if(sd!=null && DBCon!=null)
		{
			arreglo=new STRUCT [this.espServCliList.length];			
			for (int i=0;i<this.espServCliList.length; i++) 
			{						
				arreglo[i] = new STRUCT(sd, DBCon, this.espServCliList[i].toStruct_SE_PLANES_ATLANTIDA_TD_QT());	
			}
		}
		return arreglo;
   }
	
	public STRUCT[] getOracleArray_SE_PLANES_ALTAMIRA_TD_LST_QT(StructDescriptor sd,Connection DBCon) throws SQLException
	{
		STRUCT[] arreglo = null;		
		if(sd!=null && DBCon!=null)
		{
			arreglo=new STRUCT [this.espServCliList.length];			
			for (int i=0;i<this.espServCliList.length; i++) 
			{						
				arreglo[i] = new STRUCT(sd, DBCon, this.espServCliList[i].toStruct_SE_PLANES_ALTAMIRA_TD_QT());	
			}
		}
		return arreglo;
   }
	
   public STRUCT[] getOracleArray_SE_PERFIL_LISTA_TD_LST_QT(StructDescriptor sd,Connection DBCon) throws SQLException
   {
		STRUCT[] arreglo = null;		
		if(sd!=null && DBCon!=null)
		{
			arreglo=new STRUCT [this.espServCliList.length];			
			for (int i=0;i<this.espServCliList.length; i++) 
			{						
				arreglo[i] = new STRUCT(sd, DBCon, this.espServCliList[i].toStruct_SE_PERFIL_LISTA_TD_QT());	
			}
		}
		return arreglo;
   }
}
