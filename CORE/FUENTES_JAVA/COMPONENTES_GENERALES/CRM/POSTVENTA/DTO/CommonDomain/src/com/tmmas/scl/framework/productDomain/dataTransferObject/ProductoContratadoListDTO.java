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
 * 25-06-2007     			 Esteban Conejeros              		Versión Inicial
 * 13-08-2007				 Cristian Toledo 					Se agrego estructura para types de Oracle
 */
package com.tmmas.scl.framework.productDomain.dataTransferObject;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.SQLException;

import oracle.sql.STRUCT;
import oracle.sql.StructDescriptor;

public class ProductoContratadoListDTO implements Serializable
{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private ProductoContratadoDTO productosContratadosDTO[];
	private String numEvento;

	public ProductoContratadoDTO[] getProductosContratadosDTO() {
		return productosContratadosDTO;
	}

	public void setProductosContratadosDTO(
			ProductoContratadoDTO[] productosContratadosDTO) {
		this.productosContratadosDTO = productosContratadosDTO;
	}
	
	public STRUCT[] getOracleArray_PR_PROD_CONTR_LST_QT(StructDescriptor sd,Connection DBCon) throws SQLException
	{
		STRUCT[] arreglo = null;		
		if(sd!=null && DBCon!=null)
		{
			arreglo=new STRUCT [this.productosContratadosDTO.length];			
			for (int i=0;i<this.productosContratadosDTO.length; i++) 
			{						
				arreglo[i] = new STRUCT(sd, DBCon, this.productosContratadosDTO[i].toStruct_PR_PRODUCTOS_CONTS_TO_QT());	
			}
		}
		return arreglo;
   }
	
	
	public STRUCT[] getOracleArray_SV_PROD_CONTR_LST_QT(StructDescriptor sd,Connection DBCon) throws SQLException
	{
		STRUCT[] arreglo = null;		
		if(sd!=null && DBCon!=null)
		{
			arreglo=new STRUCT [this.productosContratadosDTO.length];			
			for (int i=0;i<this.productosContratadosDTO.length; i++) 
			{						
				arreglo[i] = new STRUCT(sd, DBCon, this.productosContratadosDTO[i].toStruct_SV_PROD_CONTRA_QT());	
			}
		}
		return arreglo;
   }
	
	public STRUCT[] getOracleArray_TOL_BAJA_PRODUCTO_DET_QT(StructDescriptor sd,Connection DBCon) throws SQLException
	{
		STRUCT[] arreglo = null;		
		if(sd!=null && DBCon!=null)
		{
			arreglo=new STRUCT [this.productosContratadosDTO.length];			
			for (int i=0;i<this.productosContratadosDTO.length; i++) 
			{						
				arreglo[i] = new STRUCT(sd, DBCon, this.productosContratadosDTO[i].toStruct_TOL_BAJA_PRODUCTO_QT());	
			}
		}
		return arreglo;
   }
	
	public STRUCT[] getOracleArray_PR_PRODUCTO_DESCONTRATA_QT(StructDescriptor sd,Connection DBCon) throws SQLException
	{
		STRUCT[] arreglo = null;		
		if(sd!=null && DBCon!=null)
		{
			arreglo=new STRUCT [this.productosContratadosDTO.length];			
			for (int i=0;i<this.productosContratadosDTO.length; i++) 
			{						
				arreglo[i] = new STRUCT(sd, DBCon, this.productosContratadosDTO[i].PR_PRODUCTO_DESCONTRATA_QT());	
			}
		}
		return arreglo;
   }
	
	
	public STRUCT[] getOracleArray_SV_LISTA_CONTRA_TO_LST_QT(StructDescriptor sd,Connection DBCon) throws SQLException
	{
		STRUCT[] arreglo = null;		
		if(sd!=null && DBCon!=null)
		{
			arreglo=new STRUCT [this.productosContratadosDTO.length];			
			for (int i=0;i<this.productosContratadosDTO.length; i++) 
			{						
				arreglo[i] = new STRUCT(sd, DBCon, this.productosContratadosDTO[i].toStruct_SV_LISTA_CONTRA_TO_QT());	
			}
		}
		return arreglo;
   }
	
	public String getNumEvento() {
		return numEvento;
	}
	public void setNumEvento(String numEvento) {
		this.numEvento = numEvento;
	}
	
	

}
