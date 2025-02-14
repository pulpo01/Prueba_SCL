package com.tmmas.cl.scl.portalventas.web.form;

import org.apache.struts.action.ActionForm;

import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.OficinaComDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.DatosGeneralesDTO;

public class GestionScoringForm extends ActionForm {
	private static final long serialVersionUID = 1L;
	
	private String numSolScoring;
	private String numSolScoringSel;	
	private String codOficina;
	private OficinaComDTO[] arrayOficina;	
	private String codVendedor;
	private String codVendedorSeleccionado;
	private String fechaDesde;
	private String fechaHasta;
	private String codCliente;
	private String codTipoCliente;
	private String glsTipoCliente;
	private String codEstadoSol;
	private DatosGeneralesDTO[] arrayEstadosSol;
	
	private String numLineaSel;
	
	public String getNumLineaSel() {
		return numLineaSel;
	}

	public void setNumLineaSel(String numLineaSel) {
		this.numLineaSel = numLineaSel;
	}

	public DatosGeneralesDTO[] getArrayEstadosSol() {
		return arrayEstadosSol;
	}

	public void setArrayEstadosSol(DatosGeneralesDTO[] arrayEstadosSol) {
		this.arrayEstadosSol = arrayEstadosSol;
	}

	public OficinaComDTO[] getArrayOficina() {
		return arrayOficina;
	}

	public void setArrayOficina(OficinaComDTO[] arrayOficina) {
		this.arrayOficina = arrayOficina;
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

	public String getCodTipoCliente() {
		return codTipoCliente;
	}

	public void setCodTipoCliente(String codTipoCliente) {
		this.codTipoCliente = codTipoCliente;
	}

	public String getCodVendedor() {
		return codVendedor;
	}

	public void setCodVendedor(String codVendedor) {
		this.codVendedor = codVendedor;
	}

	public String getCodVendedorSeleccionado() {
		return codVendedorSeleccionado;
	}

	public void setCodVendedorSeleccionado(String codVendedorSeleccionado) {
		this.codVendedorSeleccionado = codVendedorSeleccionado;
	}

	public String getFechaDesde() {
		return fechaDesde;
	}

	public void setFechaDesde(String fechaDesde) {
		this.fechaDesde = fechaDesde;
	}

	public String getFechaHasta() {
		return fechaHasta;
	}

	public void setFechaHasta(String fechaHasta) {
		this.fechaHasta = fechaHasta;
	}

	public String getGlsTipoCliente() {
		return glsTipoCliente;
	}

	public void setGlsTipoCliente(String glsTipoCliente) {
		this.glsTipoCliente = glsTipoCliente;
	}
	
	public String getCodEstadoSol() {
		return codEstadoSol;
	}

	public void setCodEstadoSol(String codEstadoSol) {
		this.codEstadoSol = codEstadoSol;
	}

	public String getNumSolScoringSel() {
		return numSolScoringSel;
	}

	public void setNumSolScoringSel(String numSolScoringSel) {
		this.numSolScoringSel = numSolScoringSel;
	}

	public void setNumSolScoring(String numSolScoring) {
		this.numSolScoring = numSolScoring;
	}

	public String getNumSolScoring() {
		return numSolScoring;
	}
	
	private String codFormularioOrigen;
	
	private String codFormularioGestionScoring;
	
	private String codFormularioReportesScoring;
	
	private String titulo;
	
	public String getTitulo() {
		return titulo;
	}

	public void setTitulo(String titulo) {
		this.titulo = titulo;
	}

	public String getCodFormularioGestionScoring() {
		return codFormularioGestionScoring;
	}

	public void setCodFormularioGestionScoring(String codFormularioGestionScoring) {
		this.codFormularioGestionScoring = codFormularioGestionScoring;
	}

	public String getCodFormularioReportesScoring() {
		return codFormularioReportesScoring;
	}

	public void setCodFormularioReportesScoring(String codFormularioReportesScoring) {
		this.codFormularioReportesScoring = codFormularioReportesScoring;
	}

	public String getCodFormularioOrigen() {
		return codFormularioOrigen;
	}

	public void setCodFormularioOrigen(String codFormularioOrigen) {
		this.codFormularioOrigen = codFormularioOrigen;
	}
}
