package com.tmmas.cl.scl.spnsclwscommon.commonapp.dto.in;

import java.io.Serializable;

import com.tmmas.cl.scl.commonapp.dto.WsAntecedentesVentaInDTO;
import com.tmmas.cl.scl.commonapp.dto.WsLineaInDTO;

public class WsActivacionInDTO implements Serializable{
	
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
