package com.tmmas.cl.scl.customerdomain.businessobject.dto;

import java.io.Serializable;

public class FaConceptoDTO implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	protected String codConcepto;
	protected String codMoneda;
	protected String codTipConce;
	protected String desConcep;
	public String getDesConcep() {
		return desConcep;
	}
	public void setDesConcep(String desConcep) {
		this.desConcep = desConcep;
	}
	public String getCodConcepto() {
		return codConcepto;
	}
	public void setCodConcepto(String codConcepto) {
		this.codConcepto = codConcepto;
	}
	public String getCodMoneda() {
		return codMoneda;
	}
	public void setCodMoneda(String codMoneda) {
		this.codMoneda = codMoneda;
	}
	public String getCodTipConce() {
		return codTipConce;
	}
	public void setCodTipConce(String codTipConce) {
		this.codTipConce = codTipConce;
	}

}
