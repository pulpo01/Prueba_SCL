package com.tmmas.scl.operations.crm.fab.cim.manreq.web.form;

import org.apache.struts.action.ActionForm;

import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoVetadoDTO;



public class ManAboVetaForm extends ActionForm{
	
	private AbonadoVetadoDTO[] abonadosVetadosDTO;
	private String numCelularAbo;
	private boolean checkTodos;
	private boolean condicionesCK;
	private String condicH;
	private String[]listaNumAbonadosVetados;
	private String[]listaNumAbonadosNoVetados;
	private String[]listaNumAbonadosCheck;

	private String btnSiguiente;
	
	

	public String getBtnSiguiente() {
		return btnSiguiente;
	}

	public void setBtnSiguiente(String btnSiguiente) {
		this.btnSiguiente = btnSiguiente;
	}

	
	public String getCondicH() {
		return condicH;
	}

	public void setCondicH(String condicH) {
		this.condicH = condicH;
	}

	public boolean isCondicionesCK() {
		return condicionesCK;
	}

	public void setCondicionesCK(boolean condicionesCK) {
		this.condicionesCK = condicionesCK;
	}

	public boolean isCheckTodos() {
		return checkTodos;
	}

	public void setCheckTodos(boolean checkTodos) {
		this.checkTodos = checkTodos;
	}

	public String getNumCelularAbo() {
		return numCelularAbo;
	}

	public void setNumCelularAbo(String numCelularAbo) {
		this.numCelularAbo = numCelularAbo;
	}

	public String[] getListaNumAbonadosNoVetados() {
		return listaNumAbonadosNoVetados;
	}

	public void setListaNumAbonadosNoVetados(String[] listaNumAbonadosNoVetados) {
		this.listaNumAbonadosNoVetados = listaNumAbonadosNoVetados;
	}

	public String[] getListaNumAbonadosVetados() {
		return listaNumAbonadosVetados;
	}

	public void setListaNumAbonadosVetados(String[] listaNumAbonadosVetados) {
		this.listaNumAbonadosVetados = listaNumAbonadosVetados;
	}

	public String[] getListaNumAbonadosCheck() {
		return listaNumAbonadosCheck;
	}

	public void setListaNumAbonadosCheck(String[] listaNumAbonadosCheck) {
		this.listaNumAbonadosCheck = listaNumAbonadosCheck;
	}

	public AbonadoVetadoDTO[] getAbonadosVetadosDTO() {
		return abonadosVetadosDTO;
	}

	public void setAbonadosVetadosDTO(AbonadoVetadoDTO[] abonadosVetadosDTO) {
		this.abonadosVetadosDTO = abonadosVetadosDTO;
	}

	

	


	
}