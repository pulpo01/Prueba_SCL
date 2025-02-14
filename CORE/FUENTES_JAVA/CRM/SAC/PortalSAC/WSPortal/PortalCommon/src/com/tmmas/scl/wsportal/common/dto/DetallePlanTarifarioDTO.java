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

public class DetallePlanTarifarioDTO implements Serializable
{

	private static final long serialVersionUID = 2363782326854536044L;

	String codPlanTarifario;

	String desPlanTarifario;

	String codCargoBasico;

	String codLimiteConsumo;

	Double impLimiteConsumo;

	private String codError;

	private String desError;

	/**
	 * @return the codCargoBasico
	 */
	public String getCodCargoBasico()
	{
		return codCargoBasico;
	}

	/**
	 * @return the codLimiteConsumo
	 */
	public String getCodLimiteConsumo()
	{
		return codLimiteConsumo;
	}

	/**
	 * @return the codPlanTarifario
	 */
	public String getCodPlanTarifario()
	{
		return codPlanTarifario;
	}

	/**
	 * @return the desPlanTarifario
	 */
	public String getDesPlanTarifario()
	{
		return desPlanTarifario;
	}

	/**
	 * @return the impLimiteConsumo
	 */
	public Double getImpLimiteConsumo()
	{
		return impLimiteConsumo;
	}

	/**
	 * @param codCargoBasico the codCargoBasico to set
	 */
	public void setCodCargoBasico(String codCargoBasico)
	{
		this.codCargoBasico = codCargoBasico;
	}

	/**
	 * @param codLimiteConsumo the codLimiteConsumo to set
	 */
	public void setCodLimiteConsumo(String codLimiteConsumo)
	{
		this.codLimiteConsumo = codLimiteConsumo;
	}

	/**
	 * @param codPlanTarifario the codPlanTarifario to set
	 */
	public void setCodPlanTarifario(String codPlanTarifario)
	{
		this.codPlanTarifario = codPlanTarifario;
	}

	/**
	 * @param desPlanTarifario the desPlanTarifario to set
	 */
	public void setDesPlanTarifario(String desPlanTarifario)
	{
		this.desPlanTarifario = desPlanTarifario;
	}

	/**
	 * @param impLimiteConsumo the impLimiteConsumo to set
	 */
	public void setImpLimiteConsumo(Double impLimiteConsumo)
	{
		this.impLimiteConsumo = impLimiteConsumo;
	}

	/**
	 * @return the codError
	 */
	public String getCodError()
	{
		return codError;
	}

	/**
	 * @param codError the codError to set
	 */
	public void setCodError(String codError)
	{
		this.codError = codError;
	}

	/**
	 * @return the desError
	 */
	public String getDesError()
	{
		return desError;
	}

	/**
	 * @param desError the desError to set
	 */
	public void setDesError(String desError)
	{
		this.desError = desError;
	}
}
