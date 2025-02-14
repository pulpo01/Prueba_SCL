package com.tmmas.scl.operations.crm.f.sel.negsal.dataTransferObject;

import java.io.Serializable;

public class DatosInBeneficioDTO implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String numAbonadoContratado;
	private String numAbonadoBeneficiario;
	private String canalOrigenPro;
	
	public String getCanalOrigenPro() {
		return canalOrigenPro;
	}
	public void setCanalOrigenPro(String canalOrigenPro) {
		this.canalOrigenPro = canalOrigenPro;
	}
	public String getNumAbonadoBeneficiario() {
		return numAbonadoBeneficiario;
	}
	public void setNumAbonadoBeneficiario(String numAbonadoBeneficiario) {
		this.numAbonadoBeneficiario = numAbonadoBeneficiario;
	}
	public String getNumAbonadoContratado() {
		return numAbonadoContratado;
	}
	public void setNumAbonadoContratado(String numAbonadoContratado) {
		this.numAbonadoContratado = numAbonadoContratado;
	}
}
