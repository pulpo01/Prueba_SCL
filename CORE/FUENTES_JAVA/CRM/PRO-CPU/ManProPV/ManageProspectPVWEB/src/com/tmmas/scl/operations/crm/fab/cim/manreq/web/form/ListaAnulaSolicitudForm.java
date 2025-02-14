package com.tmmas.scl.operations.crm.fab.cim.manreq.web.form;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

public class ListaAnulaSolicitudForm extends ActionForm {
	
	private String idProductoContratado;
	private String codigoProducto;
	private String nombreProducto;
	private String condicH;
	private boolean condicionesCK;
	private String estadoValidacion;
	private String numeroAgregar;
	private String guardarCancelar;
	private String inicio;
	private boolean personalizados;
	private String[] listaAbonados;
	private boolean checkTodos;
	
	public boolean isPersonalizados() {
		return personalizados;
	}
	public void setPersonalizados(boolean personalizados) {
		this.personalizados = personalizados;
	}
	public String getGuardarCancelar() {
		return guardarCancelar;
	}
	public void setGuardarCancelar(String guardarCancelar) {
		this.guardarCancelar = guardarCancelar;
	}
	public String getNumeroAgregar() {
		return numeroAgregar;
	}
	public void setNumeroAgregar(String numeroAgregar) {
		this.numeroAgregar = numeroAgregar;
	}
	public String getEstadoValidacion() {
		return estadoValidacion;
	}
	public void setEstadoValidacion(String estadoValidacion) {
		this.estadoValidacion = estadoValidacion;
	}
	public String getCondicH() {
		return condicH;
	}
	public void setCondicH(String condicH) {
		this.condicH = condicH;
	}
	public boolean isCondicionesCK() {
		return condicionesCK;
	}
	public void setCondicionesCK(boolean condicionesCK) {
		this.condicionesCK = condicionesCK;
	}
	
	public void reset(ActionMapping mapping, HttpServletRequest request){
		condicionesCK=false;
	}
	public String getCodigoProducto() {
		return codigoProducto;
	}
	public void setCodigoProducto(String codigoProducto) {
		this.codigoProducto = codigoProducto;
	}
	public String getIdProductoContratado() {
		return idProductoContratado;
	}
	public void setIdProductoContratado(String idProductoContratado) {
		this.idProductoContratado = idProductoContratado;
	}
	public String getNombreProducto() {
		return nombreProducto;
	}
	public void setNombreProducto(String nombreProducto) {
		this.nombreProducto = nombreProducto;
	}
	public String getInicio() {
		return inicio;
	}
	public void setInicio(String inicio) {
		this.inicio = inicio;
	}
	public String[] getListaAbonados() {
		return listaAbonados;
	}
	public void setListaAbonados(String[] listaAbonados) {
		this.listaAbonados = listaAbonados;
	}
	public boolean isCheckTodos() {
		return checkTodos;
	}
	public void setCheckTodos(boolean checkTodos) {
		this.checkTodos = checkTodos;
	}
			

}
