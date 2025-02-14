/**
 * 
 */
package com.tmmas.scl.wsventaenlace.transport.vo;

import java.io.Serializable;

public class OrigenRecargaVO implements Serializable {
	
	/** C�digo de valor del Origen */
	private Long codValor;
	/** Descripci�n del Valor del Origen */
	private String desValor;

	/**
	 * 
	 */
	public OrigenRecargaVO() {

	}

	/**
	 * @return the codValor
	 */
	public Long getCodValor() {
		return codValor;
	}

	/**
	 * @param codValor the codValor to set
	 */
	public void setCodValor(Long codValor) {
		this.codValor = codValor;
	}

	/**
	 * @return the desValor
	 */
	public String getDesValor() {
		return desValor;
	}

	/**
	 * @param desValor the desValor to set
	 */
	public void setDesValor(String desValor) {
		this.desValor = desValor;
	}
}
