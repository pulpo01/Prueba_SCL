package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class CampanaVigenteComDTO  implements Serializable{
	
	
	private static final long serialVersionUID = 1L;
	private String codigoCampanasVigentes;
	private String descripcionCampanasVigentes;
	private long codigoCliente;
		
	public long getCodigoCliente() {
		return codigoCliente;
	}
	public void setCodigoCliente(long codigoCliente) {
		this.codigoCliente = codigoCliente;
	}
	public String getCodigoCampanasVigentes(){
		return codigoCampanasVigentes;
	}
	public void setCodigoCampanasVigentes(String codigoCampanasVigentes){
		this.codigoCampanasVigentes = codigoCampanasVigentes;
	}
	public String getDescripcionCampanasVigentes(){
		return descripcionCampanasVigentes;
	}
	
	public void setDescripcionCampanasVigentes(String descripcionCampanasVigentes){
		this.descripcionCampanasVigentes = descripcionCampanasVigentes;
	}
		

	
}
