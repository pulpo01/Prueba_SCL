package com.tmmas.cl.scl.integracionsicsa.web.form;

import org.apache.struts.action.ActionForm;

public class BuscaDetalleDevolucionForm extends ActionForm {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	/**
	 *@author H.O.M
	 */
	
	private String codDevolucionBusc;
	private String linDevolucionBusc;
	private String opcion;
	
	public String getCodDevolucionBusc() {
		return codDevolucionBusc;
	}
	public void setCodDevolucionBusc(String codDevolucionBusc) {
		this.codDevolucionBusc = codDevolucionBusc;
	}
	public String getLinDevolucionBusc() {
		return linDevolucionBusc;
	}
	public void setLinDevolucionBusc(String linDevolucionBusc) {
		this.linDevolucionBusc = linDevolucionBusc;
	}
	public String getOpcion() {
		return opcion;
	}
	public void setOpcion(String opcion) {
		this.opcion = opcion;
	}

}
