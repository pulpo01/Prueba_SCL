/**
 * Copyright © 2006 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 10-07-2007     			 Cristian Toledo              		Versión Inicial
 */
package com.tmmas.scl.framework.productDomain.dataTransferObject;

import java.io.Serializable;

public class CategoriaDTO implements Serializable
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String idCategoria;
	private String cargoMinReq;
	private String nombre;
	private String tipoAplicacion;
	
	
	public Object[] toStruct_PS_CAT_CARGO_TD_QT()
	{
		Object[] obj={idCategoria,cargoMinReq,nombre,tipoAplicacion};
		return obj;
	}	
	
	public String getCargoMinReq() {
		return cargoMinReq;
	}
	public void setCargoMinReq(String cargoMinReq) {
		this.cargoMinReq = cargoMinReq;
	}
	public String getIdCategoria() {
		return idCategoria;
	}
	public void setIdCategoria(String idCategoria) {
		this.idCategoria = idCategoria;
	}
	public String getNombre() {
		return nombre;
	}
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	public String getTipoAplicacion() {
		return tipoAplicacion;
	}
	public void setTipoAplicacion(String tipoAplicacion) {
		this.tipoAplicacion = tipoAplicacion;
	}
	
	
}
