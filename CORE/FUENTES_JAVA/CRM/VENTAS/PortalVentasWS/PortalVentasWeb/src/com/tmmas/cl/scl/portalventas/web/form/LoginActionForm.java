package com.tmmas.cl.scl.portalventas.web.form;
import org.apache.struts.action.*;
import javax.servlet.http.*;

public class LoginActionForm extends ActionForm {
	private static final long serialVersionUID = 1L;
	private String usuario = null;
	private String clave = null;
	
	//Inicio P-CSR-11002 JLGN 09-05-2011
	private String flagInicio;
	//Fin P-CSR-11002 JLGN 09-05-2011
	
	public String getClave() {
		return clave;
	}
	public void setClave(String clave) {
		this.clave = clave;
	}
	public String getUsuario() {
		return usuario;
	}
	public void setUsuario(String usuario) {
		this.usuario = usuario;
	}

	public ActionErrors validate(	ActionMapping mapping,
            						HttpServletRequest request) 
	{
		ActionErrors errors = null;
		return errors;
	}
	public String getFlagInicio() {
		return flagInicio;
	}
	public void setFlagInicio(String flagInicio) {
		this.flagInicio = flagInicio;
	}	
}
