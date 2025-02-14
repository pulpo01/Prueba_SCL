/**
 * Copyright © 2007 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 19/01/2007     Héctor Hermosilla      					Versión Inicial
 */

package com.tmmas.scl.operation.crm.fab.cusintman.servsup.common.dataTransfertObject;

import com.tmmas.cl.scl.commonbusinessentities.interfaz.Direccion;

public class DireccionNegocioWebDTO implements Direccion{
	private static final long serialVersionUID = 1L;
	
	private String codigo;
	private String codDepartamento; 
	private String codMunicipio;
	private String codZonaDistrito;
	private String locBarrio;
	private String codSiglaDomicilio;
	private String nombreCalle; 
	private String numeroCalle;
	private String observacionDireccion;
	private String codigoPostalDireccion;
	private int tipo;
	private boolean replicada;
	
	public boolean isReplicada() {
		return replicada;
	}
	public void setReplicada(boolean replicada) {
		this.replicada = replicada;
	}
	public String getCodZonaDistrito() {
		return codZonaDistrito;
	}
	public void setCodZonaDistrito(String codZonaDistrito) {
		this.codZonaDistrito = codZonaDistrito;
	}
	public String getCodDepartamento() {
		return codDepartamento;
	}
	public void setCodDepartamento(String codDepartamento) {
		this.codDepartamento = codDepartamento;
	}
	public String getCodigoPostalDireccion() {
		return codigoPostalDireccion;
	}
	public void setCodigoPostalDireccion(String codigoPostalDireccion) {
		this.codigoPostalDireccion = codigoPostalDireccion;
	}	
	public String getCodMunicipio() {
		return codMunicipio;
	}
	public void setCodMunicipio(String codMunicipio) {
		this.codMunicipio = codMunicipio;
	}
	public String getCodSiglaDomicilio() {
		return codSiglaDomicilio;
	}
	public void setCodSiglaDomicilio(String codSiglaDomicilio) {
		this.codSiglaDomicilio = codSiglaDomicilio;
	}
	public String getNombreCalle() {
		return nombreCalle;
	}
	public void setNombreCalle(String nombreCalle) {
		this.nombreCalle = nombreCalle;
	}
	public String getLocBarrio() {
		return locBarrio;
	}
	public void setLocBarrio(String locBarrio) {
		this.locBarrio = locBarrio;
	}
	public String getNumeroCalle() {
		return numeroCalle;
	}
	public void setNumeroCalle(String numeroCalle) {
		this.numeroCalle = numeroCalle;
	}
	public String getObservacionDireccion() {
		return observacionDireccion;
	}
	public void setObservacionDireccion(String observacionDireccion) {
		this.observacionDireccion = observacionDireccion;
	}
	public int getTipo() {
		return tipo;
	}
	public void setTipo(int tipo) {
		this.tipo = tipo;
	}
	public String getCodigo() {
		return codigo;
	}
	public void setCodigo(String codigo) {
		this.codigo = codigo;
	}
	
}
