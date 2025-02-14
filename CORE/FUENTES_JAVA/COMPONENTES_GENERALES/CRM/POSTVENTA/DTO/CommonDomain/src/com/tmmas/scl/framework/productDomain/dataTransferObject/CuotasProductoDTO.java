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
package com.tmmas.scl.framework.productDomain.dataTransferObject;

import java.io.Serializable;

public class CuotasProductoDTO implements Serializable
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String cod_cuota;
	private String des_cuota; 
	private int num_cuotas;
	private int defual_cuota;
	
	
	public String getCod_cuota() {
		return cod_cuota;
	}
	public void setCod_cuota(String cod_cuota) {
		this.cod_cuota = cod_cuota;
	}
	public int getDefual_cuota() {
		return defual_cuota;
	}
	public void setDefual_cuota(int defual_cuota) {
		this.defual_cuota = defual_cuota;
	}
	public String getDes_cuota() {
		return des_cuota;
	}
	public void setDes_cuota(String des_cuota) {
		this.des_cuota = des_cuota;
	}
	public int getNum_cuotas() {
		return num_cuotas;
	}
	public void setNum_cuotas(int num_cuotas) {
		this.num_cuotas = num_cuotas;
	}	
					
}
