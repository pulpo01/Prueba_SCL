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
 * 14/07/2008 09:31     Nicol&aacute;s Contreras    		Versión Inicial 
 * 
 *
 * 
 * @author Nicolas Contreras
 * @version 1.0
 **/
package com.tmmas.scl.framework.ProductDomain.dto;

import java.io.Serializable;

/**
 * @author mwn90113
 *
 */
public class SeleccionNumeroCelularRangoDTO implements Serializable {

	private static final long serialVersionUID = 2418643821222618222L;
	private Long numDesde;
	private Long numHasta;
	private String codCategoria;
	
	public String getCodCategoria() {
		return codCategoria;
	}
	public void setCodCategoria(String codCategoria) {
		this.codCategoria = codCategoria;
	}
	/**
	 * @return the numDesde
	 */
	public Long getNumDesde() {
		return numDesde;
	}
	/**
	 * @param numDesde the numDesde to set
	 */
	public void setNumDesde(Long numDesde) {
		this.numDesde = numDesde;
	}
	/**
	 * @return the numHasta
	 */
	public Long getNumHasta() {
		return numHasta;
	}
	/**
	 * @param numHasta the numHasta to set
	 */
	public void setNumHasta(Long numHasta) {
		this.numHasta = numHasta;
	}


}
