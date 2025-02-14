package com.tmmas.cl.scl.portalventas.web.form;

import java.util.List;

import org.apache.struts.action.ActionForm;

public class BuscaNumeroForm extends ActionForm {
	private static final long serialVersionUID = 1L;
	
	private String codCriterioBusqueda;
	private String busquedaRangoInf;
	private String busquedaRangoSup;
	private String rdTipoBusqueda;
	private String tipoBusqueda;
	private String numeroSel;
	private String rangoInfSel;
	private String rangoSupSel;
	private String largoPrefijo;
	private String largoNumCelular;
	private String numeroAnteriorRes;
	private String tablaNumeracionAut;
	private String categoria;
	private String fechaBaja;
	private String instancia;
	private String indNumeroPiloto="";
	private String rangosAsociadosSeleccionados[]; //Lista que se grabara asociada al numero piloto
	private String rangosDisponiblesSeleccionados[];
	private String nombreCliente;
	private List rangosAsociados;
	private List rangosDisponibles;
	private List rangosDisponiblesInicio;
	private String moduloOrigen;
	private String indNumeroCortoSMS="";
	
	public String getIndNumeroCortoSMS() {
		return indNumeroCortoSMS;
	}
	public void setIndNumeroCortoSMS(String indNumeroCortoSMS) {
		this.indNumeroCortoSMS = indNumeroCortoSMS;
	}
	public String getModuloOrigen() {
		return moduloOrigen;
	}
	public void setModuloOrigen(String moduloOrigen) {
		this.moduloOrigen = moduloOrigen;
	}
	public List getRangosDisponiblesInicio() {
		return rangosDisponiblesInicio;
	}
	public void setRangosDisponiblesInicio(List rangosDisponiblesInicio) {
		this.rangosDisponiblesInicio = rangosDisponiblesInicio;
	}
	public String getNombreCliente() {
		return nombreCliente;
	}
	public void setNombreCliente(String nombreCliente) {
		this.nombreCliente = nombreCliente;
	}
	public String getIndNumeroPiloto() {
		return indNumeroPiloto;
	}
	public void setIndNumeroPiloto(String indNumeroPiloto) {
		this.indNumeroPiloto = indNumeroPiloto;
	}
	public String getCategoria() {
		return categoria;
	}
	public void setCategoria(String categoria) {
		this.categoria = categoria;
	}
	public String getTablaNumeracionAut() {
		return tablaNumeracionAut;
	}
	public void setTablaNumeracionAut(String tablaNumeracionAut) {
		this.tablaNumeracionAut = tablaNumeracionAut;
	}
	public String getLargoNumCelular() {
		return largoNumCelular;
	}
	public void setLargoNumCelular(String largoNumCelular) {
		this.largoNumCelular = largoNumCelular;
	}
	public String getLargoPrefijo() {
		return largoPrefijo;
	}
	public void setLargoPrefijo(String largoPrefijo) {
		this.largoPrefijo = largoPrefijo;
	}
	public String getRangoInfSel() {
		return rangoInfSel;
	}
	public void setRangoInfSel(String rangoInfSel) {
		this.rangoInfSel = rangoInfSel;
	}
	public String getRangoSupSel() {
		return rangoSupSel;
	}
	public void setRangoSupSel(String rangoSupSel) {
		this.rangoSupSel = rangoSupSel;
	}
	public String getNumeroSel() {
		return numeroSel;
	}
	public void setNumeroSel(String numeroSel) {
		this.numeroSel = numeroSel;
	}
	public String getCodCriterioBusqueda() {
		return codCriterioBusqueda;
	}
	public void setCodCriterioBusqueda(String codCriterioBusqueda) {
		this.codCriterioBusqueda = codCriterioBusqueda;
	}
	public String getBusquedaRangoInf() {
		return busquedaRangoInf;
	}
	public void setBusquedaRangoInf(String busquedaRangoInf) {
		this.busquedaRangoInf = busquedaRangoInf;
	}
	public String getBusquedaRangoSup() {
		return busquedaRangoSup;
	}
	public void setBusquedaRangoSup(String busquedaRangoSup) {
		this.busquedaRangoSup = busquedaRangoSup;
	}
	public String getTipoBusqueda() {
		return tipoBusqueda;
	}
	public void setTipoBusqueda(String tipoBusqueda) {
		this.tipoBusqueda = tipoBusqueda;
	}
	public String getRdTipoBusqueda() {
		return rdTipoBusqueda;
	}
	public void setRdTipoBusqueda(String rdTipoBusqueda) {
		this.rdTipoBusqueda = rdTipoBusqueda;
	}
	public String getNumeroAnteriorRes() {
		return numeroAnteriorRes;
	}
	public void setNumeroAnteriorRes(String numeroAnteriorRes) {
		this.numeroAnteriorRes = numeroAnteriorRes;
	}
	public String getFechaBaja() {
		return fechaBaja;
	}
	public void setFechaBaja(String fechaBaja) {
		this.fechaBaja = fechaBaja;
	}
	public String getInstancia() {
		return instancia;
	}
	public void setInstancia(String instancia) {
		this.instancia = instancia;
	}
	public List getRangosAsociados() {
		return rangosAsociados;
	}
	public void setRangosAsociados(List rangosAsociados) {
		this.rangosAsociados = rangosAsociados;
	}
	public String[] getRangosAsociadosSeleccionados() {
		return rangosAsociadosSeleccionados;
	}
	public void setRangosAsociadosSeleccionados(
			String[] rangosAsociadosSeleccionados) {
		this.rangosAsociadosSeleccionados = rangosAsociadosSeleccionados;
	}
	public List getRangosDisponibles() {
		return rangosDisponibles;
	}
	public void setRangosDisponibles(List rangosDisponibles) {
		this.rangosDisponibles = rangosDisponibles;
	}
	public String[] getRangosDisponiblesSeleccionados() {
		return rangosDisponiblesSeleccionados;
	}
	public void setRangosDisponiblesSeleccionados(
			String[] rangosDisponiblesSeleccionados) {
		this.rangosDisponiblesSeleccionados = rangosDisponiblesSeleccionados;
	}

	private String mensajeError;

	public final String getMensajeError() {
		return mensajeError;
	}
	public final void setMensajeError(String mensajeError) {
		this.mensajeError = mensajeError;
	}
	
	

	
	
}
