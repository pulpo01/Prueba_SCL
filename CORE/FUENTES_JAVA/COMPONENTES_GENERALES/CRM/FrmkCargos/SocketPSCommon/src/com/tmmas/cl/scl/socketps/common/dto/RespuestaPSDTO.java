package com.tmmas.cl.scl.socketps.common.dto;

import java.io.Serializable;

public class RespuestaPSDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	//Identificador unico devuelto por el sistema, es como un secuencial.
	//Tendra valor numerico cuando la transaccion sea aceptada
	//Tendra valor nulo cuando la transaccion sea rechazada. Ejemplo TICKET= 
	private String ticket = "";

	//Identificador del sistema del cliente
	private String os = "";
	
	//Estado que indica si la transacción fue aceptada o rechazada
	//OK = ACEPTADA
	//NAK = rechazada
	private String status = "";
	
	//Id y descripcion para aquellas transacciones NAK
	private String subError = "";
	
	public String getOs() {
		return os;
	}
	public void setOs(String os) {
		this.os = os;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getSubError() {
		return subError;
	}
	public void setSubError(String subError) {
		this.subError = subError;
	}
	public String getTicket() {
		return ticket;
	}
	public void setTicket(String ticket) {
		this.ticket = ticket;
	}
	
	

}
