package com.tmmas.cl.scl.spnsclwscommon.quiosco.dto;

import java.io.Serializable;

public class WsStructuraActivacionLineaDTO implements Serializable{


	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	
	private WsStructuraLineaDTO[] lineas;
	private WsStructuraAntecedentesVentaDTO AntecedentesVenta;


	public WsStructuraAntecedentesVentaDTO getAntecedentesVenta() {
		return AntecedentesVenta;
	}


	public void setAntecedentesVenta(
			WsStructuraAntecedentesVentaDTO antecedentesVenta) {
		AntecedentesVenta = antecedentesVenta;
	}


	public WsStructuraLineaDTO[] getLineas() {
		return lineas;
	}


	public void setLineas(WsStructuraLineaDTO[] lineas) {
		this.lineas = lineas;
	}

}
