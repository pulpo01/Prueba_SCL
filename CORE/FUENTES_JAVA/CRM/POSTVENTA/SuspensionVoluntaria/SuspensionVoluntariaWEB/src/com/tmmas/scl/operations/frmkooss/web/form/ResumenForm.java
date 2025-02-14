package com.tmmas.scl.operations.frmkooss.web.form;

import org.apache.struts.action.ActionForm;

public class ResumenForm extends ActionForm{

	private String comentario;
	private String btnSeleccionado;

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

	
}
