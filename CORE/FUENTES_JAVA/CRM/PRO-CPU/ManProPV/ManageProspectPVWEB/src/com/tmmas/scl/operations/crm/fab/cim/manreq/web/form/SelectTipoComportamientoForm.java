package com.tmmas.scl.operations.crm.fab.cim.manreq.web.form;
import org.apache.struts.action.ActionForm;

public class SelectTipoComportamientoForm extends ActionForm {

	private static final long serialVersionUID = 1L;
	
	private boolean checkTodos;
	private String[] listaTiposCom;
	private String cadenaProductosSeleccionados="";
	
	public String getCadenaProductosSeleccionados() {
		return cadenaProductosSeleccionados;
	}

	public void setCadenaProductosSeleccionados(String cadenaProductosSeleccionados) {
		this.cadenaProductosSeleccionados = cadenaProductosSeleccionados;
	}

	public String[] getListaTiposCom() {
		return listaTiposCom;
	}

	public void setListaTiposCom(String[] listaTiposCom) {
		this.listaTiposCom = listaTiposCom;
	}

	public boolean isCheckTodos() {
		return checkTodos;
	}

	public void setCheckTodos(boolean checkTodos) {
		this.checkTodos = checkTodos;
	}
}
