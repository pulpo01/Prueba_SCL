package com.tmmas.cl.scl.commonapp.dto;

import java.io.Serializable;

public class WsFacturacionVentaInDTO implements Serializable{
	
	/**
	 * 
	**/
	private static final long serialVersionUID = 1L;
	private String numVenta;
	private String nomUsuario;
	private String obsFactVenta;
	private String IdentificadorTransaccion;
	private boolean facturaACiclo;
	
    private WsFacturacionLineaDTO[] facturacionLinea;

	public WsFacturacionLineaDTO[] getFacturacionLinea() {
		return facturacionLinea;
	}

	public void setFacturacionLinea(WsFacturacionLineaDTO[] facturacionLinea) {
		this.facturacionLinea = facturacionLinea;
	}

	public String getNumVenta() {
		return numVenta;
	}

	public void setNumVenta(String numVenta) {
		this.numVenta = numVenta;
	}

	public String getNomUsuario() {
		return nomUsuario;
	}

	public void setNomUsuario(String nomUsuario) {
		this.nomUsuario = nomUsuario;
	}

	public String getObsFactVenta() {
		return obsFactVenta;
	}

	public void setObsFactVenta(String obsFactVenta) {
		this.obsFactVenta = obsFactVenta;
	}

	public String getIdentificadorTransaccion() {
		return IdentificadorTransaccion;
	}

	public void setIdentificadorTransaccion(String identificadorTransaccion) {
		IdentificadorTransaccion = identificadorTransaccion;
	}

	public boolean isFacturaACiclo() {
		return facturaACiclo;
	}

	public void setFacturaACiclo(boolean facturaACiclo) {
		this.facturaACiclo = facturaACiclo;
	}

}
