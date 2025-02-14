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

public class ProductoTasacionContratadoListDTO implements Serializable 
{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private ProductoTasacionContratadoDTO productosTasacionContratados[];	
	private String codCanal;
	private String codCliente;
	private String codCicloFacturacion;

	
	public STRUCT[] getOracleArray_TOL_ALTA_PRODUCTO_DET_QT(StructDescriptor sd,Connection DBCon) throws SQLException
	{
		STRUCT[] arreglo = null;		
		if(sd!=null && DBCon!=null)
		{
			arreglo=new STRUCT [this.productosTasacionContratados.length];			
			for (int i=0;i<this.productosTasacionContratados.length; i++) 
			{						
				arreglo[i] = new STRUCT(sd, DBCon, this.productosTasacionContratados[i].toStruct_TOL_ALTA_PRODUCTO_QT());	
			}
		}
		return arreglo;
   }
	
	
	public String getCodCanal() {
		return codCanal;
	}
	public void setCodCanal(String codCanal) {
		this.codCanal = codCanal;
	}
	
	public String getCodCliente() {
		return codCliente;
	}
	
	public void setCodCliente(String codCliente) {
		this.codCliente = codCliente;
	}

	public ProductoTasacionContratadoDTO[] getProductosTasacionContratados() {
		return productosTasacionContratados;
	}

	public void setProductosTasacionContratados(
			ProductoTasacionContratadoDTO[] productosTasacionContratados) {
		this.productosTasacionContratados = productosTasacionContratados;
	}


	public String getCodCicloFacturacion() {
		return codCicloFacturacion;
	}


	public void setCodCicloFacturacion(String codCicloFacturacion) {
		this.codCicloFacturacion = codCicloFacturacion;
	}	
	
}
