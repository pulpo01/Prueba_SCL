package com.tmmas.scl.operations.crm.fab.cim.manreq.web.form;

import org.apache.struts.action.ActionForm;

public class BusquedaAbonadosForm extends ActionForm {

	private long codCliente;
	private String numAbonado;
	private String numCelular;
	private String rutAbonado;
	private String tipoPlanTarif;
	private int numMaxAbonados;
	private int numMaxLineas;
	private int numMaxPaginas;
	private String flgAbonadosDistTipoPlan;
	private String radioTipoPlan;
	private String prestacionCB;
	
	public String getRadioTipoPlan() {
		return radioTipoPlan;
	}
	public void setRadioTipoPlan(String radioTipoPlan) {
		this.radioTipoPlan = radioTipoPlan;
	}
	public String getFlgAbonadosDistTipoPlan() {
		return flgAbonadosDistTipoPlan;
	}
	public void setFlgAbonadosDistTipoPlan(String flgAbonadosDistTipoPlan) {
		this.flgAbonadosDistTipoPlan = flgAbonadosDistTipoPlan;
	}
	public int getNumMaxAbonados() {
		return numMaxAbonados;
	}
	public void setNumMaxAbonados(int numMaxAbonados) {
		this.numMaxAbonados = numMaxAbonados;
	}
	public int getNumMaxLineas() {
		return numMaxLineas;
	}
	public void setNumMaxLineas(int numMaxLineas) {
		this.numMaxLineas = numMaxLineas;
	}
	public int getNumMaxPaginas() {
		return numMaxPaginas;
	}
	public void setNumMaxPaginas(int numMaxPaginas) {
		this.numMaxPaginas = numMaxPaginas;
	}
	public String getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(String numAbonado) {
		this.numAbonado = numAbonado;
	}
	public String getNumCelular() {
		return numCelular;
	}
	public void setNumCelular(String numCelular) {
		this.numCelular = numCelular;
	}
	public String getRutAbonado() {
		return rutAbonado;
	}
	public void setRutAbonado(String rutAbonado) {
		this.rutAbonado = rutAbonado;
	}
	public String getTipoPlanTarif() {
		return tipoPlanTarif;
	}
	public void setTipoPlanTarif(String tipoPlanTarif) {
		this.tipoPlanTarif = tipoPlanTarif;
	}
	public long getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(long codCliente) {
		this.codCliente = codCliente;
	}
	public String getPrestacionCB() {
		return prestacionCB;
	}
	public void setPrestacionCB(String prestacionCB) {
		this.prestacionCB = prestacionCB;
	}

	

	
}
