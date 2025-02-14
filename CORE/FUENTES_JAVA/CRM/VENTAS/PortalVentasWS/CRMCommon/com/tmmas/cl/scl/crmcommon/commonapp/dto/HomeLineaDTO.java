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
 * 20/03/2007     Héctor Hermosilla     					Versión Inicial
 */
package com.tmmas.cl.scl.crmcommon.commonapp.dto;

import java.io.Serializable;

public class HomeLineaDTO implements Serializable{
	private static final long serialVersionUID = 1L;
	
	private String num_icc;
	private String cod_subAlm;
	private Long cod_central;
	private String cod_hlr;
	private String cod_celda;
	private Long num_celular;
	private String cod_region;
	private String cod_provincia;
	private String cod_ciudad;
	private Long cod_vendedor;
	private int  cod_uso;
	private String  cod_actabo;
	private String  cod_planTarif;
	
	public String getCod_planTarif() {
		return cod_planTarif;
	}
	public void setCod_planTarif(String cod_planTarif) {
		this.cod_planTarif = cod_planTarif;
	}
	public String getCod_actabo() {
		return cod_actabo;
	}
	public void setCod_actabo(String cod_actabo) {
		this.cod_actabo = cod_actabo;
	}
	public String getCod_celda() {
		return cod_celda;
	}
	public void setCod_celda(String cod_celda) {
		this.cod_celda = cod_celda;
	}
	public Long getCod_central() {
		return cod_central;
	}
	public void setCod_central(Long cod_central) {
		this.cod_central = cod_central;
	}
	public String getCod_ciudad() {
		return cod_ciudad;
	}
	public void setCod_ciudad(String cod_ciudad) {
		this.cod_ciudad = cod_ciudad;
	}
	public String getCod_hlr() {
		return cod_hlr;
	}
	public void setCod_hlr(String cod_hlr) {
		this.cod_hlr = cod_hlr;
	}
	public String getCod_provincia() {
		return cod_provincia;
	}
	public void setCod_provincia(String cod_provincia) {
		this.cod_provincia = cod_provincia;
	}
	public String getCod_region() {
		return cod_region;
	}
	public void setCod_region(String cod_region) {
		this.cod_region = cod_region;
	}
	public String getCod_subAlm() {
		return cod_subAlm;
	}
	public void setCod_subAlm(String cod_subAlm) {
		this.cod_subAlm = cod_subAlm;
	}	
	public Long getCod_vendedor() {
		return cod_vendedor;
	}
	public void setCod_vendedor(Long cod_vendedor) {
		this.cod_vendedor = cod_vendedor;
	}
	public Long getNum_celular() {
		return num_celular;
	}
	public void setNum_celular(Long num_celular) {
		this.num_celular = num_celular;
	}
	public String getNum_icc() {
		return num_icc;
	}
	public void setNum_icc(String num_icc) {
		this.num_icc = num_icc;
	}
	public int getCod_uso() {
		return cod_uso;
	}
	public void setCod_uso(int cod_uso) {
		this.cod_uso = cod_uso;
	}
		
}
