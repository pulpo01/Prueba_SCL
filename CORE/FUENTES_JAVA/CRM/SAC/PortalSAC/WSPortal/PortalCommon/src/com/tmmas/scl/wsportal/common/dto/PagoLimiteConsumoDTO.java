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

public class PagoLimiteConsumoDTO implements Serializable
{

	private static final long serialVersionUID = 1L;

	private String desPago;

	private String fecValor;

	private String nomUsuarora;

	private Double impPago;

	public String getDesPago()
	{
		return desPago;
	}

	public void setDesPago(String desPago)
	{
		this.desPago = desPago;
	}

	public String getFecValor()
	{
		return fecValor;
	}

	public void setFecValor(String fecValor)
	{
		this.fecValor = fecValor;
	}

	public Double getImpPago()
	{
		return impPago;
	}

	public void setImpPago(Double impPago)
	{
		this.impPago = impPago;
	}

	public String getNomUsuarora()
	{
		return nomUsuarora;
	}

	public void setNomUsuarora(String nomUsuarora)
	{
		this.nomUsuarora = nomUsuarora;
	}

}
