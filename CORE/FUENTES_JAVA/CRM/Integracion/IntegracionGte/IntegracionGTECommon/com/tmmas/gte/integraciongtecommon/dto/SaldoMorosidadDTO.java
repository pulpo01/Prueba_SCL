package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;
/*
 * Autor: Alejandro Lorca
 */


public class SaldoMorosidadDTO  implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private double saldoVenc;
	private double saldoNoVenc;
	private RespuestaDTO respuesta;
	public RespuestaDTO getRespuesta() {
		return respuesta;
	}
	public void setRespuesta(RespuestaDTO respuesta) {
		this.respuesta = respuesta;
	}
	public double getSaldoNoVenc() {
		return saldoNoVenc;
	}
	public void setSaldoNoVenc(double saldoNoVenc) {
		this.saldoNoVenc = saldoNoVenc;
	}
	public double getSaldoVenc() {
		return saldoVenc;
	}
	public void setSaldoVenc(double saldoVenc) {
		this.saldoVenc = saldoVenc;
	}

	
	
}