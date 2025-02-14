package com.tmmas.cl.scl.pv.customerorder.web.form;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

public class WizardForm extends ActionForm {
	private static final long serialVersionUID = 1L;
	private String accion;
	private String minutosporasignar[];
	private int[] unidadesA;
	private int[] unidadesB;
	
	private String name;
	private String lastName;
	
	public String getLastName() {
		return lastName;
	}
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}

    
	public void reset(ActionMapping mapping, HttpServletRequest request) {
		System.out.println("Ejecutando Reset...");
		accion = "mostrar"; 
		minutosporasignar=null;
	}

	public ActionErrors validate(ActionMapping mapping, HttpServletRequest request) {
		System.out.println("Ejecutando Validate...");
		return null;
	}

	public String getAccion() {
		return accion;
	}

	public void setAccion(String accion) {
		this.accion = accion;
	}

	public String[] getMinutosporasignar() {
		return minutosporasignar;
	}

	public void setMinutosporasignar(String[] minutosporasignar) {
		this.minutosporasignar = minutosporasignar;
	}

	public int[] getUnidadesA() {
		return unidadesA;
	}

	public void setUnidadesA(int[] unidadesA) {
		this.unidadesA = unidadesA;
	}

	public int[] getUnidadesB() {
		return unidadesB;
	}

	public void setUnidadesB(int[] unidadesB) {
		this.unidadesB = unidadesB;
	}
	
}
