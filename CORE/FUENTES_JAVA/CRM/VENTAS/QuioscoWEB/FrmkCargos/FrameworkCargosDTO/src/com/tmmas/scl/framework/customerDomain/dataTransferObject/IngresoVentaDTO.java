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
 * 10/09/2007     			 Elizabeth Vera              		Versión Inicial
 */
package com.tmmas.scl.framework.customerDomain.dataTransferObject;

import java.io.Serializable;
import java.util.Date;

public class IngresoVentaDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private long numVenta;
	private int codProducto;
	private String codOficina;
	private String codTipComis;
	private int codVendedor;
	private int codVendedorAgente;
	private int numUnidades;
	private Date fecVenta;
	private String codRegion;
	private String codProvincia;
	private String codCiudad;
	private String indEstVenta;
	private int indPasoCob;
	private int indTipVenta;
	private long codCliente;
	private int codModVenta;
	private String codCuota;
    private String nomUsuarioVenta;
    private String indVenta;
    private String tipFoliacion;
    private int codTipDocumento;
    private String codPlaza;
    private String codOperadora;
    
	public String getCodCiudad() {
		return codCiudad;
	}
	public void setCodCiudad(String codCiudad) {
		this.codCiudad = codCiudad;
	}
	public long getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(long codCliente) {
		this.codCliente = codCliente;
	}
	public String getCodCuota() {
		return codCuota;
	}
	public void setCodCuota(String codCuota) {
		this.codCuota = codCuota;
	}
	public int getCodModVenta() {
		return codModVenta;
	}
	public void setCodModVenta(int codModVenta) {
		this.codModVenta = codModVenta;
	}
	public String getCodOficina() {
		return codOficina;
	}
	public void setCodOficina(String codOficina) {
		this.codOficina = codOficina;
	}
	public String getCodOperadora() {
		return codOperadora;
	}
	public void setCodOperadora(String codOperadora) {
		this.codOperadora = codOperadora;
	}
	public String getCodPlaza() {
		return codPlaza;
	}
	public void setCodPlaza(String codPlaza) {
		this.codPlaza = codPlaza;
	}
	public int getCodProducto() {
		return codProducto;
	}
	public void setCodProducto(int codProducto) {
		this.codProducto = codProducto;
	}
	public String getCodProvincia() {
		return codProvincia;
	}
	public void setCodProvincia(String codProvincia) {
		this.codProvincia = codProvincia;
	}
	public String getCodRegion() {
		return codRegion;
	}
	public void setCodRegion(String codRegion) {
		this.codRegion = codRegion;
	}
	public String getCodTipComis() {
		return codTipComis;
	}
	public void setCodTipComis(String codTipComis) {
		this.codTipComis = codTipComis;
	}
	public int getCodTipDocumento() {
		return codTipDocumento;
	}
	public void setCodTipDocumento(int codTipDocumento) {
		this.codTipDocumento = codTipDocumento;
	}
	public int getCodVendedor() {
		return codVendedor;
	}
	public void setCodVendedor(int codVendedor) {
		this.codVendedor = codVendedor;
	}
	public int getCodVendedorAgente() {
		return codVendedorAgente;
	}
	public void setCodVendedorAgente(int codVendedorAgente) {
		this.codVendedorAgente = codVendedorAgente;
	}
	public Date getFecVenta() {
		return fecVenta;
	}
	public void setFecVenta(Date fecVenta) {
		this.fecVenta = fecVenta;
	}
	public String getIndEstVenta() {
		return indEstVenta;
	}
	public void setIndEstVenta(String indEstVenta) {
		this.indEstVenta = indEstVenta;
	}
	public int getIndPasoCob() {
		return indPasoCob;
	}
	public void setIndPasoCob(int indPasoCob) {
		this.indPasoCob = indPasoCob;
	}
	public int getIndTipVenta() {
		return indTipVenta;
	}
	public void setIndTipVenta(int indTipVenta) {
		this.indTipVenta = indTipVenta;
	}
	public String getIndVenta() {
		return indVenta;
	}
	public void setIndVenta(String indVenta) {
		this.indVenta = indVenta;
	}
	public String getNomUsuarioVenta() {
		return nomUsuarioVenta;
	}
	public void setNomUsuarioVenta(String nomUsuarioVenta) {
		this.nomUsuarioVenta = nomUsuarioVenta;
	}
	public int getNumUnidades() {
		return numUnidades;
	}
	public void setNumUnidades(int numUnidades) {
		this.numUnidades = numUnidades;
	}
	public long getNumVenta() {
		return numVenta;
	}
	public void setNumVenta(long numVenta) {
		this.numVenta = numVenta;
	}
	public String getTipFoliacion() {
		return tipFoliacion;
	}
	public void setTipFoliacion(String tipFoliacion) {
		this.tipFoliacion = tipFoliacion;
	}
    

}
