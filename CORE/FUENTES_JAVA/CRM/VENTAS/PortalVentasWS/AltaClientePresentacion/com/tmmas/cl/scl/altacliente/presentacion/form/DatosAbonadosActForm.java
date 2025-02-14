package com.tmmas.cl.scl.altacliente.presentacion.form;

import org.apache.struts.action.ActionForm;

public class DatosAbonadosActForm extends ActionForm {
	private static final long serialVersionUID = 1L;

	private String strTipIdentConsAbo;
	private String strNumIdentConsAbo;
	
	public String getStrNumIdentConsAbo() {
		return strNumIdentConsAbo;
	}
	public void setStrNumIdentConsAbo(String strNumIdentConsAbo) {
		this.strNumIdentConsAbo = strNumIdentConsAbo;
	}
	public String getStrTipIdentConsAbo() {
		return strTipIdentConsAbo;
	}
	public void setStrTipIdentConsAbo(String strTipIdentConsAbo) {
		this.strTipIdentConsAbo = strTipIdentConsAbo;
	}
}
