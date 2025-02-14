package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;

public class ServicioSupleRespondeDTO implements Serializable{
	private static final long serialVersionUID = 1L;
	private ServicioSuplementarioDTO [] listaServiciosDefectoalPlan;  
	private ServicioSuplementarioDTO [] listaServiciosContratados;  
	private RespuestaDTO respuesta;
	
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}
	public RespuestaDTO getRespuesta() {
		return respuesta;
	}
	public void setRespuesta(RespuestaDTO respuesta) {
		this.respuesta = respuesta;
	}
	public ServicioSuplementarioDTO[] getListaServiciosContratados() {
		return listaServiciosContratados;
	}
	public void setListaServiciosContratados(
			ServicioSuplementarioDTO[] listaServiciosContratados) {
		this.listaServiciosContratados = listaServiciosContratados;
	}
	public ServicioSuplementarioDTO[] getListaServiciosDefectoalPlan() {
		return listaServiciosDefectoalPlan;
	}
	public void setListaServiciosDefectoalPlan(
			ServicioSuplementarioDTO[] listaServiciosDefectoalPlan) {
		this.listaServiciosDefectoalPlan = listaServiciosDefectoalPlan;
	}
	
	

	
}
