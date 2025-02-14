package com.tmmas.scl.framework.productDomain.dataTransferObject;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.SQLException;

import oracle.sql.STRUCT;
import oracle.sql.StructDescriptor;

public class AbonadoVetadoListDTO implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private AbonadoVetadoDTO [] AbonadoVetadoList;

	public AbonadoVetadoDTO[] getAbonadoVetadoList() {
		return AbonadoVetadoList;
	}

	public void setAbonadoVetadoList(
			AbonadoVetadoDTO[] abonadoVetadoList) {
		AbonadoVetadoList = abonadoVetadoList;
	}
	
	public STRUCT[] getOracleArray_SV_LISTA_ABONADO_VETADO_TO_LST_QT(StructDescriptor sd,Connection DBCon) throws SQLException
	{
		STRUCT[] arreglo = null;		
		if(sd!=null && DBCon!=null)
		{
			arreglo=new STRUCT [this.AbonadoVetadoList.length];			
			for (int i=0;i<this.AbonadoVetadoList.length; i++) 
			{						
				arreglo[i] = new STRUCT(sd, DBCon, this.AbonadoVetadoList[i].toStruct_SV_LISTA_ABONADO_VETADO_TO_QT());	
			}
		}
		return arreglo;
   }

}
