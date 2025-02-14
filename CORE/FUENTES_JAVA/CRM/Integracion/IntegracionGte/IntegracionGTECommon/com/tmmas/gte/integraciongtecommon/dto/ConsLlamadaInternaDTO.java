package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;


public class ConsLlamadaInternaDTO  implements Serializable {
	/*
	 * Autor: Juan Daniel Muñoz Queupul
	 * */
	
	private static final long serialVersionUID = 1L;
	private long cicloFacturacion;   
	private String  fecDesde; /*YYYYMMDD*/   
	private String  fecHasta; /*YYYYMMDD*/
	private RespuestaDTO respuesta;
	
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}
	public long getCicloFacturacion() {
		return cicloFacturacion;
	}
	public void setCicloFacturacion(long cicloFacturacion) {
		this.cicloFacturacion = cicloFacturacion;
	}
	public RespuestaDTO getRespuesta() {
		return respuesta;
	}
	public void setRespuesta(RespuestaDTO respuesta) {
		this.respuesta = respuesta;
	}
	public String getFecDesde() {
		return fecDesde;
	}
	public void setFecDesde(String fecDesde) {
		this.fecDesde = fecDesde;
	}
	public String getFecHasta() {
		return fecHasta;
	}
	public void setFecHasta(String fecHasta) {
		this.fecHasta = fecHasta;
	}   
    





}