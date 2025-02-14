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
 * 03/07/2007     			 Cristian Toledo              		Versión Inicial
 */
package com.tmmas.scl.framework.productDomain.dataTransferObject;

import java.io.Serializable;
import java.util.Date;

public class DesactServFreDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private String codPlanTarifNuevo;
	private String codPlanTarifActual;
	private long numAbonado;
	private long codCliente;
	private int codProducto;
	private String codFyfcel;
	private int indPlanTarif;
	private int indEstado;
	private Date fecBajaBD = new Date();
	private Date fecBajaCen = new Date();
	private int indFF;
	private Date fecAltaBD = new Date();
	private int codServSupl;
	private int codNivel;
	private long numCelular;
	private String nomUsuarioOra;
	private Date fecAltaCen = new Date();
	private int codConcepto;
	private long numDiasNum;
	private String codServicioFF;
	private String codTipoServ;
	private String codActAbo;
	private String nomParametro;
	private String codModulo;
	private String valParametro;
	private String desParametro;
	private String nomUsuario;
	private Date fecAlta = new Date();
	
	public String getCodActAbo() {
		return codActAbo;
	}
	public void setCodActAbo(String codActAbo) {
		this.codActAbo = codActAbo;
	}
	public long getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(long codCliente) {
		this.codCliente = codCliente;
	}
	public int getCodConcepto() {
		return codConcepto;
	}
	public void setCodConcepto(int codConcepto) {
		this.codConcepto = codConcepto;
	}
	public String getCodFyfcel() {
		return codFyfcel;
	}
	public void setCodFyfcel(String codFyfcel) {
		this.codFyfcel = codFyfcel;
	}
	public String getCodModulo() {
		return codModulo;
	}
	public void setCodModulo(String codModulo) {
		this.codModulo = codModulo;
	}
	public int getCodNivel() {
		return codNivel;
	}
	public void setCodNivel(int codNivel) {
		this.codNivel = codNivel;
	}
	public String getCodPlanTarifActual() {
		return codPlanTarifActual;
	}
	public void setCodPlanTarifActual(String codPlanTarifActual) {
		this.codPlanTarifActual = codPlanTarifActual;
	}
	public String getCodPlanTarifNuevo() {
		return codPlanTarifNuevo;
	}
	public void setCodPlanTarifNuevo(String codPlanTarifNuevo) {
		this.codPlanTarifNuevo = codPlanTarifNuevo;
	}
	public int getCodProducto() {
		return codProducto;
	}
	public void setCodProducto(int codProducto) {
		this.codProducto = codProducto;
	}
	public String getCodServicioFF() {
		return codServicioFF;
	}
	public void setCodServicioFF(String codServicioFF) {
		this.codServicioFF = codServicioFF;
	}
	public int getCodServSupl() {
		return codServSupl;
	}
	public void setCodServSupl(int codServSupl) {
		this.codServSupl = codServSupl;
	}
	public String getCodTipoServ() {
		return codTipoServ;
	}
	public void setCodTipoServ(String codTipoServ) {
		this.codTipoServ = codTipoServ;
	}
	public String getDesParametro() {
		return desParametro;
	}
	public void setDesParametro(String desParametro) {
		this.desParametro = desParametro;
	}
	public Date getFecAlta() {
		return fecAlta;
	}
	public void setFecAlta(Date fecAlta) {
		this.fecAlta = fecAlta;
	}
	public Date getFecAltaBD() {
		return fecAltaBD;
	}
	public void setFecAltaBD(Date fecAltaBD) {
		this.fecAltaBD = fecAltaBD;
	}
	public Date getFecAltaCen() {
		return fecAltaCen;
	}
	public void setFecAltaCen(Date fecAltaCen) {
		this.fecAltaCen = fecAltaCen;
	}
	public Date getFecBajaBD() {
		return fecBajaBD;
	}
	public void setFecBajaBD(Date fecBajaBD) {
		this.fecBajaBD = fecBajaBD;
	}
	public Date getFecBajaCen() {
		return fecBajaCen;
	}
	public void setFecBajaCen(Date fecBajaCen) {
		this.fecBajaCen = fecBajaCen;
	}
	public int getIndEstado() {
		return indEstado;
	}
	public void setIndEstado(int indEstado) {
		this.indEstado = indEstado;
	}
	public int getIndFF() {
		return indFF;
	}
	public void setIndFF(int indFF) {
		this.indFF = indFF;
	}
	public int getIndPlanTarif() {
		return indPlanTarif;
	}
	public void setIndPlanTarif(int indPlanTarif) {
		this.indPlanTarif = indPlanTarif;
	}
	public String getNomParametro() {
		return nomParametro;
	}
	public void setNomParametro(String nomParametro) {
		this.nomParametro = nomParametro;
	}
	public String getNomUsuario() {
		return nomUsuario;
	}
	public void setNomUsuario(String nomUsuario) {
		this.nomUsuario = nomUsuario;
	}
	public String getNomUsuarioOra() {
		return nomUsuarioOra;
	}
	public void setNomUsuarioOra(String nomUsuarioOra) {
		this.nomUsuarioOra = nomUsuarioOra;
	}
	public long getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(long numAbonado) {
		this.numAbonado = numAbonado;
	}
	public long getNumCelular() {
		return numCelular;
	}
	public void setNumCelular(long numCelular) {
		this.numCelular = numCelular;
	}
	public long getNumDiasNum() {
		return numDiasNum;
	}
	public void setNumDiasNum(long numDiasNum) {
		this.numDiasNum = numDiasNum;
	}
	public String getValParametro() {
		return valParametro;
	}
	public void setValParametro(String valParametro) {
		this.valParametro = valParametro;
	}
	
}
