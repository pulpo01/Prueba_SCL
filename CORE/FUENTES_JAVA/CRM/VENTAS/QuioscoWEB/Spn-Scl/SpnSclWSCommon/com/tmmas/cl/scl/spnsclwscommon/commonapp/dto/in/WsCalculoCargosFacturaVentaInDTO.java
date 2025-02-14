package com.tmmas.cl.scl.spnsclwscommon.commonapp.dto.in;

import java.io.Serializable;

public class WsCalculoCargosFacturaVentaInDTO implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String identificadorTransaccion;
	private String observacionFactura;
    private WsAltaCargoInDTO[] AltaCargo;
    
    
	public WsAltaCargoInDTO[] getAltaCargo() {
		return AltaCargo;
	}
	public void setAltaCargo(WsAltaCargoInDTO[] altaCargo) {
		AltaCargo = altaCargo;
	}
	public String getIdentificadorTransaccion() {
		return identificadorTransaccion;
	}
	public void setIdentificadorTransaccion(String identificadorTransaccion) {
		this.identificadorTransaccion = identificadorTransaccion;
	}
	public String getObservacionFactura() {
		return observacionFactura;
	}
	public void setObservacionFactura(String observacionFactura) {
		this.observacionFactura = observacionFactura;
	} 



}
