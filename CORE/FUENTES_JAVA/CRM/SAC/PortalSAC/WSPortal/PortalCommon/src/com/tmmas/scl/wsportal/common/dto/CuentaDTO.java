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

public class CuentaDTO implements Serializable
{

	private static final long serialVersionUID = 1L;

	private Long codCuenta;

	private String desCuenta;

	private String fecAlta;

	private String tipCuenta;

	//Es para el ordenamiento de la tabla
	private String fecAltaOrd;
	
	public String getDesCuenta()
	{
		return desCuenta;
	}

	public void setDesCuenta(String desCuenta)
	{
		this.desCuenta = desCuenta;
	}

	public String getFecAlta()
	{
		return fecAlta;
	}

	public void setFecAlta(String fecAlta)
	{
		this.fecAlta = fecAlta;
	}

	public String getTipCuenta()
	{
		return tipCuenta;
	}

	public void setTipCuenta(String tipCuenta)
	{
		this.tipCuenta = tipCuenta;
	}

	public Long getCodCuenta()
	{
		return codCuenta;
	}

	public void setCodCuenta(Long codCuenta)
	{
		this.codCuenta = codCuenta;
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
		b.append("<cuenta>");
		b.append("<codCuenta>");
		b.append(getCodCuenta());
		b.append("</codCuenta>");
		b.append("<desCuenta>");
		b.append(getDesCuenta());
		b.append("</desCuenta>");
		b.append("<fecAlta>");
		b.append(getFecAlta());
		b.append("</fecAlta>");
		b.append("<tipCuenta>");
		b.append(getTipCuenta());
		b.append("</tipCuenta>");
		b.append("<fecAltaOrd>");
		b.append(getFecAltaOrd());
		b.append("</fecAltaOrd>");
		b.append("</cuenta>");
		return b.toString();
	}
}
