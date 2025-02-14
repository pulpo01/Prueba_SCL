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

public class AbonadoDTO implements Serializable
{
	private static final long serialVersionUID = 1L;

	private Long numAbonado;

	private Long numCelular;

	private String desSituacion;

	private String fecAlta;

	private String fecBaja;

	private Long numVenta;

	private String codUso;

	private String nomUsuario;

	private Long codCliente;

	private Long codCuenta;
	
	/*
	 * Modificacion
	 * Proyecto: P-MIX-10008 Mejoras al Portal SAC y Evolución Gestor Posventa MIX-10008
	 * Requisito: RSis_010
	 * Caso de uso: CU-017 Registrar consulta de cliente/cuenta/abonado realizado por el usuario
	 * Developer: Gabriel Moraga L.
	 * Fecha: 13/07/2010
	 * 
	 */
	
	private String apellidoPaterno;
	private String apellidoMaterno;

	//Son para el ordenamiento de la tabla
	private String fecAltaOrd;
	private String fecBajaOrd;
	
	public Long getCodCliente()
	{
		return codCliente;
	}

	public void setCodCliente(Long codCliente)
	{
		this.codCliente = codCliente;
	}

	public String getDesSituacion()
	{
		return desSituacion;
	}

	public void setDesSituacion(String desSituacion)
	{
		this.desSituacion = desSituacion;
	}

	public String getFecAlta()
	{
		return fecAlta;
	}

	public void setFecAlta(String fecAlta)
	{
		this.fecAlta = fecAlta;
	}

	public String getFecBaja()
	{
		return fecBaja;
	}

	public void setFecBaja(String fecBaja)
	{
		this.fecBaja = fecBaja;
	}

	public String getNomUsuario()
	{
		return nomUsuario;
	}

	public void setNomUsuario(String nomUsuario)
	{
		this.nomUsuario = nomUsuario;
	}

	public Long getNumAbonado()
	{
		return numAbonado;
	}

	public void setNumAbonado(Long numAbonado)
	{
		this.numAbonado = numAbonado;
	}

	public Long getNumCelular()
	{
		return numCelular;
	}

	public void setNumCelular(Long numCelular)
	{
		this.numCelular = numCelular;
	}

	public Long getNumVenta()
	{
		return numVenta;
	}

	public void setNumVenta(Long numVenta)
	{
		this.numVenta = numVenta;
	}

	public String getCodUso()
	{
		return codUso;
	}

	public void setCodUso(String codUso)
	{
		this.codUso = codUso;
	}

	public Long getCodCuenta()
	{
		return codCuenta;
	}

	public void setCodCuenta(Long codCuenta)
	{
		this.codCuenta = codCuenta;
	}

	public String getApellidoPaterno() {
		return apellidoPaterno;
	}

	public void setApellidoPaterno(String apellidoPaterno) {
		this.apellidoPaterno = apellidoPaterno;
	}

	public String getApellidoMaterno() {
		return apellidoMaterno;
	}

	public void setApellidoMaterno(String apellidoMaterno) {
		this.apellidoMaterno = apellidoMaterno;
	}
	
	public String getFecAltaOrd() {
		return fecAltaOrd;
	}

	public void setFecAltaOrd(String fecAltaOrd) {
		this.fecAltaOrd = fecAltaOrd;
	}

	public String getFecBajaOrd() {
		return fecBajaOrd;
	}

	public void setFecBajaOrd(String fecBajaOrd) {
		this.fecBajaOrd = fecBajaOrd;
	}

	public String toXml()
	{
		StringBuffer b = new StringBuffer();
		b.append("<abonado>");
		b.append("<numAbonado>");
		b.append(getNumAbonado());
		b.append("</numAbonado>");
		b.append("<numCelular>");
		b.append(getNumCelular());
		b.append("</numCelular>");
		b.append("<desSituacion>");
		b.append(getDesSituacion());
		b.append("</desSituacion>");
		b.append("<fecAlta>");
		b.append(getFecAlta());
		b.append("</fecAlta>");
		b.append("<fecBaja>");
		b.append(getFecBaja());
		b.append("</fecBaja>");
		b.append("<numVenta>");
		b.append(getNumVenta());
		b.append("</numVenta>");
		b.append("<codUso>");
		b.append(getCodUso());
		b.append("</codUso>");
		b.append("<nomUsuario>");
		b.append(getNomUsuario());
		b.append("</nomUsuario>");
		b.append("<codCliente>");
		b.append(getCodCliente());
		b.append("</codCliente>");
		b.append("<codCuenta>");
		b.append(getCodCuenta());
		b.append("</codCuenta>");
		b.append("<apellidoPaterno>");
		b.append(getApellidoPaterno());
		b.append("</apellidoPaterno>");
		b.append("<apellidoMaterno>");
		b.append(getApellidoPaterno());
		b.append("</apellidoMaterno>");
		b.append("<fecAltaOrd>");
		b.append(getFecAltaOrd());
		b.append("</fecAltaOrd>");
		b.append("<fecBajaOrd>");
		b.append(getFecBajaOrd());
		b.append("</fecBajaOrd>");
		b.append("</abonado>");
		return b.toString();
	}
}
