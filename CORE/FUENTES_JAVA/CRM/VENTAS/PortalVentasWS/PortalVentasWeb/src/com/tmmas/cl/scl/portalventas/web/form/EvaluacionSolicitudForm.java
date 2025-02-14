package com.tmmas.cl.scl.portalventas.web.form;

import org.apache.struts.action.ActionForm;

import com.tmmas.cl.scl.commonbusinessentities.dto.DetalleLineaSolicitudDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.EstadoSolicitudDTO;

public class EvaluacionSolicitudForm extends ActionForm {
	private static final long serialVersionUID = 1L;

	private String desEstadoActual;

	private String codEstadoNuevo;

	private String desEstadoNuevo;

	private EstadoSolicitudDTO[] arrayEstadosSol;

	private String desTipoIdentificacion;

	private String numIdentificacion;

	private String nombreCompleto;

	private String montoPreautorizado;

	private String calificacion;

	private String clasificacion;

	private String color;

	private String segmento;

	private String nombreEmpresa;

	private String desModalidadVenta;

	private String desTipoContrato;

	private String flagPermiteCambioEstado = "0";

	private String flagClienteEmpresa = "0";
	
	private long numVenta;

	private DetalleLineaSolicitudDTO[] arrayLineasSol;

	public String getFlagPermiteCambioEstado() {
		return flagPermiteCambioEstado;
	}

	public void setFlagPermiteCambioEstado(String flagPermiteCambioEstado) {
		this.flagPermiteCambioEstado = flagPermiteCambioEstado;
	}

	public EstadoSolicitudDTO[] getArrayEstadosSol() {
		return arrayEstadosSol;
	}

	public void setArrayEstadosSol(EstadoSolicitudDTO[] arrayEstadosSol) {
		this.arrayEstadosSol = arrayEstadosSol;
	}

	public String getCodEstadoNuevo() {
		return codEstadoNuevo;
	}

	public void setCodEstadoNuevo(String codEstadoNuevo) {
		this.codEstadoNuevo = codEstadoNuevo;
	}

	public String getFlagClienteEmpresa() {
		return flagClienteEmpresa;
	}

	public void setFlagClienteEmpresa(String flagClienteEmpresa) {
		this.flagClienteEmpresa = flagClienteEmpresa;
	}

	public String getCalificacion() {
		return calificacion;
	}

	public void setCalificacion(String calificacion) {
		this.calificacion = calificacion;
	}

	public String getColor() {
		return color;
	}

	public void setColor(String color) {
		this.color = color;
	}

	public String getDesTipoIdentificacion() {
		return desTipoIdentificacion;
	}

	public void setDesTipoIdentificacion(String desTipoIdentificacion) {
		this.desTipoIdentificacion = desTipoIdentificacion;
	}

	public String getMontoPreautorizado() {
		return montoPreautorizado;
	}

	public void setMontoPreautorizado(String montoPreautorizado) {
		this.montoPreautorizado = montoPreautorizado;
	}

	public String getNombreCompleto() {
		return nombreCompleto;
	}

	public void setNombreCompleto(String nombreCompleto) {
		this.nombreCompleto = nombreCompleto;
	}

	public String getNombreEmpresa() {
		return nombreEmpresa;
	}

	public void setNombreEmpresa(String nombreEmpresa) {
		this.nombreEmpresa = nombreEmpresa;
	}

	public String getNumIdentificacion() {
		return numIdentificacion;
	}

	public void setNumIdentificacion(String numIdentificacion) {
		this.numIdentificacion = numIdentificacion;
	}

	public String getSegmento() {
		return segmento;
	}

	public void setSegmento(String segmento) {
		this.segmento = segmento;
	}

	public String getDesModalidadVenta() {
		return desModalidadVenta;
	}

	public void setDesModalidadVenta(String desModalidadVenta) {
		this.desModalidadVenta = desModalidadVenta;
	}

	public String getDesTipoContrato() {
		return desTipoContrato;
	}

	public void setDesTipoContrato(String desTipoContrato) {
		this.desTipoContrato = desTipoContrato;
	}

	public String getClasificacion() {
		return clasificacion;
	}

	public void setClasificacion(String clasificacion) {
		this.clasificacion = clasificacion;
	}

	public String getDesEstadoActual() {
		return desEstadoActual;
	}

	public void setDesEstadoActual(String desEstadoActual) {
		this.desEstadoActual = desEstadoActual;
	}

	public String getDesEstadoNuevo() {
		return desEstadoNuevo;
	}

	public void setDesEstadoNuevo(String desEstadoNuevo) {
		this.desEstadoNuevo = desEstadoNuevo;
	}

	public DetalleLineaSolicitudDTO[] getArrayLineasSol() {
		return arrayLineasSol;
	}

	public void setArrayLineasSol(DetalleLineaSolicitudDTO[] arrayLineasSol) {
		this.arrayLineasSol = arrayLineasSol;
	}

	public long getNumVenta() {
		return numVenta;
	}

	public void setNumVenta(long numVenta) {
		this.numVenta = numVenta;
	}
}
