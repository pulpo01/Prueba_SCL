package com.tmmas.scl.operations.crm.f.s.manpro.web.form;

import org.apache.struts.action.ActionForm;

import com.tmmas.scl.operations.crm.f.s.manpro.web.helper.InterBitaForm;

public class BitaForm extends ActionForm implements InterBitaForm{
	private String pagina;
	private String bitacora;
	private int accion;
	

	
	public String getPagina() {
		return pagina;
	}

	public void setPagina(String pagina) {
		this.pagina = pagina;
	}

	public int getAccion() {
		return this.accion;
	}

	public void setAccion(int accion) {
		this.accion=accion;
	}

	public String getBitacora() {
		return bitacora;
	}

	public void setBitacora(String bitacora) {
		this.bitacora = bitacora;
	}

}
