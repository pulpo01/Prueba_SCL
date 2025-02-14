package com.tmmas.scl.framework.customerDomain.dataTransferObject;

import java.io.Serializable;

public class ParametroProcesoDTO implements Serializable{
	private static final long serialVersionUID = 1L;

	private Serializable parametro;
	private int num_reintentos;
	private String glosa_proceso = "";
	private String error_tecnico = "";
	private int num_proceso_sgte;
	private String observacion;
	
	private int estado;
	private int numeroProceso;
	
	public String getError_tecnico() {
		return error_tecnico;
	}
	public void setError_tecnico(String error_tecnico) {
		this.error_tecnico = error_tecnico;
	}
	public int getEstado() {
		return estado;
	}
	public void setEstado(int estado) {
		this.estado = estado;
	}
	public String getGlosa_proceso() {
		return glosa_proceso;
	}
	public void setGlosa_proceso(String glosa_proceso) {
		this.glosa_proceso = glosa_proceso;
	}
	public int getNum_proceso_sgte() {
		return num_proceso_sgte;
	}
	public void setNum_proceso_sgte(int num_proceso_sgte) {
		this.num_proceso_sgte = num_proceso_sgte;
	}
	public int getNum_reintentos() {
		return num_reintentos;
	}
	public void setNum_reintentos(int num_reintentos) {
		this.num_reintentos = num_reintentos;
	}
	public int getNumeroProceso() {
		return numeroProceso;
	}
	public void setNumeroProceso(int numeroProceso) {
		this.numeroProceso = numeroProceso;
	}
	public Serializable getParametro() {
		return parametro;
	}
	public void setParametro(Serializable parametro) {
		this.parametro = parametro;
	}
	public String getObservacion() {
		return observacion;
	}
	public void setObservacion(String observacion) {
		this.observacion = observacion;
	}
}
