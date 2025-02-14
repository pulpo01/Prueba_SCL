package com.tmmas.scl.quiosco.web.form;

import org.apache.struts.action.ActionForm;

public class RegistroUsuarioForm extends ActionForm{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String nomUsuario;
    private String primerApellidoUsuario;
    private String segundoApellidoUsuario;
    private String eMailUsuario;
    private String telefonoContactoUsuario;
    private String simcardUsuario;
    private String imeiUsuario;
    private String celularUsuario;
    private String codigoCentral;

    private String accionRegUsuario;
    
	public String getNomUsuario() {
		return nomUsuario;
	}
	public void setNomUsuario(String nomUsuario) {
		this.nomUsuario = nomUsuario;
	}
	public String getPrimerApellidoUsuario() {
		return primerApellidoUsuario;
	}
	public void setPrimerApellidoUsuario(String primerApellidoUsuario) {
		this.primerApellidoUsuario = primerApellidoUsuario;
	}
	public String getSegundoApellidoUsuario() {
		return segundoApellidoUsuario;
	}
	public void setSegundoApellidoUsuario(String segundoApellidoUsuario) {
		this.segundoApellidoUsuario = segundoApellidoUsuario;
	}
	public String getEMailUsuario() {
		return eMailUsuario;
	}
	public void setEMailUsuario(String mailUsuario) {
		eMailUsuario = mailUsuario;
	}
	public String getTelefonoContactoUsuario() {
		return telefonoContactoUsuario;
	}
	public void setTelefonoContactoUsuario(String telefonoContactoUsuario) {
		this.telefonoContactoUsuario = telefonoContactoUsuario;
	}
	public String getSimcardUsuario() {
		return simcardUsuario;
	}
	public void setSimcardUsuario(String simcardUsuario) {
		this.simcardUsuario = simcardUsuario;
	}
	public String getImeiUsuario() {
		return imeiUsuario;
	}
	public void setImeiUsuario(String imeiUsuario) {
		this.imeiUsuario = imeiUsuario;
	}
	public String getCelularUsuario() {
		return celularUsuario;
	}
	public void setCelularUsuario(String celularUsuario) {
		this.celularUsuario = celularUsuario;
	}
	public String getAccionRegUsuario() {
		return accionRegUsuario;
	}
	public void setAccionRegUsuario(String accionRegUsuario) {
		this.accionRegUsuario = accionRegUsuario;
	}
	public String getCodigoCentral() {
		return codigoCentral;
	}
	public void setCodigoCentral(String codigoCentral) {
		this.codigoCentral = codigoCentral;
	}
	
    
    
}
