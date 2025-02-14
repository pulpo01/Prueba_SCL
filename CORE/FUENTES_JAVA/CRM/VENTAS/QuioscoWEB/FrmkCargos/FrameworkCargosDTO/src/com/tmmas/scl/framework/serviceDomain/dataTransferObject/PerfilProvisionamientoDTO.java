/**
 * Copyright © 2006 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 25-06-2007     			 Cristian Toledo              		Versión Inicial
 */
package com.tmmas.scl.framework.serviceDomain.dataTransferObject;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.Date;

public class PerfilProvisionamientoDTO implements Serializable 
{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String nroCelular; 
	private String idAbonado;  
	private String idCliente;  
	private String codTecnologia; 
	private String idEspecificacionProvisionamiento; 
	private String codProvServ; 
	private String tipAccion; 
	private String codProdContratado; 
	private Date fechaEjecucion; 
	private String tipTerminal; 
	private String codCentral;  
	private String numSerie;    
	private String idPlan;		
	private String importe;		
	private String codMoneda;	
	private String usuario;
	private String codCausa;
	private String montoBonificacion;
	private String tipoBono;
	private String codPeriodificacion; // Ciclo facturacion
	private Date fechaEjecucionBono;
	private String tipoServicio;
	private String numMovimientoAnterior;

	
	public Object[] toStruct_IC_PROVISION_QT()
	{
		Object[] obj={	idCliente,
						codProvServ,
						tipAccion,
						tipoServicio,
						codProdContratado,
						fechaEjecucion!=null?new Timestamp(fechaEjecucion.getTime()):null,
						nroCelular,
						idAbonado,
						tipTerminal,
						codCentral,
						numSerie,
						codTecnologia,
						idPlan,
						importe,
						codMoneda,
						usuario,
						codCausa,
						montoBonificacion,
						tipoBono,
						codPeriodificacion,
						fechaEjecucionBono!=null?new Timestamp(fechaEjecucionBono.getTime()):null,
						numMovimientoAnterior
		};
		
		return obj;
	}
	
	public PerfilProvisionamientoDTO()
	{
		this.fechaEjecucion=new Date();
		this.fechaEjecucionBono=this.fechaEjecucion;
	}
	
	public String getCodCausa() {
		return codCausa;
	}
	public void setCodCausa(String codCausa) {
		this.codCausa = codCausa;
	}
	public String getCodCentral() {
		return codCentral;
	}
	public void setCodCentral(String codCentral) {
		this.codCentral = codCentral;
	}
	public String getCodMoneda() {
		return codMoneda;
	}
	public void setCodMoneda(String codMoneda) {
		this.codMoneda = codMoneda;
	}
	public String getCodPeriodificacion() {
		return codPeriodificacion;
	}
	public void setCodPeriodificacion(String codPeriodificacion) {
		this.codPeriodificacion = codPeriodificacion;
	}
	public String getCodProdContratado() {
		return codProdContratado;
	}
	public void setCodProdContratado(String codProdContratado) {
		this.codProdContratado = codProdContratado;
	}
	public String getCodProvServ() {
		return codProvServ;
	}
	public void setCodProvServ(String codProvServ) {
		this.codProvServ = codProvServ;
	}
	public Date getFechaEjecucion() {
		return fechaEjecucion;
	}
	public void setFechaEjecucion(Date fechaEjecucion) 
	{
		this.fechaEjecucion = fechaEjecucion;
		this.fechaEjecucionBono=fechaEjecucion;
	}
	public String getIdPlan() {
		return idPlan;
	}
	public void setIdPlan(String idPlan) {
		this.idPlan = idPlan;
	}
	public String getImporte() {
		return importe;
	}
	public void setImporte(String importe) {
		this.importe = importe;
	}
	public String getMontoBonificacion() {
		return montoBonificacion;
	}
	public void setMontoBonificacion(String montoBonificacion) {
		this.montoBonificacion = montoBonificacion;
	}
	public String getNumSerie() {
		return numSerie;
	}
	public void setNumSerie(String numSerie) {
		this.numSerie = numSerie;
	}
	public String getTipAccion() {
		return tipAccion;
	}
	public void setTipAccion(String tipAccion) {
		this.tipAccion = tipAccion;
	}
	public String getTipoBono() {
		return tipoBono;
	}
	public void setTipoBono(String tipoBono) {
		this.tipoBono = tipoBono;
	}
	public String getTipTerminal() {
		return tipTerminal;
	}
	public void setTipTerminal(String tipTerminal) {
		this.tipTerminal = tipTerminal;
	}
	public String getUsuario() {
		return usuario;
	}
	public void setUsuario(String usuario) {
		this.usuario = usuario;
	}
	public String getCodTecnologia() {
		return codTecnologia;
	}
	public void setCodTecnologia(String codTecnologia) {
		this.codTecnologia = codTecnologia;
	}
	public String getIdAbonado() {
		return idAbonado;
	}
	public void setIdAbonado(String idAbonado) {
		this.idAbonado = idAbonado;
	}
	public String getIdCliente() {
		return idCliente;
	}
	public void setIdCliente(String idCliente) {
		this.idCliente = idCliente;
	}
	public String getIdEspecificacionProvisionamiento() {
		return idEspecificacionProvisionamiento;
	}
	public void setIdEspecificacionProvisionamiento(
			String idEspecificacionProvisionamiento) {
		this.idEspecificacionProvisionamiento = idEspecificacionProvisionamiento;
	}
	public String getNroCelular() {
		return nroCelular;
	}
	public void setNroCelular(String nroCelular) {
		this.nroCelular = nroCelular;
	}


	public Date getFechaEjecucionBono() {
		return fechaEjecucionBono;
	}


	public void setFechaEjecucionBono(Date fechaEjecucionBono) {
		this.fechaEjecucionBono = fechaEjecucionBono;
	}


	public String getTipoServicio() {
		return tipoServicio;
	}


	public void setTipoServicio(String tipoServicio) {
		this.tipoServicio = tipoServicio;
	}

	public String getNumMovimientoAnterior() {
		return numMovimientoAnterior;
	}

	public void setNumMovimientoAnterior(String numMovimientoAnterior) {
		this.numMovimientoAnterior = numMovimientoAnterior;
	}
	
}
