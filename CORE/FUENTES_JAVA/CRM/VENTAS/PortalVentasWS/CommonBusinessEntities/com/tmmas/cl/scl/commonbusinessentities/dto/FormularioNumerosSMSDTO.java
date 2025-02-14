package com.tmmas.cl.scl.commonbusinessentities.dto;

import java.io.Serializable;

public class FormularioNumerosSMSDTO implements Serializable
{
	private static final long serialVersionUID = -146735027062601810L;

	private String numCortoPos;
	private long numeroCortoValor;
	private long numAbonado;
	private String nomUsuarora;

	public String getNumCortoPos() {
		return numCortoPos;
	}

	public void setNumCortoPos(String numCortoPos) {
		this.numCortoPos = numCortoPos;
	}


	public String getNomUsuarora() {
		return nomUsuarora;
	}

	public void setNomUsuarora(String nomUsuarora) {
		this.nomUsuarora = nomUsuarora;
	}

	public long getNumAbonado() {
		return numAbonado;
	}

	public void setNumAbonado(long numAbonado) {
		this.numAbonado = numAbonado;
	}

	public long getNumeroCortoValor() {
		return numeroCortoValor;
	}

	public void setNumeroCortoValor(long numeroCortoValor) {
		this.numeroCortoValor = numeroCortoValor;
	}		

}