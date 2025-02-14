package com.tmmas.scl.framework.ProductDomain.dto;

import java.io.Serializable;

import com.tmmas.scl.framework.aplicationDomain.dto.MensajeRetornoDTO;

public class UsoArticuloDTO implements Serializable{
	
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private long cod_uso;
	private String des_uso;
	private MensajeRetornoDTO mensajeRetorno;

	public MensajeRetornoDTO getMensajeRetorno() {
		return mensajeRetorno;
	}
	public void setMensajeRetorno(MensajeRetornoDTO mensajeRetorno) {
		this.mensajeRetorno = mensajeRetorno;
	}
	
	public long getCod_uso() {
		return cod_uso;
	}
	public void setCod_uso(long cod_uso) {
		this.cod_uso = cod_uso;
	}
	public String getDes_uso() {
		return des_uso;
	}
	public void setDes_uso(String des_uso) {
		this.des_uso = des_uso;
	}

}
