/**
 * Copyright © 2008 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 09/09/2008         Hernán Segura Muñoz                  Versión Inicial 
 * 
 *
 * 
 * ConceptosDTO
 * @author Hernán Segura Muñoz 
 * @version 1.0
 **/
package com.tmmas.scl.framework.CustomerDomain.CustomerBillABE.dto;

import java.io.Serializable;

public class CargoDTO  implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String codigoConceptoCargo;
	private String cantidad;
	private String importeUnitario;
	private DescuentoDTO [] descuentoDTO;

	public void setCantidad(String cantidad) {
		this.cantidad = cantidad;
	}
	public String getCodigoConceptoCargo() {
		return codigoConceptoCargo;
	}
	public void setCodigoConceptoCargo(String codigoConceptoCargo) {
		this.codigoConceptoCargo = codigoConceptoCargo;
	}
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}
	public String getImporteUnitario() {
		return importeUnitario;
	}
	public void setImporteUnitario(String importeUnitario) {
		this.importeUnitario = importeUnitario;
	}
	public String getCantidad() {
		return cantidad;
	}
	public DescuentoDTO[] getDescuentoDTO() {
		return descuentoDTO;
	}
	public void setDescuentoDTO(DescuentoDTO[] descuentoDTO) {
		this.descuentoDTO = descuentoDTO;
	}
}
