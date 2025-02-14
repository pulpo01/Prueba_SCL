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
package com.tmmas.cl.scl.productdomain.businessobject.dto;

import java.io.Serializable;

public class CargaNumeracionCelularDTO 
	implements Serializable 
{
	private static final long serialVersionUID = -7804016914024445852L;
	private Integer codUso;
	private Long numAbonado;
	private Long limiteInferiorRango;
	private Long limiteSuperiorRango;
	private Integer prefijo;
	private String codCelda;
	private String codActabo;
	private String codCentral;
	private String IndNumeracionManual;
	private Long numCelular;
	private SeleccionNumeroCelularDTO[] arrayNumerosReutilizables;
	private SeleccionNumeroCelularDTO[] arrayNumerosReservados;
	private SeleccionNumeroCelularRangoDTO[] arrayNumerosCelularRango;
	
	/**
	 * @return the arrayNumerosCelularRango
	 */
	public SeleccionNumeroCelularRangoDTO[] getArrayNumerosCelularRango() {
		return arrayNumerosCelularRango;
	}
	/**
	 * @param arrayNumerosCelularRango the arrayNumerosCelularRango to set
	 */
	public void setArrayNumerosCelularRango(
			SeleccionNumeroCelularRangoDTO[] arrayNumerosCelularRango) {
		this.arrayNumerosCelularRango = arrayNumerosCelularRango;
	}
	/**
	 * @return the arrayNumerosReservados
	 */
	public SeleccionNumeroCelularDTO[] getArrayNumerosReservados() {
		return arrayNumerosReservados;
	}
	/**
	 * @param arrayNumerosReservados the arrayNumerosReservados to set
	 */
	public void setArrayNumerosReservados(
			SeleccionNumeroCelularDTO[] arrayNumerosReservados) {
		this.arrayNumerosReservados = arrayNumerosReservados;
	}
	/**
	 * @return the arrayNumerosReutilizables
	 */
	public SeleccionNumeroCelularDTO[] getArrayNumerosReutilizables() {
		return arrayNumerosReutilizables;
	}
	/**
	 * @param arrayNumerosReutilizables the arrayNumerosReutilizables to set
	 */
	public void setArrayNumerosReutilizables(
			SeleccionNumeroCelularDTO[] arrayNumerosReutilizables) {
		this.arrayNumerosReutilizables = arrayNumerosReutilizables;
	}
	/**
	 * @return the codActabo
	 */
	public String getCodActabo() {
		return codActabo;
	}
	/**
	 * @param codActabo the codActabo to set
	 */
	public void setCodActabo(String codActabo) {
		this.codActabo = codActabo;
	}
	/**
	 * @return the codCelda
	 */
	public String getCodCelda() {
		return codCelda;
	}
	/**
	 * @param codCelda the codCelda to set
	 */
	public void setCodCelda(String codCelda) {
		this.codCelda = codCelda;
	}
	/**
	 * @return the codCentral
	 */
	public String getCodCentral() {
		return codCentral;
	}
	/**
	 * @param codCentral the codCentral to set
	 */
	public void setCodCentral(String codCentral) {
		this.codCentral = codCentral;
	}
	/**
	 * @return the codUso
	 */
	public Integer getCodUso() {
		return codUso;
	}
	/**
	 * @param codUso the codUso to set
	 */
	public void setCodUso(Integer codUso) {
		this.codUso = codUso;
	}
	/**
	 * @return the indNumeracionManual
	 */
	public String getIndNumeracionManual() {
		return IndNumeracionManual;
	}
	/**
	 * @param indNumeracionManual the indNumeracionManual to set
	 */
	public void setIndNumeracionManual(String indNumeracionManual) {
		IndNumeracionManual = indNumeracionManual;
	}
	/**
	 * @return the limiteInferiorRango
	 */
	public Long getLimiteInferiorRango() {
		return limiteInferiorRango;
	}
	/**
	 * @param limiteInferiorRango the limiteInferiorRango to set
	 */
	public void setLimiteInferiorRango(Long limiteInferiorRango) {
		this.limiteInferiorRango = limiteInferiorRango;
	}
	/**
	 * @return the limiteSuperiorRango
	 */
	public Long getLimiteSuperiorRango() {
		return limiteSuperiorRango;
	}
	/**
	 * @param limiteSuperiorRango the limiteSuperiorRango to set
	 */
	public void setLimiteSuperiorRango(Long limiteSuperiorRango) {
		this.limiteSuperiorRango = limiteSuperiorRango;
	}
	/**
	 * @return the numAbonado
	 */
	public Long getNumAbonado() {
		return numAbonado;
	}
	/**
	 * @param numAbonado the numAbonado to set
	 */
	public void setNumAbonado(Long numAbonado) {
		this.numAbonado = numAbonado;
	}
	/**
	 * @return the numCelular
	 */
	public Long getNumCelular() {
		return numCelular;
	}
	/**
	 * @param numCelular the numCelular to set
	 */
	public void setNumCelular(Long numCelular) {
		this.numCelular = numCelular;
	}
	/**
	 * @return the prefijo
	 */
	public Integer getPrefijo() {
		return prefijo;
	}
	/**
	 * @param prefijo the prefijo to set
	 */
	public void setPrefijo(Integer prefijo) {
		this.prefijo = prefijo;
	}

	

}
