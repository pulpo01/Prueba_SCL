package com.tmmas.scl.framework.ProductDomain.dto;

import java.io.Serializable;

import com.tmmas.scl.framework.aplicationDomain.dto.MensajeRetornoDTO;

public class TipoTerminalDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String tip_terminal;
	private String  des_terminal;
	private MensajeRetornoDTO mensajeRetorno;

	public MensajeRetornoDTO getMensajeRetorno() {
		return mensajeRetorno;
	}
	public void setMensajeRetorno(MensajeRetornoDTO mensajeRetorno) {
		this.mensajeRetorno = mensajeRetorno;
	}
	
	public String getDes_terminal() {
		return des_terminal;
	}
	public void setDes_terminal(String des_terminal) {
		this.des_terminal = des_terminal;
	}
	public String getTip_terminal() {
		return tip_terminal;
	}
	public void setTip_terminal(String tip_terminal) {
		this.tip_terminal = tip_terminal;
	}
	
	
	  
}
