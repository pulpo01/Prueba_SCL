package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;




public class FechaReporteConsumoDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	private String fecha;  
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}
	public String getFecha() {
		return fecha;
	}
	public void setFecha(String fecha) {
		this.fecha = fecha;
	}
	
}
