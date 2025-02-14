package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;
/*
 * AUTOR: juan daniel Muñoz Queupul
 * */
public class ConsumoDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	private String codUnidad;  
	private String desUnidad;   
	private String codTdir; 
	private long durReal;  
	
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}
	public String getCodTdir() {
		return codTdir;
	}
	public void setCodTdir(String codTdir) {
		this.codTdir = codTdir;
	}
	public String getCodUnidad() {
		return codUnidad;
	}
	public void setCodUnidad(String codUnidad) {
		this.codUnidad = codUnidad;
	}
	public long getDurReal() {
		return durReal;
	}
	public void setDurReal(long durReal) {
		this.durReal = durReal;
	}
	public String getMensaje() {
		return desUnidad;
	}
	public void setMensaje(String mensaje) {
		this.desUnidad = mensaje;
	}
}
