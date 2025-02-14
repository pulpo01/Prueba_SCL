package com.tmmas.scl.operations.crm.fab.cusintman.web.form;

import org.apache.struts.action.ActionForm;

public class ServiciosSuplementariosForm extends ActionForm {
	private static final long serialVersionUID = 1L;
	
	private String btnSeleccionado;
	private String codSearch;
	private String condicionError;
	private String mensajeError;
	private String mensajeStackTrace;
	
	private String condicH;
	private String condicionesCK;
	
	private String nocontratadosTabla;
	private String contratadosTabla;
	private String adelantadosTabla; // aqui se agregan los codigos de grupo y nivel para cada SS a contratar.
	
	// Contactos del SS de asistencia movil
	private String contactosTabla;

	// Si se contrata fax, se debe actualizar el numero
	private String grabarFax;

	private String textoNoContratados;	
	private String textoContratados;
	
	public String getGrabarFax() {
		return grabarFax;
	}
	public void setGrabarFax(String grabarFax) {
		this.grabarFax = grabarFax;
	}
	public String getTextoContratados() {
		return textoContratados;
	}
	public void setTextoContratados(String textoContratados) {
		this.textoContratados = textoContratados;
	}
	public String getTextoNoContratados() {
		return textoNoContratados;
	}
	public void setTextoNoContratados(String textoNoContratados) {
		this.textoNoContratados = textoNoContratados;
	}
	public String getContratadosTabla() {
		return contratadosTabla;
	}
	public void setContratadosTabla(String contratadosTabla) {
		this.contratadosTabla = contratadosTabla;
	}
	public String getContactosTabla() {
		return contactosTabla;
	}
	public void setContactosTabla(String contactosTabla) {
		this.contactosTabla = contactosTabla;
	}
	
	public String getNocontratadosTabla() {
		return nocontratadosTabla;
	}
	public void setNocontratadosTabla(String nocontratadosTabla) {
		this.nocontratadosTabla = nocontratadosTabla;
	}
	
	public String getCodSearch() {
		return codSearch;
	}
	public void setCodSearch(String codSearch) {
		this.codSearch = codSearch;
	}
	public String getBtnSeleccionado() {
		return btnSeleccionado;
	}
	public void setBtnSeleccionado(String btnSeleccionado) {
		this.btnSeleccionado = btnSeleccionado;
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
	public String getAdelantadosTabla() {
		return adelantadosTabla;
	}
	public void setAdelantadosTabla(String adelantadosTabla) {
		this.adelantadosTabla = adelantadosTabla;
	}

} // ServiciosSuplementariosForm
