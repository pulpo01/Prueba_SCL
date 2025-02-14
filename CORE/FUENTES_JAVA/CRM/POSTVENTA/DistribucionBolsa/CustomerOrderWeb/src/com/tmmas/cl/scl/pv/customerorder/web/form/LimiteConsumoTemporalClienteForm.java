package com.tmmas.cl.scl.pv.customerorder.web.form;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

public class LimiteConsumoTemporalClienteForm extends ActionForm {
	private static final long serialVersionUID = 1L;
	private String[] valorAsignado;
	private String[] checked;
	private String accion;
	
	public void reset(ActionMapping mapping, HttpServletRequest request) {
		accion = "mostrar";
	}

	public ActionErrors validate(ActionMapping mapping, HttpServletRequest request) {
		return super.validate(mapping, request);
	}

	public String[] getChecked() {
		return checked;
	}

	public void setChecked(String[] checked) {
		this.checked = checked;
	}

	public String[] getValorAsignado() {
		return valorAsignado;
	}

	public void setValorAsignado(String[] valorAsignado) {
		this.valorAsignado = valorAsignado;
	}

	public String getAccion() {
		return accion;
	}

	public void setAccion(String accion) {
		this.accion = accion;
	}
}
