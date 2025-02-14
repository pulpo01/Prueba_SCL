package com.tmmas.scl.operations.crm.f.s.manpro.web.form;

import org.apache.struts.action.ActionForm;

public class ListAfinesForm extends ActionForm{
	
	private String  codigoCliente;
    private String  nombreCliente;
	
	
	public String getCodigoCliente() {
		return codigoCliente;
	}

	public void setCodigoCliente(String codigoCliente) {
		this.codigoCliente = codigoCliente;
	}

	public String getNombreCliente() {
		return nombreCliente;
	}

	public void setNombreCliente(String nombreCliente) {
		this.nombreCliente = nombreCliente;
	}
	
	

}
