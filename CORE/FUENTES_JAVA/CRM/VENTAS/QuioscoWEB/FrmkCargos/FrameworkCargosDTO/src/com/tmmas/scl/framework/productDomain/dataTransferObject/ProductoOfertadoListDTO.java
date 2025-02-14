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

public class ProductoOfertadoListDTO implements Serializable
{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private ProductoOfertadoDTO[] productoList;
	private EspecProductoListDTO especProdList;
	private CargoListDTO cargoList;

	public ProductoOfertadoDTO[] getProductoList() {
		return productoList;
	}

	public void setProductoList(ProductoOfertadoDTO[] productoList) {
		this.productoList = productoList;
	}

	public CargoListDTO getCargoList() {
		return cargoList;
	}

	public void setCargoList(CargoListDTO cargoList) {
		this.cargoList = cargoList;
	}

	public EspecProductoListDTO getEspecProdList() {
		return especProdList;
	}

	public void setEspecProdList(EspecProductoListDTO especProdList) {
		this.especProdList = especProdList;
	}
	
	public STRUCT[] getOracleArray_PF_PRODUCTO_OFERTADO_LISTA_QT(StructDescriptor sd,Connection DBCon) throws SQLException
	{
		STRUCT[] arreglo = null;		
		if(sd!=null && DBCon!=null)
		{
			arreglo=new STRUCT [this.productoList.length];			
			for (int i=0;i<this.productoList.length; i++) 
			{						
				arreglo[i] = new STRUCT(sd, DBCon, this.productoList[i].toStruct_PF_PRODUCTO_OFERTADO_QT());	
			}
		}
		return arreglo;
   }
	
}
