package com.tmmas.scl.operations.crm.f.s.manpro.web.form;

import org.apache.struts.action.ActionForm;

public class CargosForm extends ActionForm
{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String[] codConceptos=null;
	private String[] totalDescuentos={"0"};
	private String[] cantidades=null;

	public String[] getTotalDescuentos() {
		return totalDescuentos;
	}

	public void setTotalDescuentos(String[] totalDescuentos) {
		this.totalDescuentos = totalDescuentos;
	}

	public String[] getCodConceptos() {
		return codConceptos;
	}

	public void setCodConceptos(String[] codConceptos) {
		this.codConceptos = codConceptos;
	}

	public String[] getCantidades() {
		return cantidades;
	}

	public void setCantidades(String[] cantidades) {
		this.cantidades = cantidades;
	}
}
