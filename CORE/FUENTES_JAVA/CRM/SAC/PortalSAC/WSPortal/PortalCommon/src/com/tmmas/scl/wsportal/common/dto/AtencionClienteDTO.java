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


/*
 * Proyecto: P-MIX-10008 Mejoras al Portal SAC y Evolución Gestor Posventa MIX-10008
 * Requisito: RSis_010
 * Caso de uso: CU-017 Registrar consulta de cliente/cuenta/abonado realizado por el usuario
 * Developer: Gabriel Moraga L.
 * Fecha: 13/07/2010
 * Descripcion: Tabla que registra las necesidades del cliente
 * 
 */

public class AtencionClienteDTO implements Serializable{
	
	private static final long serialVersionUID = 1L;

	private String desAtencion; //Nombre de la Atención
	private Long grpAtencion; //Codigo del Grupo al que pertenece
	private Long numNivel; //Número del nivel al que pertenece la atención
	private Long codAtencion; //Código de la Descripción de la Atención
	private String indObserv; //OBLIGATORIEDAD DE LA OBSERVACIÓN (S,N)
	
	public String getDesAtencion() {
		return desAtencion;
	}
	public void setDesAtencion(String desAtencion) {
		this.desAtencion = desAtencion;
	}
	public Long getGrpAtencion() {
		return grpAtencion;
	}
	public void setGrpAtencion(Long grpAtencion) {
		this.grpAtencion = grpAtencion;
	}
	public Long getNumNivel() {
		return numNivel;
	}
	public void setNumNivel(Long numNivel) {
		this.numNivel = numNivel;
	}
	public Long getCodAtencion() {
		return codAtencion;
	}
	public void setCodAtencion(Long codAtencion) {
		this.codAtencion = codAtencion;
	}
	public String getIndObserv() {
		return indObserv;
	}
	public void setIndObserv(String indObserv) {
		this.indObserv = indObserv;
	}

}
