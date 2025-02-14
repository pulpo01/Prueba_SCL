package com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring;

import java.io.Serializable;

public class TipoComportamientoDTO implements Serializable {

	/**
	 * © 2010 - TM-mAs
	 */
	private static final long serialVersionUID = -2253152935804100993L;

	private String descripcionValor;

	private String valor;

	public String getDescripcionValor() {
		return descripcionValor;
	}

	public String getValor() {
		return valor;
	}

	public void setDescripcionValor(String descripcionValor) {
		this.descripcionValor = descripcionValor;
	}

	public void setValor(String valor) {
		this.valor = valor;
	}

	public String toString() {
		final String nl = "\n";
		StringBuffer b = new StringBuffer();
		b.append("TipoComportamientoDTO ( ").append(super.toString()).append(nl);
		b.append("descripcionValor = ").append(this.descripcionValor).append(nl);
		b.append("valor = ").append(this.valor).append(nl);
		b.append(" )");
		return b.toString();
	}

}
