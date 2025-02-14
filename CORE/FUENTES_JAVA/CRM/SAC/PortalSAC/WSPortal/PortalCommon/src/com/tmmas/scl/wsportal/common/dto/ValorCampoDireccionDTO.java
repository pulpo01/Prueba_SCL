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

public class ValorCampoDireccionDTO implements Serializable
{

	private static final long serialVersionUID = 1L;

	private String codParamDir;

	private String tipDat;

	private String secDat;

	private String codValor;

	private String desValor;

	

	public String getCodParamDir() {
		return codParamDir;
	}

	public void setCodParamDir(String codParamDir) {
		this.codParamDir = codParamDir;
	}

	public String getTipDat() {
		return tipDat;
	}

	public void setTipDat(String tipDat) {
		this.tipDat = tipDat;
	}

	public String getSecDat() {
		return secDat;
	}

	public void setSecDat(String secDat) {
		this.secDat = secDat;
	}

	public String getCodValor() {
		return codValor;
	}

	public void setCodValor(String codValor) {
		this.codValor = codValor;
	}

	public String getDesValor() {
		return desValor;
	}

	public void setDesValor(String desValor) {
		this.desValor = desValor;
	}

}
