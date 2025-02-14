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
 * Descripcion: DTO para el uso de registrar las necesidades del cliente.
 * 
 */

public class ResgistroAtencionDTO implements Serializable{

	private static final long serialVersionUID = 1L;

	private String fechaIni; //Fecha y Hora de inicio de la busqueda (Formato base dd/MM/yyyy HH24:mm:ss).
	private String fechaFin; //Fecha y Hora de término de acciones en la busqueda. (cada vez que existe) (Formato base dd/MM/yyyy HH24:mm:ss).
	private String nomUsua; //User Id del ejecutivo que atiende.
	private Long numAbonado; //Código del Cliente.
	private Long codAtencion; //ID del Requerimiento.
	private String Observacion; //Alguna Observación.
	
	public String getFechaIni() {
		return fechaIni;
	}
	public void setFechaIni(String fechaIni) {
		this.fechaIni = fechaIni;
	}
	public String getFechaFin() {
		return fechaFin;
	}
	public void setFechaFin(String fechaFin) {
		this.fechaFin = fechaFin;
	}
	public String getNomUsua() {
		return nomUsua;
	}
	public void setNomUsua(String nomUsua) {
		this.nomUsua = nomUsua;
	}
	public Long getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(Long numAbonado) {
		this.numAbonado = numAbonado;
	}
	public Long getCodAtencion() {
		return codAtencion;
	}
	public void setCodAtencion(Long codAtencion) {
		this.codAtencion = codAtencion;
	}
	public String getObservacion() {
		return Observacion;
	}
	public void setObservacion(String observacion) {
		Observacion = observacion;
	}
	
}
