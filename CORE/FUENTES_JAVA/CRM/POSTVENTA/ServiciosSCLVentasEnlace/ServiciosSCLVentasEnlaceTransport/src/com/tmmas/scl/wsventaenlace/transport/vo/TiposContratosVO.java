/**
 * 
 */
package com.tmmas.scl.wsventaenlace.transport.vo;

import java.io.Serializable;

public class TiposContratosVO implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	/**
	 * El código del tipo del contrato.
	 */
	private	String	codTipContrato;
	/**
	 * Descripción de tipo de contrato.
	 */
	private	String	desTipContrato;
	/**
	 * Contrato comodato si o no
	 */
	private	long	IndComodato;
	/**
	 * Número  de meses mínimo.
	 */
	private	long	MesesMinimo;
	/**
	 * Determina si un contrato es precio de lista o politica  0=P/L; 1=P/P;.
	 */
	private	String	IndPrecioLista;
	/**
	 * Determina si el contrato es para equipo interno o externo  E=Externo I=interno.
	 */
	private	String	IndProcequiI;
	/**
	 * Vigencia del tipo de contrato.
	 */
	private	String	vigContrato;
	
	/**
	 * 
	 */
	public TiposContratosVO() {

	}


	/**
	 * @return String the codTipContrato 
	 */
	public String getCodTipContrato() {
		return codTipContrato;
	}


	/**
	 * @param codTipContrato String the codTipContrato to set
	 */
	public void setCodTipContrato(String codTipContrato) {
		this.codTipContrato = codTipContrato;
	}


	/**
	 * @return String the desTipContrato 
	 */
	public String getDesTipContrato() {
		return desTipContrato;
	}


	/**
	 * @param desTipContrato String the desTipContrato to set
	 */
	public void setDesTipContrato(String desTipContrato) {
		this.desTipContrato = desTipContrato;
	}


	/**
	 * @return long the indComodato 
	 */
	public long getIndComodato() {
		return IndComodato;
	}


	/**
	 * @param indComodato long the indComodato to set
	 */
	public void setIndComodato(long indComodato) {
		IndComodato = indComodato;
	}


	/**
	 * @return String the indPrecioLista 
	 */
	public String getIndPrecioLista() {
		return IndPrecioLista;
	}


	/**
	 * @param indPrecioLista String the indPrecioLista to set
	 */
	public void setIndPrecioLista(String indPrecioLista) {
		IndPrecioLista = indPrecioLista;
	}


	/**
	 * @return String the indProcequiI 
	 */
	public String getIndProcequiI() {
		return IndProcequiI;
	}


	/**
	 * @param indProcequiI String the indProcequiI to set
	 */
	public void setIndProcequiI(String indProcequiI) {
		IndProcequiI = indProcequiI;
	}


	/**
	 * @return long the mesesMinimo 
	 */
	public long getMesesMinimo() {
		return MesesMinimo;
	}


	/**
	 * @param mesesMinimo long the mesesMinimo to set
	 */
	public void setMesesMinimo(long mesesMinimo) {
		MesesMinimo = mesesMinimo;
	}


	/**
	 * @return String the vigContrato 
	 */
	public String getVigContrato() {
		return vigContrato;
	}


	/**
	 * @param vigContrato String the vigContrato to set
	 */
	public void setVigContrato(String vigContrato) {
		this.vigContrato = vigContrato;
	}

}
