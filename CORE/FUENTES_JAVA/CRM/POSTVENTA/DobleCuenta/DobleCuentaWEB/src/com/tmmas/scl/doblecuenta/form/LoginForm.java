package com.tmmas.scl.doblecuenta.form;

import org.apache.struts.action.ActionForm;

public class LoginForm extends ActionForm {

	private String user;

	private String password;

	public String getUser() {
		return user;
	}

	public void setUser(String string) {
		user = string;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String string) {
		password = string;
	}

	public LoginForm() {
	}

}
