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
 * Descripcion: para el registro de los resultados de transaccion.
 * 
 */

public class ResulTransaccionDTO implements Serializable{
	
	private static final long serialVersionUID = 1L;

	private Long codRetorno;
	private String MenRetorno;
	private Long NumEvento;
	
	public Long getCodRetorno() {
		return codRetorno;
	}
	public void setCodRetorno(Long codRetorno) {
		this.codRetorno = codRetorno;
	}
	public String getMenRetorno() {
		return MenRetorno;
	}
	public void setMenRetorno(String menRetorno) {
		MenRetorno = menRetorno;
	}
	public Long getNumEvento() {
		return NumEvento;
	}
	public void setNumEvento(Long numEvento) {
		NumEvento = numEvento;
	}
	
	
	
}
