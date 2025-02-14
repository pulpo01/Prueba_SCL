package com.tmmas.scl.operations.crm.common.dataTransferObject;

import java.io.Serializable;

public class DatosInWSListaPLanesDTO extends DatosObtProductosContratadosDTO implements Serializable  {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String codCliente;
	private String numAbonado;
	private String codCanal;
	private String numCelularBeneficiario;
	public String getCodCanal() {
		return codCanal;
	}
	public void setCodCanal(String codCanal) {
		this.codCanal = codCanal;
	}
	public String getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(String codCliente) {
		this.codCliente = codCliente;
	}
	public String getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(String numAbonado) {
		this.numAbonado = numAbonado;
	}
	public String getNumCelularBeneficiario() {
		return numCelularBeneficiario;
	}
	public void setNumCelularBeneficiario(String numCelularBeneficiario) {
		this.numCelularBeneficiario = numCelularBeneficiario;
	}
	
}
