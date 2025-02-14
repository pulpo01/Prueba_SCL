package com.tmmas.scl.framework.productDomain.dataTransferObject;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.SQLException;

import oracle.sql.STRUCT;
import oracle.sql.StructDescriptor;

public class AbonadoBeneficiarioListDTO implements Serializable
{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private AbonadoBeneficiarioDTO [] AbonadoBeneficiarioList;

	public AbonadoBeneficiarioListDTO()
	{
	
	}
	
	public AbonadoBeneficiarioDTO[] getAbonadoBeneficiarioList() {
		return AbonadoBeneficiarioList;
	}

	public void setAbonadoBeneficiarioList(
			AbonadoBeneficiarioDTO[] abonadoBeneficiarioList) {
		AbonadoBeneficiarioList = abonadoBeneficiarioList;
	}
	
	public STRUCT[] getOracleArray_SV_LISTA_ABONADO_BENEFICIARIO_TO_LST_QT(StructDescriptor sd,Connection DBCon) throws SQLException
	{
		STRUCT[] arreglo = null;		
		if(sd!=null && DBCon!=null)
		{
			arreglo=new STRUCT [this.AbonadoBeneficiarioList.length];			
			for (int i=0;i<this.AbonadoBeneficiarioList.length; i++) 
			{						
				arreglo[i] = new STRUCT(sd, DBCon, this.AbonadoBeneficiarioList[i].toStruct_SV_LISTA_ABONADO_BENEFICIARIO_TO_QT());	
			}
		}
		return arreglo;
   }
}
