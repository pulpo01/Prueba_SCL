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
package com.tmmas.scl.framework.productDomain.dataTransferObject;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.SQLException;

import oracle.sql.STRUCT;
import oracle.sql.StructDescriptor;

import com.tmmas.scl.framework.serviceDomain.dataTransferObject.EspecServicioClienteListDTO;

public class EspecProductoListDTO implements Serializable 
{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private EspecProductoDTO[] espectProdList;
	private EspecServicioClienteListDTO espSerCliList;

	public EspecProductoDTO[] getEspectProdList() {
		return espectProdList;
	}

	public void setEspectProdList(EspecProductoDTO[] espectProdList) {
		this.espectProdList = espectProdList;
	}

	public EspecServicioClienteListDTO getEspSerCliList() {
		return espSerCliList;
	}

	public void setEspSerCliList(EspecServicioClienteListDTO espSerCliList) {
		this.espSerCliList = espSerCliList;
	}	
	
	public STRUCT[] getOracleArray_PF_ESPEC_PRODUCTO_LISTA_QT(StructDescriptor sd,Connection DBCon) throws SQLException
	{
		STRUCT[] arreglo = null;		
		if(sd!=null && DBCon!=null)
		{
			arreglo=new STRUCT [this.espectProdList.length];			
			for (int i=0;i<this.espectProdList.length; i++) 
			{						
				arreglo[i] = new STRUCT(sd, DBCon, this.espectProdList[i].toStruct_PF_ESPEC_PRODUCTO_QT());	
			}
		}
		return arreglo;
   }
	
	
}
