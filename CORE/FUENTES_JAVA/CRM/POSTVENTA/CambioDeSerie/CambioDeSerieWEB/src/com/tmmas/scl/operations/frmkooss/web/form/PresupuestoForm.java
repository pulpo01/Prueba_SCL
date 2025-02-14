package com.tmmas.scl.operations.frmkooss.web.form;

import org.apache.struts.action.ActionForm;

public class PresupuestoForm extends ActionForm{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String accion;
	private long numProceso;
	private boolean flgIniciado;
	private Float montoAbono;
	private String rbCiclo;

	public Float getMontoAbono() {
		return montoAbono;
	}

	public void setMontoAbono(Float montoAbono) {
		this.montoAbono = montoAbono;
	}

	public String getRbCiclo() {
		return rbCiclo;
	}

	public void setRbCiclo(String rbCiclo) {
		this.rbCiclo = rbCiclo;
	}

	public boolean isFlgIniciado() {
		return flgIniciado;
	}

	public void setFlgIniciado(boolean flgIniciado) {
		this.flgIniciado = flgIniciado;
	}

	public long getNumProceso() {
		return numProceso;
	}

	public void setNumProceso(long numProceso) {
		this.numProceso = numProceso;
	}

	public String getAccion() {
		return accion;
	}

	public void setAccion(String accion) {
		this.accion = accion;
	}

}
