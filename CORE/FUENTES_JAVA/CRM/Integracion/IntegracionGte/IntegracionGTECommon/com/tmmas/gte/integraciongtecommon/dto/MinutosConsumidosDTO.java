package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;
/*
 * Autor: Daniel Jara
 */
import java.util.Date;

public class MinutosConsumidosDTO  implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private double consumoTelefono;
	private Date ultLlamada;
	private Date corteCiclo;
	private RespuestaDTO respuesta;
	
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}
	public double getConsumoTelefono() {
		return consumoTelefono;
	}
	public void setConsumoTelefono(double consumoTelefono) {
		this.consumoTelefono = consumoTelefono;
	}
	public Date getCorteCiclo() {
		return corteCiclo;
	}
	public void setCorteCiclo(Date corteCiclo) {
		this.corteCiclo = corteCiclo;
	}
	public Date getUltLlamada() {
		return ultLlamada;
	}
	public void setUltLlamada(Date ultLlamada) {
		this.ultLlamada = ultLlamada;
	}
	public RespuestaDTO getRespuesta() {
		return respuesta;
	}
	public void setRespuesta(RespuestaDTO respuesta) {
		this.respuesta = respuesta;
	}
	
	
	

}