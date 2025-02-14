package com.tmmas.scl.quiosco.web.form;

import org.apache.struts.action.ActionForm;

public class LoginForm extends ActionForm{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String accionLogin;
	private String tienda;
    
	public String getAccionLogin() {
		return accionLogin;
	}
	public void setAccionLogin(String accionLogin) {
		this.accionLogin = accionLogin;
	}
	public String getTienda() {
		return tienda;
	}
	public void setTienda(String tienda) {
		this.tienda = tienda;
	}


}
