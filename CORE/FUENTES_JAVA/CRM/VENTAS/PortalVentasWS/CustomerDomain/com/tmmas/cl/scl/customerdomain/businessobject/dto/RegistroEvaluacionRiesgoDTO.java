package com.tmmas.cl.scl.customerdomain.businessobject.dto;

import java.io.Serializable;

public class RegistroEvaluacionRiesgoDTO implements Serializable{

	private static final long serialVersionUID = 1L;
	private int existeEvaluacionRiesgoValida;
	private int cantidadTerminalesVendidos;
	private int cantidadTerminales;
	private ClienteDTO cliente;
	private long numeroSolicitud;
	private int codigoEstado;
	private String codigoPlanTarifario;
	private double limiteCredito;
	private String tipoSolicitud;
	private String indicadorEvento;
	private String estadosVigentes;
	private float montoGarantia;
	
	/*-- Registro Evaluacion de Riesgo --*/
	private String numIdentificacion;
	private String nombreCliente;
	private String descripcionNombre;
	private String primerApellido;
	private String segundoApellido;
	private String codigoTipoIdentificacion;
	
	/*-- Excepcion --*/
	private int codigoRestriccion;
	
	/*-- Relacion Solicitud/Venta --*/
	private String numeroVenta;

	public String getNumeroVenta() {
		return numeroVenta;
	}
	public void setNumeroVenta(String numeroVenta) {
		this.numeroVenta = numeroVenta;
	}
	public int getCodigoRestriccion() {
		return codigoRestriccion;
	}
	public void setCodigoRestriccion(int codigoRestriccion) {
		this.codigoRestriccion = codigoRestriccion;
	}
	public String getCodigoTipoIdentificacion() {
		return codigoTipoIdentificacion;
	}
	public void setCodigoTipoIdentificacion(String codigoTipoIdentificacion) {
		this.codigoTipoIdentificacion = codigoTipoIdentificacion;
	}
	public String getDescripcionNombre() {
		return descripcionNombre;
	}
	public void setDescripcionNombre(String descripcionNombre) {
		this.descripcionNombre = descripcionNombre;
	}
	public String getNombreCliente() {
		return nombreCliente;
	}
	public void setNombreCliente(String nombreCliente) {
		this.nombreCliente = nombreCliente;
	}
	public String getNumIdentificacion() {
		return numIdentificacion;
	}
	public void setNumIdentificacion(String numIdentificacion) {
		this.numIdentificacion = numIdentificacion;
	}
	public String getPrimerApellido() {
		return primerApellido;
	}
	public void setPrimerApellido(String primerApellido) {
		this.primerApellido = primerApellido;
	}
	public String getSegundoApellido() {
		return segundoApellido;
	}
	public void setSegundoApellido(String segundoApellido) {
		this.segundoApellido = segundoApellido;
	}
	public float getMontoGarantia() {
		return montoGarantia;
	}
	public void setMontoGarantia(float montoGarantia) {
		this.montoGarantia = montoGarantia;
	}
	public String getEstadosVigentes() {
		return estadosVigentes;
	}
	public void setEstadosVigentes(String estadosVigentes) {
		this.estadosVigentes = estadosVigentes;
	}
	public String getIndicadorEvento() {
		return indicadorEvento;
	}
	public void setIndicadorEvento(String indicadorEvento) {
		this.indicadorEvento = indicadorEvento;
	}
	public String getTipoSolicitud() {
		return tipoSolicitud;
	}
	public void setTipoSolicitud(String tipoSolicitud) {
		this.tipoSolicitud = tipoSolicitud;
	}
	public String getCodigoPlanTarifario() {
		return codigoPlanTarifario;
	}
	public void setCodigoPlanTarifario(String codigoPlanTarifario) {
		this.codigoPlanTarifario = codigoPlanTarifario;
	}
	public ClienteDTO getCliente() {
		return cliente;
	}
	public void setCliente(ClienteDTO cliente) {
		this.cliente = cliente;
	}
	public int getExisteEvaluacionRiesgoValida() {
		return existeEvaluacionRiesgoValida;
	}
	public void setExisteEvaluacionRiesgoValida(int existeEvaluacionRiesgoValida) {
		this.existeEvaluacionRiesgoValida = existeEvaluacionRiesgoValida;
	}
	public int getCantidadTerminales() {
		return cantidadTerminales;
	}
	public void setCantidadTerminales(int cantidadTerminales) {
		this.cantidadTerminales = cantidadTerminales;
	}
	public int getCantidadTerminalesVendidos() {
		return cantidadTerminalesVendidos;
	}
	public void setCantidadTerminalesVendidos(int cantidadTerminalesVendidos) {
		this.cantidadTerminalesVendidos = cantidadTerminalesVendidos;
	}
	public int getCodigoEstado() {
		return codigoEstado;
	}
	public void setCodigoEstado(int codigoEstado) {
		this.codigoEstado = codigoEstado;
	}
	
	public long getNumeroSolicitud() {
		return numeroSolicitud;
	}
	public void setNumeroSolicitud(long numeroSolicitud) {
		this.numeroSolicitud = numeroSolicitud;
	}
	public double getLimiteCredito() {
		return limiteCredito;
	}
	public void setLimiteCredito(double limiteCredito) {
		this.limiteCredito = limiteCredito;
	}
	

}
