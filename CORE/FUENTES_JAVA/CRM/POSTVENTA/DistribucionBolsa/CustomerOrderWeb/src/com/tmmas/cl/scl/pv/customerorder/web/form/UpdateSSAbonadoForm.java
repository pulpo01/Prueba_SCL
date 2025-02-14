/**
 * Copyright © 2005 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 13/08/2006     Jimmy Lopez              		Versión Inicial
 */

package com.tmmas.cl.scl.pv.customerorder.web.form;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Category;
import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

public class UpdateSSAbonadoForm extends ActionForm {
	
	private Category cat = Category
	.getInstance(UpdateSSAbonadoForm.class);

	private static final long serialVersionUID = 1L;

	private String accion;

	private int editar;
	
	//arreglo de productos
	private int[] numProduct;
	
	private boolean todas;
	
	private String priority;
	private String exceedId;
	private String profileId;	
	
	private List listaProductos;


	public String getAccion() {
		return accion;
	}

	public void setAccion(String accion) {
		this.accion = accion;
	}

	public int getEditar() {
		return editar;
	}

	public void setEditar(int editar) {
		this.editar = editar;
	}

	public String getExceedId() {
		return exceedId;
	}

	public void setExceedId(String exceedId) {
		this.exceedId = exceedId;
	}


	public List getListaProductos() {
		return listaProductos;
	}

	public void setListaProductos(List listaProductos) {
		this.listaProductos = listaProductos;
	}

	public int[] getNumProduct() {
		return numProduct;
	}

	public void setNumProduct(int[] numProduct) {
		this.numProduct = numProduct;
	}

	public String getPriority() {
		return priority;
	}

	public void setPriority(String priority) {
		this.priority = priority;
	}

	public String getProfileId() {
		return profileId;
	}

	public void setProfileId(String profileId) {
		this.profileId = profileId;
	}

	public boolean isTodas() {
		return todas;
	}

	public void setTodas(boolean todas) {
		this.todas = todas;
	}

	public UpdateSSAbonadoForm() {
		cat.debug("constructor UpdateSSClienteForm");
	}

	public void reset(ActionMapping mapping, HttpServletRequest request) {
		cat.info("reset():start");
		accion = "Mostrar";
		todas = false;
		editar = -1;
		numProduct = null;
		cat.info("reset():stop");
	}

	public ActionErrors validate(ActionMapping mapping, HttpServletRequest request) {
		ActionErrors actionErrors = new ActionErrors();
		return actionErrors;
	}
	
}
