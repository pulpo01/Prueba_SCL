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
 * 09/01/2007     Héctor Hermosilla      					Versión Inicial
 */
package com.tmmas.cl.scl.gestiondeabonados.businessobject.dto;

import java.io.Serializable;

public class CampanaVigenteDTO  implements Serializable{
	
	
	private static final long serialVersionUID = 1L;
	private String codigoCampanasVigentes;
	private String descripcionCampanasVigentes;
	private long codigoCliente;
	private long numeroAbonado;
	private String aplicaA;
		
	public String getAplicaA() {
		return aplicaA;
	}
	public void setAplicaA(String aplicaA) {
		this.aplicaA = aplicaA;
	}
	public long getNumeroAbonado() {
		return numeroAbonado;
	}
	public void setNumeroAbonado(long numeroAbonado) {
		this.numeroAbonado = numeroAbonado;
	}
	public long getCodigoCliente() {
		return codigoCliente;
	}
	public void setCodigoCliente(long codigoCliente) {
		this.codigoCliente = codigoCliente;
	}
	public String getCodigoCampanasVigentes(){
		return codigoCampanasVigentes;
	}
	public void setCodigoCampanasVigentes(String codigoCampanasVigentes){
		this.codigoCampanasVigentes = codigoCampanasVigentes;
	}
	public String getDescripcionCampanasVigentes(){
		return descripcionCampanasVigentes;
	}
	
	public void setDescripcionCampanasVigentes(String descripcionCampanasVigentes){
		this.descripcionCampanasVigentes = descripcionCampanasVigentes;
	}
		

	
}
