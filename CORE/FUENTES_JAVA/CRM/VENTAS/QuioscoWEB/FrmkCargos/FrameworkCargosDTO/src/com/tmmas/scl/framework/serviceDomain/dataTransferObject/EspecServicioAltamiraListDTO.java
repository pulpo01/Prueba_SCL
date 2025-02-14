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

public class EspecServicioAltamiraListDTO implements Serializable
{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;	
	
	private EspecServicioAltamiraDTO[] espServAltList;

	public EspecServicioAltamiraDTO[] getEspServAltList() {
		return espServAltList;
	}

	public void setEspServAltList(EspecServicioAltamiraDTO[] espServAltList) {
		this.espServAltList = espServAltList;
	}
	
	public STRUCT[] getOracleArray(StructDescriptor sd,Connection DBCon) throws SQLException
	{
		STRUCT[] arreglo = null;		
		if(sd!=null && DBCon!=null)
		{
			arreglo=new STRUCT [this.espServAltList.length];			
			for (int i=0;i<this.espServAltList.length; i++) 
			{						
				arreglo[i] = new STRUCT(sd, DBCon, this.espServAltList[i].toStruct());	
			}
		}
		return arreglo;
   }
}
