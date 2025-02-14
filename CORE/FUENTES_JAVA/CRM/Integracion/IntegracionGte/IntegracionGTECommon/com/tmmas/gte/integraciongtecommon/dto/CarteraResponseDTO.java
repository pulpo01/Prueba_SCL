package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;
/*
 * Autor: Alejandro Lorca
 */

public class CarteraResponseDTO  implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private CarteraDTO carteraCliente;
	private RespuestaDTO respuesta;
	
	public CarteraDTO getCarteraCliente() {
		return carteraCliente;
	}
	public void setCarteraCliente(CarteraDTO carteraCliente) {
		this.carteraCliente = carteraCliente;
	}
	public RespuestaDTO getRespuesta() {
		return respuesta;
	}
	public void setRespuesta(RespuestaDTO respuesta) {
		this.respuesta = respuesta;
	}
	
	
}