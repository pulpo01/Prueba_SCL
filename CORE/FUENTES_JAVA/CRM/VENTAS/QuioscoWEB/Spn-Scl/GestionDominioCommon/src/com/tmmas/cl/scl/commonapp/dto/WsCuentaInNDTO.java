package com.tmmas.cl.scl.commonapp.dto;

import java.io.Serializable;
import java.util.Date;

public class WsCuentaInNDTO implements Serializable{

	private static final long serialVersionUID = 1L;
		
	private WsClienteInDTO   ClienteDTO;	 	 
	private String   CodigoCuenta;  
	private String   nomUsuarioOra;
	 		
	public WsClienteInDTO getClienteDTO() {
		return ClienteDTO;
	}
	public void setClienteDTO(WsClienteInDTO clienteDTO) {
		ClienteDTO = clienteDTO;
	}
	public String getCodigoCuenta() {
		return CodigoCuenta;
	}
	public void setCodigoCuenta(String codigoCuenta) {
		CodigoCuenta = codigoCuenta;
	}
	public String getNomUsuarioOra() {
		return nomUsuarioOra;
	}
	public void setNomUsuarioOra(String nomUsuarioOra) {
		this.nomUsuarioOra = nomUsuarioOra;
	}


	 
	 


}
