package com.tmmas.scl.operations.crm.fab.cim.manreq.web.form;

import org.apache.struts.action.ActionForm;

public class PresupuestoForm extends ActionForm{
	private String accion;
	private long numProceso;
	private boolean flgIniciado;

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
