package com.tmmas.scl.quiosco.web.form;

import org.apache.struts.action.ActionForm;

public class PDFForm extends ActionForm{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String accionPDF;

	public String getAccionPDF() {
		return accionPDF;
	}

	public void setAccionPDF(String accionPDF) {
		this.accionPDF = accionPDF;
	}


}
