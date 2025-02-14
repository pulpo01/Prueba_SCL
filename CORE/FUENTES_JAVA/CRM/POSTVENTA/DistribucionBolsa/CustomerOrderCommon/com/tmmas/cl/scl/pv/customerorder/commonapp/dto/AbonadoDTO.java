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
 * 06/08/2006     Jimmy Lopez              					Versión Inicial
 */
package com.tmmas.cl.scl.pv.customerorder.commonapp.dto;

import java.io.Serializable;

public class AbonadoDTO implements Serializable{
	private static final long serialVersionUID = 1L;
	
	private long num_abonado = 0;
	private long num_celular;
	private String cod_planTarif;
	private String des_planTarif;
	
	public String getCod_planTarif() {
		return cod_planTarif;
	}
	public void setCod_planTarif(String cod_planTarif) {
		this.cod_planTarif = cod_planTarif;
	}
	public String getDes_planTarif() {
		return des_planTarif;
	}
	public void setDes_planTarif(String des_planTarif) {
		this.des_planTarif = des_planTarif;
	}
	public long getNum_abonado() {
		return num_abonado;
	}
	public void setNum_abonado(long num_abonado) {
		this.num_abonado = num_abonado;
	}
	public long getNum_celular() {
		return num_celular;
	}
	public void setNum_celular(long num_celular) {
		this.num_celular = num_celular;
	}

}
