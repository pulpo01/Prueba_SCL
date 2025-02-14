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
 * 03/09/2007     			 Cristian Toledo              		Versión Inicial
 */
package com.tmmas.scl.framework.productDomain.dataTransferObject;

import java.io.Serializable;

public abstract class CartaGeneralDTO implements Serializable{
	private String codOOSS;
	private String texCarta;
	
	public String getNombreStruct(){return null;};
	public Object [] toStruct(){return null;};
	
	public String getCodOOSS() {
		return codOOSS;
	}
	public void setCodOOSS(String codOOSS) {
		this.codOOSS = codOOSS;
	}
	
	 public String getTexCarta() {
			return texCarta;
		}
	 public void setTexCarta(String texCarta) {
			this.texCarta = texCarta;
		}
}
