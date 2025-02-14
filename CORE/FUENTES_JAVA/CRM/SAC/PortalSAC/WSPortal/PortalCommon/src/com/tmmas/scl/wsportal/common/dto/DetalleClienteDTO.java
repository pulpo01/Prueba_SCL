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

public class DetalleClienteDTO implements Serializable
{

	private static final long serialVersionUID = 1L;

	private Long codCliente;

	private String nomCliente;

	private String desTipIndet;

	private String numIdent;

	private String tipPersona;

	private String desCategoria;

	private Long codCiclo;

	private String codCatribut;

	private String fecAlta;

	private String fecAceptVenta;

	private String fecBaja;

	private Long telCliente1;

	private String email;

	private int codCatImpositiva;

	private String desCatImpositiva;

	private int esDealer;

	private long ingresoSalarial;

	private String codError;

	private String desError;

	/*
	 * Modificacion
	 * Proyecto: P-MIX-10008 Mejoras al Portal SAC y Evolución Gestor Posventa MIX-10008
	 * Requisito: RSis_007
	 * Caso de uso: CU-013 Modificar Información General de Cliente
	 * Developer: Jorge González N.
	 * Fecha: 13/07/2010
	 * 
	 */
	
	private String indDebito;
	private String numTarjeta;
	private String FecVenciTarj;
	
	
	public String getCodError()
	{
		return codError;
	}

	public void setCodError(String codError)
	{
		this.codError = codError;
	}

	public String getDesError()
	{
		return desError;
	}

	public void setDesError(String desError)
	{
		this.desError = desError;
	}

	public String getFecAlta()
	{
		return fecAlta;
	}

	public void setFecAlta(String fecAlta)
	{
		this.fecAlta = fecAlta;
	}

	public Long getCodCliente()
	{
		return codCliente;
	}

	public void setCodCliente(Long codCliente)
	{
		this.codCliente = codCliente;
	}

	public String getNomCliente()
	{
		return nomCliente;
	}

	public void setNomCliente(String nomCliente)
	{
		this.nomCliente = nomCliente;
	}

	public String getTipPersona()
	{
		return tipPersona;
	}

	public void setTipPersona(String tipPersona)
	{
		this.tipPersona = tipPersona;
	}

	public String getCodCatribut()
	{
		return codCatribut;
	}

	public void setCodCatribut(String codCatribut)
	{
		this.codCatribut = codCatribut;
	}

	public Long getCodCiclo()
	{
		return codCiclo;
	}

	public void setCodCiclo(Long codCiclo)
	{
		this.codCiclo = codCiclo;
	}

	public String getDesCategoria()
	{
		return desCategoria;
	}

	public void setDesCategoria(String desCategoria)
	{
		this.desCategoria = desCategoria;
	}

	public String getDesTipIndet()
	{
		return desTipIndet;
	}

	public void setDesTipIndet(String desTipIndet)
	{
		this.desTipIndet = desTipIndet;
	}

	public String getFecAceptVenta()
	{
		return fecAceptVenta;
	}

	public void setFecAceptVenta(String fecAceptVenta)
	{
		this.fecAceptVenta = fecAceptVenta;
	}

	public String getFecBaja()
	{
		return fecBaja;
	}

	public void setFecBaja(String fecBaja)
	{
		this.fecBaja = fecBaja;
	}

	public String getNumIdent()
	{
		return numIdent;
	}

	public void setNumIdent(String numIdent)
	{
		this.numIdent = numIdent;
	}

	public Long getTelCliente1()
	{
		return telCliente1;
	}

	public void setTelCliente1(Long telCliente1)
	{
		this.telCliente1 = telCliente1;
	}

	public String getEmail()
	{
		return email;
	}

	public void setEmail(String email)
	{
		this.email = email;
	}

	public void setCodCatImpositiva(int codCatImpositiva)
	{
		this.codCatImpositiva = codCatImpositiva;
	}

	public int getCodCatImpositiva()
	{
		return codCatImpositiva;
	}

	public void setDesCatImpositiva(String desCatImpositiva)
	{
		this.desCatImpositiva = desCatImpositiva;
	}

	public String getDesCatImpositiva()
	{
		return desCatImpositiva;
	}

	public void setEsDealer(int esDealer)
	{
		this.esDealer = esDealer;
	}

	public int getEsDealer()
	{
		return esDealer;
	}

	public void setIngresoSalarial(long ingresoSalarial)
	{
		this.ingresoSalarial = ingresoSalarial;
	}

	public long getIngresoSalarial()
	{
		return ingresoSalarial;
	}

	public String getIndDebito() {
		return indDebito;
	}

	public void setIndDebito(String indDebito) {
		this.indDebito = indDebito;
	}

	public String getNumTarjeta() {
		return numTarjeta;
	}

	public void setNumTarjeta(String numTarjeta) {
		this.numTarjeta = numTarjeta;
	}

	public String getFecVenciTarj() {
		return FecVenciTarj;
	}

	public void setFecVenciTarj(String fecVenciTarj) {
		this.FecVenciTarj = fecVenciTarj;
	}

}
