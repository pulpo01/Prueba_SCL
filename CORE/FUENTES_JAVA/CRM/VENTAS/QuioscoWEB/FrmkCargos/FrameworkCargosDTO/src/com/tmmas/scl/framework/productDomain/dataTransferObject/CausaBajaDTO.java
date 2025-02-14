/**
 * Copyright © 2006 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 11/08/2007     			 Elizabeth Vera              		Versión Inicial
 */
package com.tmmas.scl.framework.productDomain.dataTransferObject;

import java.io.Serializable;

public class CausaBajaDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private String codCausaBaja;
	private String desCausaBaja;
	private int indLn;
	private int indCobro;
	private int indPortable;
	
	public String getCodCausaBaja() {
		return codCausaBaja;
	}
	public void setCodCausaBaja(String codCausaBaja) {
		this.codCausaBaja = codCausaBaja;
	}
	public String getDesCausaBaja() {
		return desCausaBaja;
	}
	public void setDesCausaBaja(String desCausaBaja) {
		this.desCausaBaja = desCausaBaja;
	}
	public int getIndCobro() {
		return indCobro;
	}
	public void setIndCobro(int indCobro) {
		this.indCobro = indCobro;
	}
	public int getIndLn() {
		return indLn;
	}
	public void setIndLn(int indLn) {
		this.indLn = indLn;
	}
	public int getIndPortable() {
		return indPortable;
	}
	public void setIndPortable(int indPortable) {
		this.indPortable = indPortable;
	}
	
}
