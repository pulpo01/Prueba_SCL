package com.tmmas.scl.vendedor.web.form;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

public class VendedorForm extends ActionForm {

	private static final long serialVersionUID = 1L;
	
	private String codVendedor;
	
	private String ind_interno;

	public String getCodVendedor() {
		return codVendedor;
	}

	public void setCodVendedor(String codVendedor) {
		this.codVendedor = codVendedor;
	}

	public String getInd_interno() {
		return ind_interno;
	}

	public void setInd_interno(String ind_interno) {
		this.ind_interno = ind_interno;
	}

	public void reset(ActionMapping mapping, HttpServletRequest request) {
		ind_interno = "1";
		codVendedor = "";

	}

	public ActionErrors validate(ActionMapping mapping, HttpServletRequest request) {
		return super.validate(mapping, request);
	}
}
