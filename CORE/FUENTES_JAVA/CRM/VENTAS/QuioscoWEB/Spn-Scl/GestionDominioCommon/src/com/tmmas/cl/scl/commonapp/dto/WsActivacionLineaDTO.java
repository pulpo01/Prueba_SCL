package com.tmmas.cl.scl.commonapp.dto;
import java.io.Serializable;



public class WsActivacionLineaDTO implements Serializable{

	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private WsAntecedentesVentaInDTO antecedentesVenta;
	private WsLineaInDTO[]             Lineas;
	
	public WsAntecedentesVentaInDTO getAntecedentesVenta() {
		return antecedentesVenta;
	}
	public void setAntecedentesVenta(WsAntecedentesVentaInDTO antecedentesVenta) {
		this.antecedentesVenta = antecedentesVenta;
	}
	public WsLineaInDTO[] getLineas() {
		return Lineas;
	}
	public void setLineas(WsLineaInDTO[] lineas) {
		Lineas = lineas;
	}
}
