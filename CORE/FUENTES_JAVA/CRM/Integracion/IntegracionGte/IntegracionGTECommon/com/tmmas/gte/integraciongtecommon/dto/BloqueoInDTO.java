package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;

public class BloqueoInDTO  implements Serializable {
	/*
	 * Autor: Juan Daniel Muñoz Queupul
	 * */
	
	private static final long serialVersionUID = 1L;
	private long codAbonado;          /*codigo del abonado*/
    
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}

	public long getCodAbonado() {
		return codAbonado;
	}

	public void setCodAbonado(long codAbonado) {
		this.codAbonado = codAbonado;
	}

}