package com.tmmas.scl.quiosco.web.form;

import org.apache.struts.action.ActionForm;

public class InicioForm extends ActionForm{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String accionInicio;
	private String tienda;
	
	public String getTienda() {
		return tienda;
	}
	
	public void setTienda(String tienda) {
		this.tienda = tienda;
	}

	public String getAccionInicio() {
		return accionInicio;
	}

	public void setAccionInicio(String accionInicio) {
		this.accionInicio = accionInicio;
	}
}
