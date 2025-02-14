package com.tmmas.scl.operations.crm.fab.cim.manreq.web.form;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoBeneficiarioDTO;

public class ManAboBeneForm extends ActionForm{
	
	private AbonadoBeneficiarioDTO[] abonadosDTO;
	private AbonadoBeneficiarioDTO[] abonadosListadosDTO;
	private String numCelularAbo;
	private boolean checkTodos;
	private boolean condicionesCK;
	private String condicH;
	private String[]listaNumAbonados;
	private String[]listaEncolar;
	private String[]listaEncolarNumCelular;
	private String[]listaEncolarNombre;
	private String[]listaEncolarTipoComportamiento;
	private String[]listaEncolarFecInicioVigencia;
	private String[]listaEncolarFecTerminoVigencia;
	private String btnSiguiente;
	
	public String getBtnSiguiente() {
		return btnSiguiente;
	}

	public void setBtnSiguiente(String btnSiguiente) {
		this.btnSiguiente = btnSiguiente;
	}

	public String[] getListaEncolarNombre() {
		return listaEncolarNombre;
	}

	public void setListaEncolarNombre(String[] listaEncolarNombre) {
		this.listaEncolarNombre = listaEncolarNombre;
	}

	public String[] getListaEncolarNumCelular() {
		return listaEncolarNumCelular;
	}

	public void setListaEncolarNumCelular(String[] listaEncolarNumCelular) {
		this.listaEncolarNumCelular = listaEncolarNumCelular;
	}

	public String[] getListaNumAbonados() {
		return listaNumAbonados;
	}

	public void setListaNumAbonados(String[] listaNumAbonados) {
		this.listaNumAbonados = listaNumAbonados;
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

	public AbonadoBeneficiarioDTO[] getAbonadosDTO() {
		return abonadosDTO;
	}

	public void setAbonadosDTO(AbonadoBeneficiarioDTO[] abonadosDTO) {
		this.abonadosDTO = abonadosDTO;
	}

	public String[] getListaEncolar() {
		return listaEncolar;
	}

	public void setListaEncolar(String[] listaEncolar) {
		this.listaEncolar = listaEncolar;
	}

	public String[] getListaEncolarFecInicioVigencia() {
		return listaEncolarFecInicioVigencia;
	}

	public void setListaEncolarFecInicioVigencia(
			String[] listaEncolarFecInicioVigencia) {
		this.listaEncolarFecInicioVigencia = listaEncolarFecInicioVigencia;
	}

	public String[] getListaEncolarFecTerminoVigencia() {
		return listaEncolarFecTerminoVigencia;
	}

	public void setListaEncolarFecTerminoVigencia(
			String[] listaEncolarFecTerminoVigencia) {
		this.listaEncolarFecTerminoVigencia = listaEncolarFecTerminoVigencia;
	}

	public String[] getListaEncolarTipoComportamiento() {
		return listaEncolarTipoComportamiento;
	}

	public void setListaEncolarTipoComportamiento(
			String[] listaEncolarTipoComportamiento) {
		this.listaEncolarTipoComportamiento = listaEncolarTipoComportamiento;
	}
	
	public void reset(ActionMapping mapping, HttpServletRequest request){
		condicionesCK=false;
	}

	public AbonadoBeneficiarioDTO[] getAbonadosListadosDTO() {
		return abonadosListadosDTO;
	}

	public void setAbonadosListadosDTO(AbonadoBeneficiarioDTO[] abonadosListadosDTO) {
		this.abonadosListadosDTO = abonadosListadosDTO;
	}

	
}