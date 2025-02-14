package com.tmmas.scl.serviciospostventasiga.transport;

import java.io.Serializable;

public class ValorPlanDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;	
	
	private String codPlanTarif;
	private String codCiclo;
	private String codCliente;
	private String numAbonado;
	private String catImpClie;
	private String codOficina;
	
	public String getCatImpClie() {
		return catImpClie;
	}
	public void setCatImpClie(String catImpClie) {
		this.catImpClie = catImpClie;
	}
	public String getCodCiclo() {
		return codCiclo;
	}
	public void setCodCiclo(String codCiclo) {
		this.codCiclo = codCiclo;
	}
	public String getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(String codCliente) {
		this.codCliente = codCliente;
	}
	public String getCodOficina() {
		return codOficina;
	}
	public void setCodOficina(String codOficina) {
		this.codOficina = codOficina;
	}
	public String getCodPlanTarif() {
		return codPlanTarif;
	}
	public void setCodPlanTarif(String codPlanTarif) {
		this.codPlanTarif = codPlanTarif;
	}
	public String getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(String numAbonado) {
		this.numAbonado = numAbonado;
	}

	
}
