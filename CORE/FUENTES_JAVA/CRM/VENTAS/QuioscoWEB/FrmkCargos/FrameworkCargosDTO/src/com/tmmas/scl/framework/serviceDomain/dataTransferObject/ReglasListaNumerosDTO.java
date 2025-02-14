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
 * 10-07-2007     			 Cristian Toledo              		Versión Inicial
 */
package com.tmmas.scl.framework.serviceDomain.dataTransferObject;

import java.io.Serializable;

public class ReglasListaNumerosDTO implements Serializable
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String codPerfilLista;
	private String codCategoriaDestino;
	private String tipoPlataforma;
	private String cantidadMaxima;
	private String tipoLista;
	
	/**
	 *   COD_PERFIL_LISTA NUMBER(8),
  		 NOM_PERFIL VARCHAR2(15),
  		 DES_PERFIL VARCHAR2(30),
  		 IND_TIP_PLATAFORMA CHAR,
  		 FEC_INI_VIG VARCHAR2(255),
  		 FEC_TER_VIG VARCHAR2(255),
  		 NUM_MAXIMO_LISTA VARCHAR2(255),
  		 IND_TIP_COMPORTA CHAR,
  		 FLG_AUTO_AFIN CHAR
	 * 
	 */
	
	public String getCantidadMaxima() {
		return cantidadMaxima;
	}
	public void setCantidadMaxima(String cantidadMaxima) {
		this.cantidadMaxima = cantidadMaxima;
	}
	public String getCodCategoriaDestino() {
		return codCategoriaDestino;
	}
	public void setCodCategoriaDestino(String codCategoriaDestino) {
		this.codCategoriaDestino = codCategoriaDestino;
	}
	public String getCodPerfilLista() {
		return codPerfilLista;
	}
	public void setCodPerfilLista(String codPerfilLista) {
		this.codPerfilLista = codPerfilLista;
	}
	public String getTipoLista() {
		return tipoLista;
	}
	public void setTipoLista(String tipoLista) {
		this.tipoLista = tipoLista;
	}
	public String getTipoPlataforma() {
		return tipoPlataforma;
	}
	public void setTipoPlataforma(String tipoPlataforma) {
		this.tipoPlataforma = tipoPlataforma;
	}
}
