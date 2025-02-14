package com.tmmas.scl.framework.customerDomain.dataTransferObject;

import java.io.Serializable;

public class CausalDescuentoDTO  implements Serializable{
	
	
	private static final long serialVersionUID = 1L;
	private String codigoCausalDescuento;
	private String descripcionCausalDescuento;
	
	
	public String getCodigoCausalDescuento(){
		return codigoCausalDescuento;
	}
	public void setCodigoCausalDescuento(String codigoCausalDescuento){
		this.codigoCausalDescuento = codigoCausalDescuento;
	}
	public String getDescripcionCausalDescuento(){
		return descripcionCausalDescuento;
	}
	
	public void setDescripcionCausalDescuento(String descripcionCausalDescuento){
		this.descripcionCausalDescuento = descripcionCausalDescuento;
	}
		

	
}

