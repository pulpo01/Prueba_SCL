package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;

public class DireccionInDTO  implements Serializable {
	/*
	 * Autor: Juan Daniel Muñoz Queupul
	 * */
	
	private static final long serialVersionUID = 1L;
//	private String codSujeto;       /*cod_cliente*/
//    private long tipSujeto;      /*tip_direccion*/
	private long codDireccion;
    private String codTipDireccion;     /*cod_direccion*/
//    private long tipDisplay;       /**/
    
    
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}

	public long getCodDireccion() {
		return codDireccion;
	}

	public void setCodDireccion(long codDireccion) {
		this.codDireccion = codDireccion;
	}

	public String getCodTipDireccion() {
		return codTipDireccion;
	}

	public void setCodTipDireccion(String codTipDireccion) {
		this.codTipDireccion = codTipDireccion;
	}

}