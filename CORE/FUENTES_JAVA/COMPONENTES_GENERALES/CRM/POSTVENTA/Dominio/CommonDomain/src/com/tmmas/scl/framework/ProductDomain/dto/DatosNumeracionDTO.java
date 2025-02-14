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


public class DatosNumeracionDTO implements Serializable {
	
	private static final long serialVersionUID = 6828947545186039584L;
	private String codCeldNue;
    private String codCentNue;
    private String codCodUsoNue;
    private String codActabo;
    private String codSubalmNue;
    private Long numCelular;
    private String nomtabla;
    private String codCatNue;
    private String fecBaja;
    private SeleccionNumeroCelularDTO[] arrayNumerosReutilizables;
	private SeleccionNumeroCelularDTO[] arrayNumerosReservados;
	private SeleccionNumeroCelularRangoDTO[] arrayNumerosCelularRango;
	private Long limiteInferior;
	private Long limiteSuperior;
	private Long codCliente;
	private Long codVendedor;
	private String[] arrayCodCatNue;
	//TODO: 29ENE2009 76301 Se agrega atributo para controlar la cantidad maxima de celulares que el sistema puede devolver. HH
	private int cantidadMaximaNrosCelulares;
	private Long CodVendealer;
	
    public Long getCodVendealer() {
		return CodVendealer;
	}
	public void setCodVendealer(Long codVendealer) {
		CodVendealer = codVendealer;
	}
	/**
	 * @return the cantidadMaximaCelulares
	 */
	public int getCantidadMaximaNrosCelulares() {
		return cantidadMaximaNrosCelulares;
	}
	/**
	 * @param cantidadMaximaCelulares the cantidadMaximaCelulares to set
	 */
	public void setCantidadMaximaNrosCelulares(int cantidadMaximaNrosCelulares) {
		this.cantidadMaximaNrosCelulares = cantidadMaximaNrosCelulares;
	}
	/**
	 * @return the codCliente
	 */
	public Long getCodCliente() {
		return codCliente;
	}
	/**
	 * @param codCliente the codCliente to set
	 */
	public void setCodCliente(Long codCliente) {
		this.codCliente = codCliente;
	}
	/**
	 * @return the codVendedor
	 */
	public Long getCodVendedor() {
		return codVendedor;
	}
	/**
	 * @param codVendedor the codVendedor to set
	 */
	public void setCodVendedor(Long codVendedor) {
		this.codVendedor = codVendedor;
	}
	/**
	 * @return the limiteInferior
	 */
	public Long getLimiteInferior() {
		return limiteInferior;
	}
	/**
	 * @param limiteInferior the limiteInferior to set
	 */
	public void setLimiteInferior(Long limiteInferior) {
		this.limiteInferior = limiteInferior;
	}
	/**
	 * @return the limiteSuperior
	 */
	public Long getLimiteSuperior() {
		return limiteSuperior;
	}
	/**
	 * @param limiteSuperior the limiteSuperior to set
	 */
	public void setLimiteSuperior(Long limiteSuperior) {
		this.limiteSuperior = limiteSuperior;
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
	 * @return the codCatNue
	 */
	public String getCodCatNue() {
		return codCatNue;
	}
	/**
	 * @param codCatNue the codCatNue to set
	 */
	public void setCodCatNue(String codCatNue) {
		this.codCatNue = codCatNue;
	}
	/**
	 * @return the codCeldNue
	 */
	public String getCodCeldNue() {
		return codCeldNue;
	}
	/**
	 * @param codCeldNue the codCeldNue to set
	 */
	public void setCodCeldNue(String codCeldNue) {
		this.codCeldNue = codCeldNue;
	}
	/**
	 * @return the codCentNue
	 */
	public String getCodCentNue() {
		return codCentNue;
	}
	/**
	 * @param codCentNue the codCentNue to set
	 */
	public void setCodCentNue(String codCentNue) {
		this.codCentNue = codCentNue;
	}
	/**
	 * @return the codCodUsoNue
	 */
	public String getCodCodUsoNue() {
		return codCodUsoNue;
	}
	/**
	 * @param codCodUsoNue the codCodUsoNue to set
	 */
	public void setCodCodUsoNue(String codCodUsoNue) {
		this.codCodUsoNue = codCodUsoNue;
	}
	/**
	 * @return the codSubalmNue
	 */
	public String getCodSubalmNue() {
		return codSubalmNue;
	}
	/**
	 * @param codSubalmNue the codSubalmNue to set
	 */
	public void setCodSubalmNue(String codSubalmNue) {
		this.codSubalmNue = codSubalmNue;
	}
	/**
	 * @return the fecBaja
	 */
	public String getFecBaja() {
		return fecBaja;
	}
	/**
	 * @param fecBaja the fecBaja to set
	 */
	public void setFecBaja(String fecBaja) {
		this.fecBaja = fecBaja;
	}
	/**
	 * @return the nomtabla
	 */
	public String getNomtabla() {
		return nomtabla;
	}
	/**
	 * @param nomtabla the nomtabla to set
	 */
	public void setNomtabla(String nomtabla) {
		this.nomtabla = nomtabla;
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
	 * @return the arrayCodCatNue
	 */
	public String[] getArrayCodCatNue() {
		return arrayCodCatNue;
	}
	/**
	 * @param arrayCodCatNue the arrayCodCatNue to set
	 */
	public void setArrayCodCatNue(String[] arrayCodCatNue) {
		this.arrayCodCatNue = arrayCodCatNue;
	}

}
