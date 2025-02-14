/**
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 04/06/2007	     	Elizabeth Vera        				Versión Inicial
 */
package com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject;

import java.io.Serializable;

public class BolsaDinamicaDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	private long idSecuencia;
	private long codCliente;
	private int codCiclo;
	private String codPlanTarif;
	private String codPlanTarifDestino;
	private String codCargoBasico;
	private float impCargo;
	private float impMaximo;
	
	public float getImpCargo() {
		return impCargo;
	}
	public void setImpCargo(float impCargo) {
		this.impCargo = impCargo;
	}
	public float getImpMaximo() {
		return impMaximo;
	}
	public void setImpMaximo(float impMaximo) {
		this.impMaximo = impMaximo;
	}
	public String getCodCargoBasico() {
		return codCargoBasico;
	}
	public void setCodCargoBasico(String codCargoBasico) {
		this.codCargoBasico = codCargoBasico;
	}
	public int getCodCiclo() {
		return codCiclo;
	}
	public void setCodCiclo(int codCiclo) {
		this.codCiclo = codCiclo;
	}
	public long getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(long codCliente) {
		this.codCliente = codCliente;
	}
	public String getCodPlanTarif() {
		return codPlanTarif;
	}
	public void setCodPlanTarif(String codPlanTarif) {
		this.codPlanTarif = codPlanTarif;
	}
	public String getCodPlanTarifDestino() {
		return codPlanTarifDestino;
	}
	public void setCodPlanTarifDestino(String codPlanTarifDestino) {
		this.codPlanTarifDestino = codPlanTarifDestino;
	}
	public long getIdSecuencia() {
		return idSecuencia;
	}
	public void setIdSecuencia(long idSecuencia) {
		this.idSecuencia = idSecuencia;
	}
}
