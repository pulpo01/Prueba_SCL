package com.tmmas.scl.operations.crm.fab.cusintman.web.form;

import org.apache.struts.action.ActionForm;

public class DevolucionDeEquipoForm extends ActionForm {
	private static final long serialVersionUID = 1L;
	
	private String opDevuelveEquipo;
	private String opAmistar;
	private String opEstadoEquipo;
	private String opCargador;
	private String bodegaDestino;
	private String condicH;
	private String condicionesCK;

	public String getCondicionesCK() {
		return condicionesCK;
	}
	public void setCondicionesCK(String condicionesCK) {
		this.condicionesCK = condicionesCK;
	}
	public String getCondicH() {
		return condicH;
	}
	public void setCondicH(String condicH) {
		setCondicionesCK(condicH.equals("SI")?"on":null);
		this.condicH = condicH;
	}
	
	public String getBodegaDestino() {
		return bodegaDestino;
	}
	public void setBodegaDestino(String bodegaDestino) {
		this.bodegaDestino = bodegaDestino;
	}
	public String getOpAmistar() {
		return opAmistar;
	}
	public void setOpAmistar(String opAmistar) {
		this.opAmistar = opAmistar;
	}
	public String getOpCargador() {
		return opCargador;
	}
	public void setOpCargador(String opCargador) {
		this.opCargador = opCargador;
	}
	public String getOpDevuelveEquipo() {
		return opDevuelveEquipo;
	}
	public void setOpDevuelveEquipo(String opDevuelveEquipo) {
		this.opDevuelveEquipo = opDevuelveEquipo;
	}
	public String getOpEstadoEquipo() {
		return opEstadoEquipo;
	}
	public void setOpEstadoEquipo(String opEstadoEquipo) {
		this.opEstadoEquipo = opEstadoEquipo;
	}
	
}	// DevolucionDeEquipoForm
