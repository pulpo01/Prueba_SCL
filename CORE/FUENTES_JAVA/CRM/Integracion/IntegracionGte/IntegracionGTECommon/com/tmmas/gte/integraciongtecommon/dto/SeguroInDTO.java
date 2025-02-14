package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;

public class SeguroInDTO  implements Serializable {
	/*
	 * Autor: Juan Daniel Muñoz Queupul
	 * */
	
	private static final long serialVersionUID = 1L;
	private long numeroAbonado;
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}
	public long getNumeroAbonado() {
		return numeroAbonado;
	}
	public void setNumeroAbonado(long numeroAbonado) {
		this.numeroAbonado = numeroAbonado;
	}             
    
    
}