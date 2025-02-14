/**
 * Copyright © 2007 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 14/02/2007     Héctor Hermosilla             			Versión Inicial
 */
package com.tmmas.cl.scl.ventas.service.helper;

import java.io.Serializable;

import com.tmmas.cl.framework.util.MessageResourcesConfig;

public class Global implements Serializable{
	private static final long serialVersionUID = 1L;

	private MessageResourcesConfig recurso;

	private static Global instance;

	private final String archivoRecurso = "com.tmmas.cl.scl.ventas.service.properties.servicios";

	// --------------------------------------------------------------------------
	private Global() {
		this.recurso = new MessageResourcesConfig(archivoRecurso);
	}
	// --------------------------------------------------------------------------
	public static synchronized Global getInstance() {
		if (instance == null) {
			instance = new Global();
		}
		return instance;
	}
	public MessageResourcesConfig getMessageResourcesConfig() {
		return this.recurso;
	}
	public String getValor(String valorClave) {
		String valor = this.recurso.obtenerValorClave(valorClave);
		return valor;
	}	
	
	public String getNoExiste(){
		return this.recurso.obtenerValorClave("no.existe");
	}
	public int getValorVerdadero(){
		return Integer.parseInt(this.recurso.obtenerValorClave("valor.verdadero"));
	}
}
