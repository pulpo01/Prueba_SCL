package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;


public class LlamadaFacturadaDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	private long   	numFolio;
	private String fechaLlamada;  
	private String horaLlamada;   
	private String numeroDestino; 
	private double mtoLlamSinImp;   
	private double mtoLlamConImp;   
	private String 	desLlamada;
	private long duracion;        
	private String unidad;
	
	
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}
	public String getDesLlamada() {
		return desLlamada;
	}
	public void setDesLlamada(String desLlamada) {
		this.desLlamada = desLlamada;
	}
	public long getDuracion() {
		return duracion;
	}
	public void setDuracion(long duracion) {
		this.duracion = duracion;
	}
	public String getFechaLlamada() {
		return fechaLlamada;
	}
	public void setFechaLlamada(String fechaLlamada) {
		this.fechaLlamada = fechaLlamada;
	}
	public String getHoraLlamada() {
		return horaLlamada;
	}
	public void setHoraLlamada(String horaLlamada) {
		this.horaLlamada = horaLlamada;
	}
	public double getMtoLlamConImp() {
		return mtoLlamConImp;
	}
	public void setMtoLlamConImp(double mtoLlamConImp) {
		this.mtoLlamConImp = mtoLlamConImp;
	}
	public double getMtoLlamSinImp() {
		return mtoLlamSinImp;
	}
	public void setMtoLlamSinImp(double mtoLlamSinImp) {
		this.mtoLlamSinImp = mtoLlamSinImp;
	}
	public String getNumeroDestino() {
		return numeroDestino;
	}
	public void setNumeroDestino(String numeroDestino) {
		this.numeroDestino = numeroDestino;
	}
	public long getNumFolio() {
		return numFolio;
	}
	public void setNumFolio(long numFolio) {
		this.numFolio = numFolio;
	}
	public String getUnidad() {
		return unidad;
	}
	public void setUnidad(String unidad) {
		this.unidad = unidad;
	}


}
