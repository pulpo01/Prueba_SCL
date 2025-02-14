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
 * 04/04/2007     Héctor Hermosilla      					Versión Inicial
 */

package com.tmmas.cl.scl.crmcommon.commonapp.dto;

import java.io.Serializable;

public class ImpuestosDTO implements Serializable{

	private static final long serialVersionUID = 1L;
	private double totalCargos;
	private double totalDescuentos;
	private double totalImpuestos;
	private String numeroProceso;
	private long codigoConcepto;
	
	private long codigoCliente;
	private String codOficina;
	private double montoDsctoManual;
	private String categoriaTributaria;
	private String esVentaRegalo;  //S - N
	
	
	public String getEsVentaRegalo() {
		return esVentaRegalo;
	}
	public void setEsVentaRegalo(String esVentaRegalo) {
		this.esVentaRegalo = esVentaRegalo;
	}
	public String getCategoriaTributaria() {
		return categoriaTributaria;
	}
	public void setCategoriaTributaria(String categoriaTributaria) {
		this.categoriaTributaria = categoriaTributaria;
	}
	public long getCodigoCliente() {
		return codigoCliente;
	}
	public void setCodigoCliente(long codigoCliente) {
		this.codigoCliente = codigoCliente;
	}
	public String getCodOficina() {
		return codOficina;
	}
	public void setCodOficina(String codOficina) {
		this.codOficina = codOficina;
	}
	public double getMontoDsctoManual() {
		return montoDsctoManual;
	}
	public void setMontoDsctoManual(double montoDsctoManual) {
		this.montoDsctoManual = montoDsctoManual;
	}	
	public String getNumeroProceso() {
		return numeroProceso;
	}
	public void setNumeroProceso(String numeroProceso) {
		this.numeroProceso = numeroProceso;
	}	
	public double getTotalDescuentos() {
		return totalDescuentos;
	}
	public void setTotalDescuentos(double totalDescuentos) {
		this.totalDescuentos = totalDescuentos;
	}
	public double getTotalImpuestos() {
		return totalImpuestos;
	}
	public void setTotalImpuestos(double totalImpuestos) {
		this.totalImpuestos = totalImpuestos;
	}
	public double getTotalCargos() {
		return totalCargos;
	}
	public void setTotalCargos(double totalCargos) {
		this.totalCargos = totalCargos;
	}
	public long getCodigoConcepto() {
		return codigoConcepto;
	}
	public void setCodigoConcepto(long codigoConcepto) {
		this.codigoConcepto = codigoConcepto;
	}	
	

}
