package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class PlanComercialComDTO implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private String codigoCalifCliente;
	private int codigoPlanComercial;
	private String descripcionPlanComercial;
	/* --Indice del objeto por defecto */ 
    public static int indiceDefectoPlanComercial = -1;
    
	public String getCodigoCalifCliente() {
		return codigoCalifCliente;
	}
	public void setCodigoCalifCliente(String codigoCalifCliente) {
		this.codigoCalifCliente = codigoCalifCliente;
	}
	public int getCodigoPlanComercial() {
		return codigoPlanComercial;
	}
	public void setCodigoPlanComercial(int codigoPlanComercial) {
		this.codigoPlanComercial = codigoPlanComercial;
	}
	public String getDescripcionPlanComercial() {
		return descripcionPlanComercial;
	}
	public void setDescripcionPlanComercial(String descripcionPlanComercial) {
		this.descripcionPlanComercial = descripcionPlanComercial;
	}
	
}//fin class PlanComercialDTO
