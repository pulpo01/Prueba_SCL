package com.tmmas.scl.operations.crm.f.s.manpro.web.form;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

import com.tmmas.scl.operations.crm.f.s.manpro.web.helper.InterBitaForm;

public class ClienteForm extends ActionForm implements InterBitaForm {

	private static final long serialVersionUID = 1L;

	private String nombre;

	private String idCliente;

	private String idAbonado;
//  ver como hacer mas dinamico este tema..
	private String pagina="NivelContracTile";

	private int accion=-1;

	private boolean checkTodos;
	private String[] listaTiposCom;
	
	private String cadenaProductosSeleccionados="";
	
	public String getCadenaProductosSeleccionados() {
		return cadenaProductosSeleccionados;
	}

	public void setCadenaProductosSeleccionados(String cadenaProductosSeleccionados) {
		this.cadenaProductosSeleccionados = cadenaProductosSeleccionados;
	}

	public boolean isCheckTodos() {
		return checkTodos;
	}

	public void setCheckTodos(boolean checkTodos) {
		this.checkTodos = checkTodos;
	}

	public String[] getListaTiposCom() {
		return listaTiposCom;
	}

	public void setListaTiposCom(String[] listaTiposCom) {
		this.listaTiposCom = listaTiposCom;
	}

	public String getIdCliente() {
		return idCliente;
	}

	public void setIdCliente(String idCliente) {
		this.idCliente = idCliente;
	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public void reset(ActionMapping mapping, HttpServletRequest request) {

	}

	public ActionErrors validate(ActionMapping mapping,
			HttpServletRequest request) {
		ActionErrors errors = new ActionErrors();

		return errors;
	}

	public String getIdAbonado() {
		return idAbonado;
	}

	public void setIdAbonado(String idAbonado) {
		this.idAbonado = idAbonado;
	}

	public int getAccion() {
		// TODO Auto-generated method stub
		return this.accion;
	}

	public String getPagina() {
		// TODO Auto-generated method stub
		return pagina;
	}

	public void setAccion(int accion) {
		// TODO Auto-generated method stub
		this.accion = accion;
	}

	public void setPagina(String pagina) {
		// TODO Auto-generated method stub
		this.pagina = pagina;
	}

}