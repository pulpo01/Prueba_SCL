package com.tmmas.scl.operations.crm.fab.cim.manreq.web.form;

import org.apache.struts.action.ActionForm;

public class ResumenForm extends ActionForm{

	private String comentario;
	private String btnSeleccionado;
	private String abonadoSel;
	private String cargaPagina;

	public String getCargaPagina() {
		return cargaPagina;
	}

	public void setCargaPagina(String cargaPagina) {
		this.cargaPagina = cargaPagina;
	}

	public String getComentario() {
		return comentario;
	}

	public void setComentario(String comentario) {
		this.comentario = comentario;
	}

	public String getBtnSeleccionado() {
		return btnSeleccionado;
	}

	public void setBtnSeleccionado(String btnSeleccionado) {
		this.btnSeleccionado = btnSeleccionado;
	}

	public String getAbonadoSel() {
		return abonadoSel;
	}

	public void setAbonadoSel(String abonadoSel) {
		this.abonadoSel = abonadoSel;
	}

	
}
