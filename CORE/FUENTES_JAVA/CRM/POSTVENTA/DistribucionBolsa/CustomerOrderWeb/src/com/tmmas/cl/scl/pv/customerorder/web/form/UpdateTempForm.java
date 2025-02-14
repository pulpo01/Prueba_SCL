package com.tmmas.cl.scl.pv.customerorder.web.form;

import org.apache.struts.action.ActionForm;

public class UpdateTempForm extends ActionForm {
	private static final long serialVersionUID = 1L;
	
	private int[] selected;
	private String[] montos;
	

	public int[] getSelected() {
		return selected;
	}

	public void setSelected(int[] selected) {
		this.selected = selected;
	}

	public String[] getMontos() {
		return montos;
	}

	public void setMontos(String[] montos) {
		this.montos = montos;
	}



	

}
