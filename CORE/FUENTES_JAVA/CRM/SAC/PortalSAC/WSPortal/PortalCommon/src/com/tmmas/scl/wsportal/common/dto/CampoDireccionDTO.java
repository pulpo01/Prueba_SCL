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

public class CampoDireccionDTO implements Serializable
{

	private static final long serialVersionUID = 1L;

	private String codParamDir;

	private String tipDat;

	private String secDat;

	private String caption;

	private String orden;

	private String largo;

	private String indObligatorio;


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

	public String getCaption() {
		return caption;
	}

	public void setCaption(String caption) {
		this.caption = caption;
	}

	public String getOrden() {
		return orden;
	}

	public void setOrden(String orden) {
		this.orden = orden;
	}

	public String getLargo() {
		return largo;
	}

	public void setLargo(String largo) {
		this.largo = largo;
	}

	public String getIndObligatorio() {
		return indObligatorio;
	}

	public void setIndObligatorio(String indObligatorio) {
		this.indObligatorio = indObligatorio;
	}
	

}
