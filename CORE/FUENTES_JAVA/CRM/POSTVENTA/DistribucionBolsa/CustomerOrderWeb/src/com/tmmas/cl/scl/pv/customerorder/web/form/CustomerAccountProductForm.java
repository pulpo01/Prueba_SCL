package com.tmmas.cl.scl.pv.customerorder.web.form;

import javax.servlet.http.HttpServletRequest;
import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

public class CustomerAccountProductForm extends ActionForm {
	private static final long serialVersionUID = 1L;
		
	private String accion;
	String[] checkedInstall;
	String[] checkedUnInstall;
	
	
	public void reset(ActionMapping mapping, HttpServletRequest request) {
		accion = "mostrar";
	}
	public ActionErrors validate(ActionMapping mapping, HttpServletRequest request) {
		
		return super.validate(mapping, request);
	}		
	public String getAccion() {
		return accion;
	}
	public void setAccion(String accion) {
		this.accion = accion;
	}
	public String[] getCheckedInstall() {
		return checkedInstall;
	}
	public void setCheckedInstall(String[] checkedInstall) {
		this.checkedInstall = checkedInstall;
	}
	public String[] getCheckedUnInstall() {
		return checkedUnInstall;
	}
	public void setCheckedUnInstall(String[] checkedUnInstall) {
		this.checkedUnInstall = checkedUnInstall;
	}
}
