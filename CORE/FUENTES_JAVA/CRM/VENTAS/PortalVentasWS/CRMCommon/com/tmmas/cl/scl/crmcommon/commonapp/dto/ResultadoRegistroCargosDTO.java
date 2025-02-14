package com.tmmas.cl.scl.crmcommon.commonapp.dto;

import java.io.Serializable;

public class ResultadoRegistroCargosDTO implements Serializable{
	
	private static final long serialVersionUID = 1L;

	private ImpuestosDTO impuestos;

	private boolean prebillingOK;
	public boolean isPrebillingOK() {
		return prebillingOK;
	}
	public void setPrebillingOK(boolean prebillingOK) {
		this.prebillingOK = prebillingOK;
	}
	public ImpuestosDTO getImpuestos() {
		return impuestos;
	}
	public void setImpuestos(ImpuestosDTO impuestos) {
		this.impuestos = impuestos;
	}

}
