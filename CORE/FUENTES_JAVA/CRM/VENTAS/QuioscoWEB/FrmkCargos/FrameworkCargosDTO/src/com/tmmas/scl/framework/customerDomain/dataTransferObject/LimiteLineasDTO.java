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
 * 20/11/2007     			 Cristian Toledo              		Versión Inicial
 */
package com.tmmas.scl.framework.customerDomain.dataTransferObject;

import java.io.Serializable;

public class LimiteLineasDTO implements Serializable{
	private static final long serialVersionUID = 1L;
	private String superaLimite;
	private String numeroLineasCliente;
	private String maximoPermitido;
	public String getMaximoPermitido() {
		return maximoPermitido;
	}
	public void setMaximoPermitido(String maximoPermitido) {
		this.maximoPermitido = maximoPermitido;
	}
	public String getNumeroLineasCliente() {
		return numeroLineasCliente;
	}
	public void setNumeroLineasCliente(String numeroLineasCliente) {
		this.numeroLineasCliente = numeroLineasCliente;
	}
	public String getSuperaLimite() {
		return superaLimite;
	}
	public void setSuperaLimite(String superaLimite) {
		this.superaLimite = superaLimite;
	}
	
	
}
