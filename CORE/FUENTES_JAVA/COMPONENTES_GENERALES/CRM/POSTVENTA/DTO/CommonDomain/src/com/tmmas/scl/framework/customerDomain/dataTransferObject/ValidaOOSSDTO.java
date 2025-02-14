/**
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 09/07/2007	     	Elizabeth Vera        				Versión Inicial
 */
package com.tmmas.scl.framework.customerDomain.dataTransferObject;

import java.io.Serializable;
import java.util.Date;

public class ValidaOOSSDTO implements Serializable {

	private static final long serialVersionUID = 1L;

	private int codEstado;
	private int numIntentos;
	private String codOS;
	private long numAbonado;
	private long numOS;
	private Date fechaEjecucion;
	
	private long codCliente;
	private String codPlanTarif;
	private String codPlanTarifNuevo;
	
	private String codigo;
	private String mensaje;
	
	public String getCodigo() {
		return codigo;
	}
	public void setCodigo(String codigo) {
		this.codigo = codigo;
	}
	public String getMensaje() {
		return mensaje;
	}
	public void setMensaje(String mensaje) {
		this.mensaje = mensaje;
	}
	public long getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(long codCliente) {
		this.codCliente = codCliente;
	}
	public String getCodPlanTarif() {
		return codPlanTarif;
	}
	public void setCodPlanTarif(String codPlanTarif) {
		this.codPlanTarif = codPlanTarif;
	}
	public String getCodPlanTarifNuevo() {
		return codPlanTarifNuevo;
	}
	public void setCodPlanTarifNuevo(String codPlanTarifNuevo) {
		this.codPlanTarifNuevo = codPlanTarifNuevo;
	}
	public int getCodEstado() {
		return codEstado;
	}
	public void setCodEstado(int codEstado) {
		this.codEstado = codEstado;
	}
	public String getCodOS() {
		return codOS;
	}
	public void setCodOS(String codOS) {
		this.codOS = codOS;
	}
	public Date getFechaEjecucion() {
		return fechaEjecucion;
	}
	public void setFechaEjecucion(Date fechaEjecucion) {
		this.fechaEjecucion = fechaEjecucion;
	}
	public long getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(long numAbonado) {
		this.numAbonado = numAbonado;
	}
	public int getNumIntentos() {
		return numIntentos;
	}
	public void setNumIntentos(int numIntentos) {
		this.numIntentos = numIntentos;
	}
	public long getNumOS() {
		return numOS;
	}
	public void setNumOS(long numOS) {
		this.numOS = numOS;
	}
	

	
}
