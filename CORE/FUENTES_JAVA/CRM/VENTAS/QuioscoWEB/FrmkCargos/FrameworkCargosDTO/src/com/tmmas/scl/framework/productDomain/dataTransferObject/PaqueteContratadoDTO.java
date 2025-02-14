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
 * 17/08/2007     			 Cristian Toledo              		Versión Inicial
 */
package com.tmmas.scl.framework.productDomain.dataTransferObject;

import java.io.Serializable;

public class PaqueteContratadoDTO extends ProductoContratadoDTO implements Serializable
{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String idPaquete;
	private String codProdPadre;
	private String codProdHijo;	
	private int cantidad;
	ProductoContratadoListDTO listaProductosContratados;
	
	
	public PaqueteContratadoDTO()
	{
		super();
	}

	public int getCantidad() {
		return cantidad;
	}

	public void setCantidad(int cantidad) {
		this.cantidad = cantidad;
	}

	public String getCodProdHijo() {
		return codProdHijo;
	}

	public void setCodProdHijo(String codProdHijo) {
		this.codProdHijo = codProdHijo;
	}

	public String getCodProdPadre() {
		return codProdPadre;
	}

	public void setCodProdPadre(String codProdPadre) {
		this.codProdPadre = codProdPadre;
	}
	public String getIdPaquete() {
		return idPaquete;
	}

	public void setIdPaquete(String idPaquete) {
		this.idPaquete = idPaquete;
	}

	public ProductoContratadoListDTO getListaProductosContratados() {
		return listaProductosContratados;
	}

	public void setListaProductosContratados(
			ProductoContratadoListDTO listaProductosContratados) {
		this.listaProductosContratados = listaProductosContratados;
	}
}
