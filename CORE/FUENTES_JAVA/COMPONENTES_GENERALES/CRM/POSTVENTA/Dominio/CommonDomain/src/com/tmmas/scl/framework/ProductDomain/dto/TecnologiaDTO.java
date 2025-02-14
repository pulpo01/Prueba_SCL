package com.tmmas.scl.framework.ProductDomain.dto;

import java.io.Serializable;

import com.tmmas.scl.framework.aplicationDomain.dto.MensajeRetornoDTO;

public class TecnologiaDTO implements Serializable{

	
	
	 /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String cod_tecnologia;
	private String des_tecnologia;
	private MensajeRetornoDTO mensajeRetorno;

	public MensajeRetornoDTO getMensajeRetorno() {
		return mensajeRetorno;
	}
	public void setMensajeRetorno(MensajeRetornoDTO mensajeRetorno) {
		this.mensajeRetorno = mensajeRetorno;
	} 
	 
	public String getCod_tecnologia() {
		return cod_tecnologia;
	}
	public void setCod_tecnologia(String cod_tecnologia) {
		this.cod_tecnologia = cod_tecnologia;
	}
	public String getDes_tecnologia() {
		return des_tecnologia;
	}
	public void setDes_tecnologia(String des_tecnologia) {
		this.des_tecnologia = des_tecnologia;
	}
}
