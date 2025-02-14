package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;
/*
 * Autor: Daniel Jara
 */
import java.util.Date;

public class MinutosLdiResponseDTO  implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private Date fechaInicioCiclo;
	private double cantidadMinutos;
	private int saldoParteEntera;
	private double saldoParteDecimal;
	private String fechaUltimaLlamada;
	private RespuestaDTO respuesta;
	

	public RespuestaDTO getRespuesta() {
		return respuesta;
	}
	public void setRespuesta(RespuestaDTO respuesta) {
		this.respuesta = respuesta;
	}
	public double getCantidadMinutos() {
		return cantidadMinutos;
	}
	public void setCantidadMinutos(double cantidadMinutos) {
		this.cantidadMinutos = cantidadMinutos;
	}
	public Date getFechaInicioCiclo() {
		return fechaInicioCiclo;
	}
	public void setFechaInicioCiclo(Date fechaInicioCiclo) {
		this.fechaInicioCiclo = fechaInicioCiclo;
	}
	public String getFechaUltimaLlamada() {
		return fechaUltimaLlamada;
	}
	public void setFechaUltimaLlamada(String fechaUltimaLlamada) {
		this.fechaUltimaLlamada = fechaUltimaLlamada;
	}
	public double getSaldoParteDecimal() {
		return saldoParteDecimal;
	}
	public void setSaldoParteDecimal(double saldoParteDecimal) {
		this.saldoParteDecimal = saldoParteDecimal;
	}
	public int getSaldoParteEntera() {
		return saldoParteEntera;
	}
	public void setSaldoParteEntera(int saldoParteEntera) {
		this.saldoParteEntera = saldoParteEntera;
	}


}