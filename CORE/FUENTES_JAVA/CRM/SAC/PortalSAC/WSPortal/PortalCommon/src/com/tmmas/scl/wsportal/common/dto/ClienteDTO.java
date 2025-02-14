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

public class ClienteDTO implements Serializable
{

	private static final long serialVersionUID = 1L;

	private Long codCliente;

	private String nomCliente;

	private String fecAlta;

	private String tipPersona;

	private String codCuenta;

	//Es para el ordenamiento de la tabla
	private String fecAltaOrd;
	
	public String getFecAlta()
	{
		return fecAlta;
	}

	public void setFecAlta(String fecAlta)
	{
		this.fecAlta = fecAlta;
	}

	public String getCodCuenta()
	{
		return codCuenta;
	}

	public void setCodCuenta(String codCuenta)
	{
		this.codCuenta = codCuenta;
	}

	public Long getCodCliente()
	{
		return codCliente;
	}

	public void setCodCliente(Long codCliente)
	{
		this.codCliente = codCliente;
	}

	public String getNomCliente()
	{
		return nomCliente;
	}

	public void setNomCliente(String nomCliente)
	{
		this.nomCliente = nomCliente;
	}

	public String getTipPersona()
	{
		return tipPersona;
	}

	public void setTipPersona(String tipPersona)
	{
		this.tipPersona = tipPersona;
	}

	public String getFecAltaOrd() {
		return fecAltaOrd;
	}

	public void setFecAltaOrd(String fecAltaOrd) {
		this.fecAltaOrd = fecAltaOrd;
	}

	public String toXml()
	{
		StringBuffer b = new StringBuffer();
		b.append("<cliente>");
		b.append("<codCliente>");
		b.append(getCodCliente());
		b.append("</codCliente>");
		b.append("<nomCliente>");
		b.append(getNomCliente());
		b.append("</nomCliente>");
		b.append("<fecAlta>");
		b.append(getFecAlta());
		b.append("</fecAlta>");
		b.append("<tipPersona>");
		b.append(getTipPersona());
		b.append("</tipPersona>");
		b.append("<codCuenta>");
		b.append(getCodCuenta());
		b.append("</codCuenta>");
		b.append("<fecAltaOrd>");
		b.append(getFecAltaOrd());
		b.append("</fecAltaOrd>");
		b.append("</cliente>");
		return b.toString();
	}
}
