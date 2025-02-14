/**
 * 
 */
package com.tmmas.scl.wsventaenlace.transport.vo;

import java.io.Serializable;


public class TipoRecargaVO implements Serializable {
	
	/** Código de la Recarga */
	private String	codRecarga;
	/** Descripción de la Recarga */
	private String	desRecarga;
	/** Código de la sub cuenta */
	private String	indRecompra;	

	/**
	 * 
	 */
	public TipoRecargaVO() {
		// TODO Auto-generated constructor stub
	}

	/**
	 * @return the codRecarga
	 */
	public String getCodRecarga() {
		return codRecarga;
	}

	/**
	 * @param codRecarga the codRecarga to set
	 */
	public void setCodRecarga(String codRecarga) {
		this.codRecarga = codRecarga;
	}

	/**
	 * @return the desRecarga
	 */
	public String getDesRecarga() {
		return desRecarga;
	}

	/**
	 * @param desRecarga the desRecarga to set
	 */
	public void setDesRecarga(String desRecarga) {
		this.desRecarga = desRecarga;
	}

	/**
	 * @return the indRecompra
	 */
	public String getIndRecompra() {
		return indRecompra;
	}

	/**
	 * @param indRecompra the indRecompra to set
	 */
	public void setIndRecompra(String indRecompra) {
		this.indRecompra = indRecompra;
	}

}
