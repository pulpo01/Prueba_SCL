package com.tmmas.scl.doblecuenta.form;

import org.apache.struts.action.ActionForm;

public class IdenClienteForm extends ActionForm {
	
	
	private static final long serialVersionUID = 1L;
	
	private String nomCliente;
	private String apellido1;
	private String apellido2;
	private String codCliente;
	private String codOOSS;
	private String codIdentCliente; 
	private String idenCliente;
	private String desTipIdent;
	private String msgError;
	private String userName;
	private String comentario;
	
	public String getComentario() {
		return comentario;
	}
	public void setComentario(String comentario) {
		this.comentario = comentario;
	}
	public String getApellido1() {
		return apellido1;
	}
	public void setApellido1(String apellido1) {
		this.apellido1 = apellido1;
	}
	public String getApellido2() {
		return apellido2;
	}
	public void setApellido2(String apellido2) {
		this.apellido2 = apellido2;
	}
	public String getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(String codCliente) {
		this.codCliente = codCliente;
	}
	public String getCodIdentCliente() {
		return codIdentCliente;
	}
	public void setCodIdentCliente(String codIdentCliente) {
		this.codIdentCliente = codIdentCliente;
	}
	public String getCodOOSS() {
		return codOOSS;
	}
	public void setCodOOSS(String codOOSS) {
		this.codOOSS = codOOSS;
	}
	public String getDesTipIdent() {
		return desTipIdent;
	}
	public void setDesTipIdent(String desTipIdent) {
		this.desTipIdent = desTipIdent;
	}
	public String getIdenCliente() {
		return idenCliente;
	}
	public void setIdenCliente(String idenCliente) {
		this.idenCliente = idenCliente;
	}
	public String getMsgError() {
		return msgError;
	}
	public void setMsgError(String msgError) {
		this.msgError = msgError;
	}
	public String getNomCliente() {
		return nomCliente;
	}
	public void setNomCliente(String nomCliente) {
		this.nomCliente = nomCliente;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	
	
	
	

}
