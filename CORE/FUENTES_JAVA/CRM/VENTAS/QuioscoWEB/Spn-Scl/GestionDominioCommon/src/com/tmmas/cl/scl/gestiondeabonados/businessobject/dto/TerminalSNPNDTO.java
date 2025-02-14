package com.tmmas.cl.scl.gestiondeabonados.businessobject.dto;

import java.io.Serializable;

import com.tmmas.scl.framework.productDomain.dataTransferObject.TerminalDTO;

public class TerminalSNPNDTO extends TerminalDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String carga;
	private String nomUsuarioOracle;
	private String numTransaccionVenta;
	private String correlativoLinea;
	private String numOrden;

	public String getCorrelativoLinea() {
		return correlativoLinea;
	}

	public void setCorrelativoLinea(String correlativoLinea) {
		this.correlativoLinea = correlativoLinea;
	}

	public String getNumOrden() {
		return numOrden;
	}

	public void setNumOrden(String numOrden) {
		this.numOrden = numOrden;
	}

	public String getNumTransaccionVenta() {
		return numTransaccionVenta;
	}

	public void setNumTransaccionVenta(String numTransaccionVenta) {
		this.numTransaccionVenta = numTransaccionVenta;
	}

	public String getNomUsuarioOracle() {
		return nomUsuarioOracle;
	}

	public void setNomUsuarioOracle(String nomUsuarioOracle) {
		this.nomUsuarioOracle = nomUsuarioOracle;
	}

	public String getCarga() {
		return carga;
	}

	public void setCarga(String carga) {
		this.carga = carga;
	}

}
