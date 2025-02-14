package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;


public class ComponentesDTO implements Serializable{
	/*
	 * Autor : Daniel Jara Oyarzún
	 * */
	private static final long serialVersionUID = 1L;
	private  String    codServicio;      																								 
	private	 long      codServsupl;     
	private	 long      codNivel;    
	private	 String    desServicio;
	
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}
	public long getCodNivel() {
		return codNivel;
	}
	public void setCodNivel(long codNivel) {
		this.codNivel = codNivel;
	}
	public String getCodServicio() {
		return codServicio;
	}
	public void setCodServicio(String codServicio) {
		this.codServicio = codServicio;
	}
	public long getCodServsupl() {
		return codServsupl;
	}
	public void setCodServsupl(long codServsupl) {
		this.codServsupl = codServsupl;
	}
	public String getDesServicio() {
		return desServicio;
	}
	public void setDesServicio(String desServicio) {
		this.desServicio = desServicio;
	}      
     																								 
	
	
	
}
