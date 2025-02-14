/**
 * Copyright © 2009 Telefonica Moviles, Soluciones y Aplicaciones, S.A.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informacion propietaria y confidencial de T-mAs S.A.
 * Usted no debe develar tal informacion y solo debe usarla en concordancia
 * con los terminos de derechos de licencias que sean adquiridos con T-mAs S.A.
 */
package com.tmmas.scl.wsportal.common.dto;

import java.io.Serializable;

public class ReportePresEquiIntDTO implements Serializable
{
	private static final long serialVersionUID = 1L;

	private String fecPrestamo;
	private String equipo;
	private String equiMarca;
	private String equiModelo;
	private String equiSerie;
	private String abonado;
	private String codCliente;
	
	public String getFecPrestamo() {
		return fecPrestamo;
	}
	public void setFecPrestamo(String fecPrestamo) {
		this.fecPrestamo = fecPrestamo;
	}
	public String getEquipo() {
		return equipo;
	}
	public void setEquipo(String equipo) {
		this.equipo = equipo;
	}
	public String getEquiMarca() {
		return equiMarca;
	}
	public void setEquiMarca(String equiMarca) {
		this.equiMarca = equiMarca;
	}
	public String getEquiModelo() {
		return equiModelo;
	}
	public void setEquiModelo(String equiModelo) {
		this.equiModelo = equiModelo;
	}
	public String getEquiSerie() {
		return equiSerie;
	}
	public void setEquiSerie(String equiSerie) {
		this.equiSerie = equiSerie;
	}
	public String getAbonado() {
		return abonado;
	}
	public void setAbonado(String abonado) {
		this.abonado = abonado;
	}
	public String getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(String codCliente) {
		this.codCliente = codCliente;
	}
	
}
