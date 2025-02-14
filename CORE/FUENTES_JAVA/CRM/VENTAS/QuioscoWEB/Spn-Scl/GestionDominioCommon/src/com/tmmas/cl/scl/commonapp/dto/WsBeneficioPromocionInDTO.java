package com.tmmas.cl.scl.commonapp.dto;

import java.io.Serializable;

public class WsBeneficioPromocionInDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String ClienteAboando;
	private String CodigoTipoPlan;
	
	public String getClienteAboando() {
		return ClienteAboando;
	}
	public void setClienteAboando(String clienteAboando) {
		ClienteAboando = clienteAboando;
	}
	public String getCodigoTipoPlan() {
		return CodigoTipoPlan;
	}
	public void setCodigoTipoPlan(String codigoTipoPlan) {
		CodigoTipoPlan = codigoTipoPlan;
	}
	

}
