package com.tmmas.scl.operations.crm.fab.cusintman.web.form;

import org.apache.struts.action.ActionForm;

public class AnulacionSiniestroForm extends ActionForm {
	private static final long serialVersionUID = 1L;
	
	private String idSeleccion;
	
	private String nroTerminal;
	private String tipTerminal;
	private String numSiniestro;
	private String desEstado;
	private String codCausa;
	private String desCausa;
	private String nroConstancia;
	private String fecSiniestro;
	private String fecFormalizacion;
	private String fecAnulacion;
	private String fecRestitucion;
	
	private String btnSeleccionado;
	
	private String condicionError;
	private String mensajeError;
	private String mensajeStackTrace;

	private String condicH;
	private String condicionesCK;
	
	private String vaListaNegra;
	//Incluido santiago ventura 23-03-2010	
	private String numConstaPolAnula;	
	
	public String getVaListaNegra() {
		return vaListaNegra;
	}
	public void setVaListaNegra(String vaListaNegra) {
		this.vaListaNegra = vaListaNegra;
	}
	public String getCodCausa() {
		return codCausa;
	}
	public void setCodCausa(String codCausa) {
		this.codCausa = codCausa;
	}
	public String getBtnSeleccionado() {
		return btnSeleccionado;
	}
	public void setBtnSeleccionado(String btnSeleccionado) {
		this.btnSeleccionado = btnSeleccionado;
	}
	public String getIdSeleccion() {
		return idSeleccion;
	}
	public void setIdSeleccion(String idSeleccion) {
		this.idSeleccion = idSeleccion;
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
	public String getDesCausa() {
		return desCausa;
	}
	public void setDesCausa(String desCausa) {
		this.desCausa = desCausa;
	}
	public String getDesEstado() {
		return desEstado;
	}
	public void setDesEstado(String desEstado) {
		this.desEstado = desEstado;
	}
	public String getFecAnulacion() {
		return fecAnulacion;
	}
	public void setFecAnulacion(String fecAnulacion) {
		this.fecAnulacion = fecAnulacion;
	}
	public String getFecFormalizacion() {
		return fecFormalizacion;
	}
	public void setFecFormalizacion(String fecFormalizacion) {
		this.fecFormalizacion = fecFormalizacion;
	}
	public String getFecRestitucion() {
		return fecRestitucion;
	}
	public void setFecRestitucion(String fecRestitucion) {
		this.fecRestitucion = fecRestitucion;
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
	public String getNroConstancia() {
		return nroConstancia;
	}
	public void setNroConstancia(String nroConstancia) {
		this.nroConstancia = nroConstancia;
	}
	public String getNroTerminal() {
		return nroTerminal;
	}
	public void setNroTerminal(String nroTerminal) {
		this.nroTerminal = nroTerminal;
	}
	public String getNumSiniestro() {
		return numSiniestro;
	}
	public void setNumSiniestro(String numSiniestro) {
		this.numSiniestro = numSiniestro;
	}

	public String getTipTerminal() {
		return tipTerminal;
	}
	public void setTipTerminal(String tipTerminal) {
		this.tipTerminal = tipTerminal;
	}
	public String getNumConstaPolAnula() {
		return numConstaPolAnula;
	}
	public void setNumConstaPolAnula(String numConstaPolAnula) {
		this.numConstaPolAnula = numConstaPolAnula;
	}

} // AnulacionSiniestroForm
