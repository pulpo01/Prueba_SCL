package com.tmmas.cl.scl.portalventas.web.form;

import org.apache.struts.action.ActionForm;

public class NumerosFrecuentesForm extends ActionForm {

	private static final long serialVersionUID = 1L;
	
	private int maxNumFijos=5; //CAMBIAR ESTOS VALORES
	private int maxNumMoviles=6;
	
	public int getMaxNumFijos() {
		return maxNumFijos;
	}
	public void setMaxNumFijos(int maxNumFijos) {
		this.maxNumFijos = maxNumFijos;
	}
	public int getMaxNumMoviles() {
		return maxNumMoviles;
	}
	public void setMaxNumMoviles(int maxNumMoviles) {
		this.maxNumMoviles = maxNumMoviles;
	}
	
}
