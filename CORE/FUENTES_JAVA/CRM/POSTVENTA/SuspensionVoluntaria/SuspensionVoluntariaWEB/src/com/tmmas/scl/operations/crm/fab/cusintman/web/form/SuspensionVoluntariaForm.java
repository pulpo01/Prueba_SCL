package com.tmmas.scl.operations.crm.fab.cusintman.web.form;

import java.util.Date;

import org.apache.struts.action.ActionForm;

public class SuspensionVoluntariaForm extends ActionForm {
	private static final long serialVersionUID = 1L;

	private long nroAbonado;
	private long nroTerminal;
	private String fecSolicitud;
	private String fecSuspension;
	private String indexFecSuspension;
	private String fecRehabilitacion;
	private long cantDias;
	private String causaSuspension;
	private String estadoSuspension;
	private int flagCrearPeriodo;
	private int indiceAnular; 
	private String opcionProceso;
	private String btnSeleccionado;
	private String condicionError;
	private String mensajeError;
	private String mensajeStackTrace;
	private String condicH;
	private String condicionesCK;
	
	public String getIndexFecSuspension() {
		return indexFecSuspension;
	}
	public void setIndexFecSuspension(String indexFecSuspension) {
		this.indexFecSuspension = indexFecSuspension;
	}
	public String getBtnSeleccionado() {
		return btnSeleccionado;
	}
	public void setBtnSeleccionado(String btnSeleccionado) {
		this.btnSeleccionado = btnSeleccionado;
	}
	public String getOpcionProceso() {
		return opcionProceso;
	}
	public void setOpcionProceso(String opcionProceso) {
		this.opcionProceso = opcionProceso;
	}
	public int getIndiceAnular() {
		return indiceAnular;
	}
	public void setIndiceAnular(int indiceAnular) {
		this.indiceAnular = indiceAnular;
	}
	public String getEstadoSuspension() {
		return estadoSuspension;
	}
	public void setEstadoSuspension(String estadoSuspension) {
		this.estadoSuspension = estadoSuspension;
	}

	public long getCantDias() {
		return cantDias;
	}
	public void setCantDias(long cantDias) {
		this.cantDias = cantDias;
	}
	public String getCausaSuspension() {
		return causaSuspension;
	}
	public void setCausaSuspension(String causaSuspension) {
		this.causaSuspension = causaSuspension;
	}
	public String getCondicH() {
		return condicH;
	}
	public void setCondicH(String condicH) {
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
	public String getFecRehabilitacion() {
		return fecRehabilitacion;
	}
	public void setFecRehabilitacion(String fecRehabilitacion) {
		this.fecRehabilitacion = fecRehabilitacion;
	}
	
	public String getFecSolicitud() {
		return this.fecSolicitud;		
	}

	public Date getFecSolicitudToDate(String fecha){
		return new Date(fecha);
	}
	
	/*
	public String getFecSolicitudToString() {
		return this.fecSolicitud;		
	}
	
	
	public String getFecSolicitud() {
		if (this.fecSolicitud != null)	{ 
			SimpleStringFormat formato = new SimpleStringFormat("dd/MM/yyyy");
			return formato.format(this.fecSolicitud); 
		} // if

		return "";				
	}

	public void setFecSolicitud(String fecSolicitud) {
		try	{
			this.fecSolicitud = fecSolicitud;
		}
		catch (Exception ex){
			System.out.println("problemas de fecha");
		}
	}

	*
	*
	*/
	
	public void setFecSolicitud(String fecSolicitud) {
		this.fecSolicitud = fecSolicitud;
	}
	
	public String getFecSuspension() {
		return fecSuspension;
	}
	public void setFecSuspension(String fecSuspension) {
		this.fecSuspension = fecSuspension;
	}
	public int getFlagCrearPeriodo() {
		return flagCrearPeriodo;
	}
	public void setFlagCrearPeriodo(int flagCrearPeriodo) {
		this.flagCrearPeriodo = flagCrearPeriodo;
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

} // SuspensionVoluntariaForm
