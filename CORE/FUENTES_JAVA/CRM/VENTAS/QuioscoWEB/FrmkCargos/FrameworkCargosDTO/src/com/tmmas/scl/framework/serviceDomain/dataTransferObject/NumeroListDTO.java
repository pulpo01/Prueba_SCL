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
 * 25-06-2007     			 Cristian Toledo              		Versión Inicial
 */
package com.tmmas.scl.framework.serviceDomain.dataTransferObject;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.SQLException;

import oracle.sql.STRUCT;
import oracle.sql.StructDescriptor;

public class NumeroListDTO implements Serializable
{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private NumeroDTO numerosDTO[];
	
	private String codCliente;
	private String numAbonado;
	private String idProducto;
	private String tipoComportamiento;
	
	
	public NumeroDTO[] getNumerosDTO() {
		return numerosDTO;
	}
	public void setNumerosDTO(NumeroDTO[] numerosDTO) {
		this.numerosDTO = numerosDTO;
	}	
	
	public String getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(String codCliente) {
		this.codCliente = codCliente;
	}
	public String getIdProducto() {
		return idProducto;
	}
	public void setIdProducto(String idProducto) {
		this.idProducto = idProducto;
	}
	public String getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(String numAbonado) {
		this.numAbonado = numAbonado;
	}
	public String getTipoComportamiento() {
		return tipoComportamiento;
	}
	public void setTipoComportamiento(String tipoComportamiento) {
		this.tipoComportamiento = tipoComportamiento;
	}
	public STRUCT[] getOracleArray_SV_TOL_LISTA_CONTRATADA_DET_QT(StructDescriptor sd,Connection DBCon) throws SQLException
	{
		STRUCT[] arreglo = null;		
		if(sd!=null && DBCon!=null)
		{
			arreglo=new STRUCT [this.numerosDTO.length];			
			for (int i=0;i<this.numerosDTO.length; i++) 
			{						
				arreglo[i] = new STRUCT(sd, DBCon, this.numerosDTO[i].toStruct_SV_TOL_LISTA_CONTRATADA_QT());	
			}
		}
		return arreglo;
   }
	
	public STRUCT[] getOracleArray_SV_LISTA_CONTRA_TO_LST_QT(StructDescriptor sd,Connection DBCon) throws SQLException
	{
		STRUCT[] arreglo = null;		
		if(sd!=null && DBCon!=null)
		{
			arreglo=new STRUCT [this.numerosDTO.length];			
			for (int i=0;i<this.numerosDTO.length; i++) 
			{						
				arreglo[i] = new STRUCT(sd, DBCon, this.numerosDTO[i].toStruct_SV_LISTA_CONTRA_TO_QT());	
			}
		}
		return arreglo;
   }
	
	//
}

