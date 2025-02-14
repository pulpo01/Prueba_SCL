package com.tmmas.cl.scl.pv.customerorder.web.form;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;



public class CommentariesForm extends ActionForm {

	private static final long serialVersionUID = 1L;
	private String accionCommentaries;
	private String comentarios;
	
	public void reset(ActionMapping mapping, HttpServletRequest request) {

		accionCommentaries = "mostrar";
		comentarios = "";
	}

	public ActionErrors validate(ActionMapping mapping, HttpServletRequest request) {
		return super.validate(mapping, request);
	}

	public String getComentarios() {
		return comentarios;
	}

	public void setComentarios(String comentarios) {
		this.comentarios = comentarios;
	}

	public String getAccionCommentaries() {
		return accionCommentaries;
	}

	public void setAccionCommentaries(String accionCommentaries) {
		this.accionCommentaries = accionCommentaries;
	}
}
