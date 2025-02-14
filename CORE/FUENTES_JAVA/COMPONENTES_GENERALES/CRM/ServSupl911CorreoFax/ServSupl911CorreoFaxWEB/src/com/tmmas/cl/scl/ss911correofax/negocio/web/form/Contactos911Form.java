package com.tmmas.cl.scl.ss911correofax.negocio.web.form;

import org.apache.struts.action.ActionForm;

public class Contactos911Form extends ActionForm {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	protected String contactosTabla;	// array con todos los contactos en modo de mantenimiento
	
	
	
	public String getContactosTabla() {
		return contactosTabla;
	}
	public void setContactosTabla(String contactosTabla) {
		this.contactosTabla = contactosTabla;
	}
	
}
