/**
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 17/05/2007	     	Elizabeth Vera        				Versión Inicial
 */
package com.tmmas.scl.framework.productDomain.dataTransferObject;

import java.io.Serializable;

public class EliminaPromocionDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	private String tipoCambioPlan;
	private long numAbonado;
	private boolean flgAplica;

	private String svCombinatoria;
	private String svMensaje; 

	public long getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(long numAbonado) {
		this.numAbonado = numAbonado;
	}
	public boolean isFlgAplica() {
		return flgAplica;
	}
	public void setFlgAplica(boolean flgAplica) {
		this.flgAplica = flgAplica;
	}
	public String getTipoCambioPlan() {
		return tipoCambioPlan;
	}
	public void setTipoCambioPlan(String tipoCambioPlan) {
		this.tipoCambioPlan = tipoCambioPlan;
	}
	public String getSvCombinatoria() {
		return svCombinatoria;
	}
	public void setSvCombinatoria(String svCombinatoria) {
		this.svCombinatoria = svCombinatoria;
	}
	public String getSvMensaje() {
		return svMensaje;
	}
	public void setSvMensaje(String svMensaje) {
		this.svMensaje = svMensaje;
	}
}
