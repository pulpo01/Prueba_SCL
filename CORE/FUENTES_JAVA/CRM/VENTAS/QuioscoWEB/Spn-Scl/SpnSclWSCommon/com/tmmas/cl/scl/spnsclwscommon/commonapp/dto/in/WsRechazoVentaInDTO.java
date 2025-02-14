package com.tmmas.cl.scl.spnsclwscommon.commonapp.dto.in;

import java.io.Serializable;

public class WsRechazoVentaInDTO implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String venta;
	private String IdentificadorTransaccion;
	private String usuario;
	
	
	public String getIdentificadorTransaccion() {
		return IdentificadorTransaccion;
	}
	public void setIdentificadorTransaccion(String identificadorTransaccion) {
		IdentificadorTransaccion = identificadorTransaccion;
	}
	public String getUsuario() {
		return usuario;
	}
	public void setUsuario(String usuario) {
		this.usuario = usuario;
	}
	public String getVenta() {
		return venta;
	}
	public void setVenta(String venta) {
		this.venta = venta;
	}
	
	

}
