package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;

public class BancoInDTO  implements Serializable {
	/*
	 * Autor: Juan Daniel Muñoz Queupul
	 * */
	private static final long serialVersionUID = 1L;
	private String codBanco;   

	public String getCodBanco() {
		return codBanco;
	}
	public void setCodBanco(String codBanco) {
		this.codBanco = codBanco;
	}

	
}