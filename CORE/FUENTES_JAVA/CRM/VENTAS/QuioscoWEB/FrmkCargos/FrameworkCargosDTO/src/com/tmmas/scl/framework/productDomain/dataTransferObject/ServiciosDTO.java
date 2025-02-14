/**
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 17/05/2007	     	Elizabeth Vera        				Versión Inicial
 */
package com.tmmas.scl.framework.productDomain.dataTransferObject;

import java.io.Serializable;
import java.util.Date;

public class ServiciosDTO implements Serializable {
	private static final long serialVersionUID = 1L;

	private ServicioDTO[] serviciosActivar;
	private ServicioDTO[] serviciosDesactivar;
	
	private String cadenaServiciosActivar;
	private String cadenaserviciosDesactivar;
	
	private Date fechaVencimiento;
	private String periodoFacturacion; //CORREGIR
	
	
	public Date getFechaVencimiento() {
		return fechaVencimiento;
	}
	public void setFechaVencimiento(Date fechaVencimiento) {
		this.fechaVencimiento = fechaVencimiento;
	}
	public String getPeriodoFacturacion() {
		return periodoFacturacion;
	}
	public void setPeriodoFacturacion(String periodoFacturacion) {
		this.periodoFacturacion = periodoFacturacion;
	}
	public String getCadenaServiciosActivar() {
		return cadenaServiciosActivar;
	}
	public void setCadenaServiciosActivar(String cadenaServiciosActivar) {
		this.cadenaServiciosActivar = cadenaServiciosActivar;
	}
	public String getCadenaserviciosDesactivar() {
		return cadenaserviciosDesactivar;
	}
	public void setCadenaserviciosDesactivar(String cadenaserviciosDesactivar) {
		this.cadenaserviciosDesactivar = cadenaserviciosDesactivar;
	}
	public ServicioDTO[] getServiciosActivar() {
		return serviciosActivar;
	}
	public void setServiciosActivar(ServicioDTO[] serviciosActivar) {
		this.serviciosActivar = serviciosActivar;
	}
	public ServicioDTO[] getServiciosDesactivar() {
		return serviciosDesactivar;
	}
	public void setServiciosDesactivar(ServicioDTO[] serviciosDesactivar) {
		this.serviciosDesactivar = serviciosDesactivar;
	}
	
	
}
