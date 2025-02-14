package com.tmmas.cl.scl.customerdomain.businessobject.dto;

import java.io.Serializable;

public class PagareDTO implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	
	//Valores equipo con iva
	private double imp_equipo; 
	private String dineroLetrasEq; 
	private String decimalLetrasEq; 
	
	//Valore limite sin iva
	private double imp_lim;
	private String dineroLetrasLimSinIva; 
	private String decimalLetrasLimSinIva;	
	
	private String nombreCliente;	
	private String glosaDireccion;
	
	public String getGlosaDireccion() {
		return glosaDireccion;
	}
	public void setGlosaDireccion(String glosaDireccion) {
		this.glosaDireccion = glosaDireccion;
	}	
	public String getNombreCliente() {
		return nombreCliente;
	}
	public void setNombreCliente(String nombreCliente) {
		this.nombreCliente = nombreCliente;
	}
	
	public double getImp_lim() {
		return imp_lim;
	}
	public void setImp_lim(double imp_lim) {
		this.imp_lim = imp_lim;
	}
	public String getDecimalLetrasEq() {
		return decimalLetrasEq;
	}
	public void setDecimalLetrasEq(String decimalLetrasEq) {
		this.decimalLetrasEq = decimalLetrasEq;
	}
	public String getDecimalLetrasLimSinIva() {
		return decimalLetrasLimSinIva;
	}
	public void setDecimalLetrasLimSinIva(String decimalLetrasLimSinIva) {
		this.decimalLetrasLimSinIva = decimalLetrasLimSinIva;
	}
	public String getDineroLetrasEq() {
		return dineroLetrasEq;
	}
	public void setDineroLetrasEq(String dineroLetrasEq) {
		this.dineroLetrasEq = dineroLetrasEq;
	}
	public String getDineroLetrasLimSinIva() {
		return dineroLetrasLimSinIva;
	}
	public void setDineroLetrasLimSinIva(String dineroLetrasLimSinIva) {
		this.dineroLetrasLimSinIva = dineroLetrasLimSinIva;
	}
	public double getImp_equipo() {
		return imp_equipo;
	}
	public void setImp_equipo(double imp_equipo) {
		this.imp_equipo = imp_equipo;
	}
	
	
	
	

}
