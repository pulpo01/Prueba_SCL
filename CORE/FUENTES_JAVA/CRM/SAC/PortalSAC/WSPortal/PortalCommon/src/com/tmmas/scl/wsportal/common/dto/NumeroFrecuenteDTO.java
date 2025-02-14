/**
 * Copyright © 2009 Telefonica Moviles, Soluciones y Aplicaciones, S.A.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informacion propietaria y confidencial de T-mAs S.A.
 * Usted no debe develar tal informacion y solo debe usarla en concordancia
 * con los terminos de derechos de licencias que sean adquiridos con T-mAs S.A.
 */
package com.tmmas.scl.wsportal.common.dto;

import java.io.Serializable;

public class NumeroFrecuenteDTO implements Serializable
{
	private static final long serialVersionUID = -9003164298729992231L;

	private String tipNumFrecuente;

	private String numTelefEspecial;

	/**
	 * @return the numTelefEspecial
	 */
	public String getNumTelefEspecial()
	{
		return numTelefEspecial;
	}

	/**
	 * @param numTelefEspecial the numTelefEspecial to set
	 */
	public void setNumTelefEspecial(String numTelefEspecial)
	{
		this.numTelefEspecial = numTelefEspecial;
	}

	/**
	 * @return the tipNumFrecuente
	 */
	public String getTipNumFrecuente()
	{
		return tipNumFrecuente;
	}

	/**
	 * @param tipNumFrecuente the tipNumFrecuente to set
	 */
	public void setTipNumFrecuente(String tipNumFrecuente)
	{
		this.tipNumFrecuente = tipNumFrecuente;
	}

}
