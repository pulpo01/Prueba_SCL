package com.tmmas.cl.scl.spnsclwscommon.quiosco.dto;

import java.io.Serializable;

public class WsCreaStructuraComercialInDTO implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	
	private WsStructuraCuentaInDTO cuenta;
	private String UsuarioOracle;
	private String UsuarioAD;
	private WsStructuraPagoDTO pago;
	private String codPrestacion;
	private String codPlanTarif;//JLGN

	public String getCodPlanTarif() {
		return codPlanTarif;
	}


	public void setCodPlanTarif(String codPlanTarif) {
		this.codPlanTarif = codPlanTarif;
	}


	public String getCodPrestacion() {
		return codPrestacion;
	}


	public void setCodPrestacion(String codPrestacion) {
		this.codPrestacion = codPrestacion;
	}


	public WsStructuraPagoDTO getPago() {
		return pago;
	}


	public void setPago(WsStructuraPagoDTO pago) {
		this.pago = pago;
	}


	public String getUsuarioOracle() {
		return UsuarioOracle;
	}


	public void setUsuarioOracle(String usuarioOracle) {
		UsuarioOracle = usuarioOracle;
	}


	public WsStructuraCuentaInDTO getCuenta() {
		return cuenta;
	}


	public void setCuenta(WsStructuraCuentaInDTO cuenta) {
		this.cuenta = cuenta;
	}


	public String getUsuarioAD() {
		return UsuarioAD;
	}


	public void setUsuarioAD(String usuarioAD) {
		UsuarioAD = usuarioAD;
	} 

}
