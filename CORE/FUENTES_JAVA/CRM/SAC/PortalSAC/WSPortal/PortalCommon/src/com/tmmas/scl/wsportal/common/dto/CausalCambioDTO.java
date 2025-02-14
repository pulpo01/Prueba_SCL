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

public class CausalCambioDTO implements Serializable
{
	private static final long serialVersionUID = 1L;

	//private String codProducto;
	private String codCaucaser;
	private String desCaucaser;
	//private String indAntiguedad;
	//private String indCargo;
	//private String indDevAlmacen;
	//private String codEstadoDev;
	/*
	public String getCodProducto() {
		return codProducto;
	}
	public void setCodProducto(String codProducto) {
		this.codProducto = codProducto;
	}
	*/
	public String getCodCaucaser() {
		return codCaucaser;
	}
	public void setCodCaucaser(String codCaucaser) {
		this.codCaucaser = codCaucaser;
	}
	public String getDesCaucaser() {
		return desCaucaser;
	}
	public void setDesCaucaser(String desCaucaser) {
		this.desCaucaser = desCaucaser;
	}
	/*
	public String getIndAntiguedad() {
		return indAntiguedad;
	}
	public void setIndAntiguedad(String indAntiguedad) {
		this.indAntiguedad = indAntiguedad;
	}
	public String getIndCargo() {
		return indCargo;
	}
	public void setIndCargo(String indCargo) {
		this.indCargo = indCargo;
	}
	public String getIndDevAlmacen() {
		return indDevAlmacen;
	}
	public void setIndDevAlmacen(String indDevAlmacen) {
		this.indDevAlmacen = indDevAlmacen;
	}
	public String getCodEstadoDev() {
		return codEstadoDev;
	}
	public void setCodEstadoDev(String codEstadoDev) {
		this.codEstadoDev = codEstadoDev;
	}
	*/
}
