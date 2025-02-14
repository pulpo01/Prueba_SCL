package com.tmmas.cl.scl.integracionsicsa.web.form;

import org.apache.struts.action.ActionForm;

public class MantenerCorreosForm extends ActionForm {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	/**
	 *@author H.O.M
	 */
	
	private String cmbGrupo;
	private String nuevoCorreo;
	private String nuevoUsuario;
	private String accion;
	private String antiCorreo;
	private String antiUsuario;
	
	public String getAntiCorreo() {
		return antiCorreo;
	}
	public void setAntiCorreo(String antiCorreo) {
		this.antiCorreo = antiCorreo;
	}
	public String getAntiUsuario() {
		return antiUsuario;
	}
	public void setAntiUsuario(String antiUsuario) {
		this.antiUsuario = antiUsuario;
	}
	public String getCmbGrupo() {
		return cmbGrupo;
	}
	public void setCmbGrupo(String cmbGrupo) {
		this.cmbGrupo = cmbGrupo;
	}
	public String getNuevoCorreo() {
		return nuevoCorreo;
	}
	public void setNuevoCorreo(String nuevoCorreo) {
		this.nuevoCorreo = nuevoCorreo;
	}
	public String getNuevoUsuario() {
		return nuevoUsuario;
	}
	public void setNuevoUsuario(String nuevoUsuario) {
		this.nuevoUsuario = nuevoUsuario;
	}
	public String getAccion() {
		return accion;
	}
	public void setAccion(String accion) {
		this.accion = accion;
	}
	
	
	
}
