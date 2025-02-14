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

public class LimiteConsumoDTO implements Serializable
{

	private static final long serialVersionUID = 1L;

	private String codLimCons;

	private String descripcion;

	private String codUmbralMin;

	private String desUmbral;

	private Double acuConsumo;

	public Double getAcuConsumo()
	{
		return acuConsumo;
	}

	public void setAcuConsumo(Double acuConsumo)
	{
		this.acuConsumo = acuConsumo;
	}

	public String getCodLimCons()
	{
		return codLimCons;
	}

	public void setCodLimCons(String codLimCons)
	{
		this.codLimCons = codLimCons;
	}

	public String getCodUmbralMin()
	{
		return codUmbralMin;
	}

	public void setCodUmbralMin(String codUmbralMin)
	{
		this.codUmbralMin = codUmbralMin;
	}

	public String getDescripcion()
	{
		return descripcion;
	}

	public void setDescripcion(String descripcion)
	{
		this.descripcion = descripcion;
	}

	public String getDesUmbral()
	{
		return desUmbral;
	}

	public void setDesUmbral(String desUmbral)
	{
		this.desUmbral = desUmbral;
	}

}
