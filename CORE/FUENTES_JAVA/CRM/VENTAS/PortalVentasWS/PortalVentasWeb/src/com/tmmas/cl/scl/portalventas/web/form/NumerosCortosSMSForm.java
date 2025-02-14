package com.tmmas.cl.scl.portalventas.web.form;

import org.apache.struts.action.ActionForm;

import com.tmmas.cl.scl.commonbusinessentities.dto.FormularioNumerosSMSDTO;

public class NumerosCortosSMSForm extends ActionForm {

	private static final long serialVersionUID = 1L;
	
	private String numCortoPos = "0";
	private String largoNumero;
	private String maximoNumeros;
	private String numeroCortoValor;

	private FormularioNumerosSMSDTO[] arrayNumeros;

	public FormularioNumerosSMSDTO[] getArrayNumeros() {
		return arrayNumeros;
	}

	public void setArrayNumeros(FormularioNumerosSMSDTO[] arrayNumeros) {
		this.arrayNumeros = arrayNumeros;
	}

	public String getLargoNumero() {
		return largoNumero;
	}

	public void setLargoNumero(String largoNumero) {
		this.largoNumero = largoNumero;
	}

	public String getMaximoNumeros() {
		return maximoNumeros;
	}

	public void setMaximoNumeros(String maximoNumeros) {
		this.maximoNumeros = maximoNumeros;
	}

	public String getNumCortoPos() {
		return numCortoPos;
	}

	public void setNumCortoPos(String numCortoPos) {
		this.numCortoPos = numCortoPos;
	}

	public String getNumeroCortoValor() {
		return numeroCortoValor;
	}

	public void setNumeroCortoValor(String numeroCortoValor) {
		this.numeroCortoValor = numeroCortoValor;
	}
	
}