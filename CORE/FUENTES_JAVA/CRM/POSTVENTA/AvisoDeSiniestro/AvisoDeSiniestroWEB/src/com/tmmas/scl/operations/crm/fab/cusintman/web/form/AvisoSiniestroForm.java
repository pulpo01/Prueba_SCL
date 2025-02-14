package com.tmmas.scl.operations.crm.fab.cusintman.web.form;

import org.apache.struts.action.ActionForm;

public class AvisoSiniestroForm extends ActionForm {
	private static final long serialVersionUID = 1L;
	
	private long nroTerminal;
	private long nroAbonado;	
	private String tecnologia;
	private String tipoSiniestro;
	private String tipoSuspencion;
	private String fecSiniestro;
	private String causaSiniestro;
	private String observaciones;
	private String btnSeleccionado;
	private String condicionError;
	private String mensajeError;
	private String mensajeStackTrace;

	private String condicH;
	private String condicionesCK;
	
	//Inicio Inc. 174755/CSR-11002/06-09-2011/FDL
	private Long numeroDesviado;
	//Fin Inc. 174755/CSR-11002/06-09-2011/FDL
	
	public String getBtnSeleccionado() {
		return btnSeleccionado;
	}
	public void setBtnSeleccionado(String btnSeleccionado) {
		this.btnSeleccionado = btnSeleccionado;
	}
	public String getCausaSiniestro() {
		return causaSiniestro;
	}
	public void setCausaSiniestro(String causaSiniestro) {
		this.causaSiniestro = causaSiniestro;
	}
	
	public String getCondicH() {
		return condicH;
	}
	public void setCondicH(String condicH) {
		setCondicionesCK(condicH.equals("SI")?"on":null);
		this.condicH = condicH;
	}
	public String getCondicionError() {
		return condicionError;
	}
	public void setCondicionError(String condicionError) {
		this.condicionError = condicionError;
	}
	public String getCondicionesCK() {
		return condicionesCK;
	}
	public void setCondicionesCK(String condicionesCK) {
		this.condicionesCK = condicionesCK;
	}
	public String getFecSiniestro() {
		return fecSiniestro;
	}
	public void setFecSiniestro(String fecSiniestro) {
		this.fecSiniestro = fecSiniestro;
	}
	public String getMensajeError() {
		return mensajeError;
	}
	public void setMensajeError(String mensajeError) {
		this.mensajeError = mensajeError;
	}
	public String getMensajeStackTrace() {
		return mensajeStackTrace;
	}
	public void setMensajeStackTrace(String mensajeStackTrace) {
		this.mensajeStackTrace = mensajeStackTrace;
	}
	public long getNroAbonado() {
		return nroAbonado;
	}
	public void setNroAbonado(long nroAbonado) {
		this.nroAbonado = nroAbonado;
	}
	public long getNroTerminal() {
		return nroTerminal;
	}
	public void setNroTerminal(long nroTerminal) {
		this.nroTerminal = nroTerminal;
	}
	public String getObservaciones() {
		return observaciones;
	}
	public void setObservaciones(String observaciones) {
		this.observaciones = observaciones;
	}
	public String getTecnologia() {
		return tecnologia;
	}
	public void setTecnologia(String tecnologia) {
		this.tecnologia = tecnologia;
	}
	public String getTipoSiniestro() {
		return tipoSiniestro;
	}
	public void setTipoSiniestro(String tipoSiniestro) {
		this.tipoSiniestro = tipoSiniestro;
	}
	public String getTipoSuspencion() {
		return tipoSuspencion;
	}
	public void setTipoSuspencion(String tipoSuspencion) {
		this.tipoSuspencion = tipoSuspencion;
	}
	
	//Inicio Inc. 174755/CSR-11002/06-09-2011/FDL
	public Long getNumeroDesviado() {
		return numeroDesviado;
	}
	public void setNumeroDesviado(Long numeroDesviado) {
		this.numeroDesviado = numeroDesviado;
	}
	//Fin Inc. 174755/CSR-11002/06-09-2011/FDL

} // AvisoSiniestroForm
