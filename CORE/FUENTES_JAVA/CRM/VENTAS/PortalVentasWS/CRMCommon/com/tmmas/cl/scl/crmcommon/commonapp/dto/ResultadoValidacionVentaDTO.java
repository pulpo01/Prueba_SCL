package com.tmmas.cl.scl.crmcommon.commonapp.dto;

public class ResultadoValidacionVentaDTO 
	extends ResultadoValidacionDTO
{
	
	private static final long serialVersionUID = 1L;
	
	private String mensajeValidacion;
	double precioEquipo;
	
	public double getPrecioEquipo() {
		return precioEquipo;
	}
	public void setPrecioEquipo(double precioEquipo) {
		this.precioEquipo = precioEquipo;
	}
	public String getMensajeValidacion() {
		return mensajeValidacion;
	}
	public void setMensajeValidacion(String mensajeValidacion) {
		this.mensajeValidacion = mensajeValidacion;
	}
}
