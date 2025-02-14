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

/**
 * @author mwn40031
 *
 */
public class EntidadParametroDTO implements Serializable
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 2046143068669273901L;

	private String tipEntidad;

	public EntidadParametroDTO()
	{
	}

	public EntidadParametroDTO(String tipEntidad, String valEntidad)
	{
		this.tipEntidad = tipEntidad;
		this.valEntidad = valEntidad;
	}

	public EntidadParametroDTO(String tipEntidad, Long valEntidad)
	{
		this.tipEntidad = tipEntidad;
		this.valEntidad = valEntidad.toString();
	}

	public EntidadParametroDTO(String tipEntidad, Object valEntidad)
	{
		this.tipEntidad = tipEntidad;
		this.valEntidad = valEntidad.toString();
	}

	//	public static final String COD_TIP_DIRECCION = "codTipDireccion";

	//	public static final String COD_DIRECCION = "codDireccion";

	public static final String NUM_ABONADO = "numAbonado";

	//	public static final String NUM_CELULAR = "numCelular";

	//	public static final String DESC_CUENTA = "descCuenta";

	//	public static final String NUM_IDENT = "numIdent";

	public static final String COD_CUENTA = "codCuenta";

	//	public static final String NOMBRE = "nombre";

	public static final String COD_CLIENTE = "codCliente";

	public static final String TIPO_ABONO = "tipoAbono";

	public static final String COD_SUJETO = "codSujeto";

	public static final String TIPO_OOSS = "tipoOOSS";

	private String valEntidad;

	public void setValEntidad(String valEntidad)
	{
		this.valEntidad = valEntidad;
	}

	public String getValEntidad()
	{
		return valEntidad;
	}

	public void setTipEntidad(String tipEntidad)
	{
		this.tipEntidad = tipEntidad;
	}

	public String getTipEntidad()
	{
		return tipEntidad;
	}
}
