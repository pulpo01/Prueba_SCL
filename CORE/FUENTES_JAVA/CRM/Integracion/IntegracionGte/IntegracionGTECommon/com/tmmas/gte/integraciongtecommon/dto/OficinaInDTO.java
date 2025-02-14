package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;

public class OficinaInDTO  implements Serializable {
	/*
	 * Autor: Juan Daniel Muñoz Queupul
	 * */
	
	private static final long serialVersionUID = 1L;
	private String pRefPlaza;
	private long numComPago;

    public static long getSerialVersionUID() {
		return serialVersionUID;
	}
	public long getNumComPago() {
		return numComPago;
	}

	public void setNumComPago(long numComPago) {
		this.numComPago = numComPago;
	}

	public String getPRefPlaza() {
		return pRefPlaza;
	}

	public void setPRefPlaza(String refPlaza) {
		pRefPlaza = refPlaza;
	}
	
}