/**
 * 
 */
package com.tmmas.scl.wsventaenlace.transport.vo;

import java.io.Serializable;

public class TipoMonederoVO implements Serializable {
	
	/** Código del tipo de monedero */
	String codTipMonedero;		
	/** Descripción del tipo de monedero */
	String desTipMonedero;
	/** Valor por defecto de monedero: (0) defecto (1) no defecto */
	Long codDefault;
	/** Actuación comercial que identifica el servicio asociado al monedero */
	String codActabo;

	/**
	 * 
	 */
	public TipoMonederoVO() {

	}

	/**
	 * @return the codTipMonedero
	 */
	public String getCodTipMonedero() {
		return codTipMonedero;
	}

	/**
	 * @param codTipMonedero the codTipMonedero to set
	 */
	public void setCodTipMonedero(String codTipMonedero) {
		this.codTipMonedero = codTipMonedero;
	}

	/**
	 * @return the desTipMonedero
	 */
	public String getDesTipMonedero() {
		return desTipMonedero;
	}

	/**
	 * @param desTipMonedero the desTipMonedero to set
	 */
	public void setDesTipMonedero(String desTipMonedero) {
		this.desTipMonedero = desTipMonedero;
	}

	/**
	 * @return the codDefault
	 */
	public Long getCodDefault() {
		return codDefault;
	}

	/**
	 * @param codDefault the codDefault to set
	 */
	public void setCodDefault(Long codDefault) {
		this.codDefault = codDefault;
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
}
