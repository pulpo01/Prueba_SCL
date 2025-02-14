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
 * Descripcion: contiene un AtencionClienteDTO[] y los estado de ejecucion
 * 
 */

public class ListaAtencionClienteDTO implements Serializable{
	
	private static final long serialVersionUID = 1L;

	private AtencionClienteDTO[] arrayAtencionCliente; //Arreglo atencion cliente
	private String codError;
	private String desError;
	
	public AtencionClienteDTO[] getArrayAtencionCliente() {
		return arrayAtencionCliente;
	}
	public void setArrayAtencionCliente(AtencionClienteDTO[] arrayAtencionCliente) {
		this.arrayAtencionCliente = arrayAtencionCliente;
	}
	public String getCodError() {
		return codError;
	}
	public void setCodError(String codError) {
		this.codError = codError;
	}
	public String getDesError() {
		return desError;
	}
	public void setDesError(String desError) {
		this.desError = desError;
	}
	
}
