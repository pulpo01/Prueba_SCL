/**
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 05/07/2007	     	Elizabeth Vera        				Versión Inicial
 */
package com.tmmas.scl.framework.customerDomain.dataTransferObject;

import java.io.Serializable;

public class IOOSSDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private long numOs;
	private String codOS;
	private int maxIntentos;
	private String comentario;
	private long numOsOrigen;
	
	private long codCliente;
	private long numAbonado;
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
	public long getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(long numAbonado) {
		this.numAbonado = numAbonado;
	}
	public String getComentario() {
		return comentario;
	}
	public void setComentario(String comentario) {
		this.comentario = comentario;
	}
	public long getNumOsOrigen() {
		return numOsOrigen;
	}
	public void setNumOsOrigen(long numOsOrigen) {
		this.numOsOrigen = numOsOrigen;
	}
	public String getCodOS() {
		return codOS;
	}
	public void setCodOS(String codOS) {
		this.codOS = codOS;
	}
	public int getMaxIntentos() {
		return maxIntentos;
	}
	public void setMaxIntentos(int maxIntentos) {
		this.maxIntentos = maxIntentos;
	}
	public long getNumOs() {
		return numOs;
	}
	public void setNumOs(long numOs) {
		this.numOs = numOs;
	}
	public long getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(long codCliente) {
		this.codCliente = codCliente;
	}
	
}
