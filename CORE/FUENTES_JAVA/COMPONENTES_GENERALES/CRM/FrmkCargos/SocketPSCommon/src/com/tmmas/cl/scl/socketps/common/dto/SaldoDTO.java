package com.tmmas.cl.scl.socketps.common.dto;

import java.io.Serializable;

public class SaldoDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private String saldo;
	private RespuestaPSDTO respuesta;
	
	public RespuestaPSDTO getRespuesta() {
		return respuesta;
	}
	public void setRespuesta(RespuestaPSDTO respuesta) {
		this.respuesta = respuesta;
	}
	public String getSaldo() {
		return saldo;
	}
	public void setSaldo(String saldo) {
		this.saldo = saldo;
	}

}
