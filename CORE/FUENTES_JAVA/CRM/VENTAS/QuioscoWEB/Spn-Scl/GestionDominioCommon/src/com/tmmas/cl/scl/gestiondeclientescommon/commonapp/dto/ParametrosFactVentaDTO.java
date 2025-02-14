package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class ParametrosFactVentaDTO implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String indTransaccion;
	private String obsFactVenta;
	private ParametrosLineasFactVentaDTO[] parametrosLineasFactVentaDTO;
	private String usuario;
	
	public String getUsuario() {
		return usuario;
	}
	public void setUsuario(String usuario) {
		this.usuario = usuario;
	}
	public String getIndTransaccion() {
		return indTransaccion;
	}
	public void setIndTransaccion(String indTransaccion) {
		this.indTransaccion = indTransaccion;
	}
	public String getObsFactVenta() {
		return obsFactVenta;
	}
	public void setObsFactVenta(String obsFactVenta) {
		this.obsFactVenta = obsFactVenta;
	}
	public ParametrosLineasFactVentaDTO[] getParametrosLineasFactVentaDTO() {
		return parametrosLineasFactVentaDTO;
	}
	public void setParametrosLineasFactVentaDTO(
			ParametrosLineasFactVentaDTO[] parametrosLineasFactVentaDTO) {
		this.parametrosLineasFactVentaDTO = parametrosLineasFactVentaDTO;
	}
}
