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
 * 14/05/2007     Héctor Hermosilla      					Versión Inicial
 */
package com.tmmas.cl.scl.productdomain.businessobject.dto;

import java.io.Serializable;

public class TipoPrestacionDTO implements Serializable {

	private static final long serialVersionUID = 1L;
    
	private String codGrupoPrestacion;
	private String codPrestacion;
	private String desPrestacion;
	private int tipVenta;
	private int indNumero;
	private int indAnchoBanda;
	private int indIP;
	private int indDirInstalacion;
	private int indInventario;
	private String codPlantarifDefecto;
	private int codCentralDefecto;
	private String codCeldaDefecto;
	private int indSSInternet;
	private String tipoRed;
	private int indActivo;
	private String codServicioInstalacion;
	private int indNumeroPiloto;
		
	
	public int getIndNumeroPiloto() {
		return indNumeroPiloto;
	}
	public void setIndNumeroPiloto(int indNumeroPiloto) {
		this.indNumeroPiloto = indNumeroPiloto;
	}
	public String getCodServicioInstalacion() {
		return codServicioInstalacion;
	}
	public void setCodServicioInstalacion(String codServicioInstalacion) {
		this.codServicioInstalacion = codServicioInstalacion;
	}
	public int getIndActivo() {
		return indActivo;
	}
	public void setIndActivo(int indActivo) {
		this.indActivo = indActivo;
	}
	public String getCodCeldaDefecto() {
		return codCeldaDefecto;
	}
	public void setCodCeldaDefecto(String codCeldaDefecto) {
		this.codCeldaDefecto = codCeldaDefecto;
	}
	public int getCodCentralDefecto() {
		return codCentralDefecto;
	}
	public void setCodCentralDefecto(int codCentralDefecto) {
		this.codCentralDefecto = codCentralDefecto;
	}
	public String getCodPlantarifDefecto() {
		return codPlantarifDefecto;
	}
	public void setCodPlantarifDefecto(String codPlantarifDefecto) {
		this.codPlantarifDefecto = codPlantarifDefecto;
	}
	public String getCodPrestacion() {
		return codPrestacion;
	}
	public void setCodPrestacion(String codPrestacion) {
		this.codPrestacion = codPrestacion;
	}
	public String getDesPrestacion() {
		return desPrestacion;
	}
	public void setDesPrestacion(String desPrestacion) {
		this.desPrestacion = desPrestacion;
	}
	public int getIndAnchoBanda() {
		return indAnchoBanda;
	}
	public void setIndAnchoBanda(int indAnchoBanda) {
		this.indAnchoBanda = indAnchoBanda;
	}
	public int getIndDirInstalacion() {
		return indDirInstalacion;
	}
	public void setIndDirInstalacion(int indDirInstalacion) {
		this.indDirInstalacion = indDirInstalacion;
	}
	public int getIndInventario() {
		return indInventario;
	}
	public void setIndInventario(int indInventario) {
		this.indInventario = indInventario;
	}
	public int getIndIP() {
		return indIP;
	}
	public void setIndIP(int indIP) {
		this.indIP = indIP;
	}
	public int getIndNumero() {
		return indNumero;
	}
	public void setIndNumero(int indNumero) {
		this.indNumero = indNumero;
	}
	public int getTipVenta() {
		return tipVenta;
	}
	public void setTipVenta(int tipVenta) {
		this.tipVenta = tipVenta;
	}
	public String getCodGrupoPrestacion() {
		return codGrupoPrestacion;
	}
	public void setCodGrupoPrestacion(String codGrupoPrestacion) {
		this.codGrupoPrestacion = codGrupoPrestacion;
	}
	public int getIndSSInternet() {
		return indSSInternet;
	}
	public void setIndSSInternet(int indSSInternet) {
		this.indSSInternet = indSSInternet;
	}
	public String getTipoRed() {
		return tipoRed;
	}
	public void setTipoRed(String tipoRed) {
		this.tipoRed = tipoRed;
	}	
	
}
