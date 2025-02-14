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
 * 16/03/2007     H&eacute;ctor Hermosilla				Versión Inicial
 */

package com.tmmas.cl.scl.customerdomain.businessobject.dto;

import java.io.Serializable;

public class UsuarioSCLDTO implements Serializable{
	private static final long serialVersionUID = 1L;
	private String usuario;
	private String clave;
	private boolean resultadoValidacion;
	private String mensajeValidacion;
	private String motivoError;
	private int contadorConexionFallida;
	private long codigoVendedor;
	private String codigoOficina;
	private String host;
	private String puerto;
	private String basedeDatos;
	private String codigoPrograma;
	private String codigoProceso;
	private String codigoOpcion;
	private String codTipcomis;
	private String nombreUsuario;
	
	private long numVersion;	
	private MenuUsuarioSCLDTO[] arrayMenuUsuario;
	
	public MenuUsuarioSCLDTO[] getArrayMenuUsuario() {
		return arrayMenuUsuario;
	}
	public void setArrayMenuUsuario(MenuUsuarioSCLDTO[] arrayMenuUsuario) {
		this.arrayMenuUsuario = arrayMenuUsuario;
	}
	public String getNombreUsuario() {
		return nombreUsuario;
	}
	public void setNombreUsuario(String nombreUsuario) {
		this.nombreUsuario = nombreUsuario;
	}
	public String getCodTipcomis() {
		return codTipcomis;
	}
	public void setCodTipcomis(String codTipcomis) {
		this.codTipcomis = codTipcomis;
	}
	public String getCodigoOpcion() {
		return codigoOpcion;
	}
	public void setCodigoOpcion(String codigoOpcion) {
		this.codigoOpcion = codigoOpcion;
	}
	public String getCodigoPrograma() {
		return codigoPrograma;
	}
	public void setCodigoPrograma(String codigoPrograma) {
		this.codigoPrograma = codigoPrograma;
	}
	
	public String getBasedeDatos() {
		return basedeDatos;
	}
	public void setBasedeDatos(String basedeDatos) {
		this.basedeDatos = basedeDatos;
	}
	public String getHost() {
		return host;
	}
	public void setHost(String host) {
		this.host = host;
	}
	public String getPuerto() {
		return puerto;
	}
	public void setPuerto(String puerto) {
		this.puerto = puerto;
	}
	public String getClave() {
		return clave;
	}
	public void setClave(String clave) {
		this.clave = clave;
	}
	public String getUsuario() {
		return usuario;
	}
	public void setUsuario(String usuario) {
		this.usuario = usuario;
	}
	public String getMensajeValidacion() {
		return mensajeValidacion;
	}
	public void setMensajeValidacion(String mensajeValidacion) {
		this.mensajeValidacion = mensajeValidacion;
	}
	public boolean getResultadoValidacion() {
		return resultadoValidacion;
	}
	public void setResultadoValidacion(boolean resultadoValidacion) {
		this.resultadoValidacion = resultadoValidacion;
	}
	public String getMotivoError() {
		return motivoError;
	}
	public void setMotivoError(String motivoError) {
		this.motivoError = motivoError;
	}
	public int getContadorConexionFallida() {
		return contadorConexionFallida;
	}
	public void incrementarContadorConexionFallida() {
		this.contadorConexionFallida++; 
	}
	public long getCodigoVendedor() {
		return codigoVendedor;
	}
	public void setCodigoVendedor(long codigoVendedor) {
		this.codigoVendedor = codigoVendedor;
	}
	public String getCodigoOficina() {
		return codigoOficina;
	}
	public void setCodigoOficina(String codigoOficina) {
		this.codigoOficina = codigoOficina;
	}
	public String getCodigoProceso() {
		return codigoProceso;
	}
	public void setCodigoProceso(String codigoProceso) {
		this.codigoProceso = codigoProceso;
	}
	public long getNumVersion() {
		return numVersion;
	}
	public void setNumVersion(long numVersion) {
		this.numVersion = numVersion;
	}
	
}
