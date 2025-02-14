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
 * 10/08/2007     			 Elizabeth Vera              		Versión Inicial
 */
package com.tmmas.scl.framework.productDomain.dataTransferObject;

import java.io.Serializable;
import java.util.Date;

public class GaAbocelDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private long idSecuencia;
	private long numAbonado;
	private long codCliente;
	private String codPlanTarif;
	private String tipPlanTarif;
	private int codProducto;
	private String codTecnologia;
	private long codCuenta;
	private int codUso;
	private String codUsoString;
	private int numDia;
	private int codCiclo;
	private String codLimiteConsumo;
	private String codCargoBasico;
	private Date fecAlta;
	private String numContrato;
	private String codTipContrato;
	private long numVenta;
	private String numAnexo;
	private String codCausaVenta;
	private Date fecFinContra;
	private Date fecBaja;
	private Date fecBajaCen;
	private Date fecCumplan;
	private String codSituacion;
	
	public String getCodCargoBasico() {
		return codCargoBasico;
	}
	public void setCodCargoBasico(String codCargoBasico) {
		this.codCargoBasico = codCargoBasico;
	}
	public String getCodCausaVenta() {
		return codCausaVenta;
	}
	public void setCodCausaVenta(String codCausaVenta) {
		this.codCausaVenta = codCausaVenta;
	}
	public int getCodCiclo() {
		return codCiclo;
	}
	public void setCodCiclo(int codCiclo) {
		this.codCiclo = codCiclo;
	}
	public long getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(long codCliente) {
		this.codCliente = codCliente;
	}
	public long getCodCuenta() {
		return codCuenta;
	}
	public void setCodCuenta(long codCuenta) {
		this.codCuenta = codCuenta;
	}
	public String getCodLimiteConsumo() {
		return codLimiteConsumo;
	}
	public void setCodLimiteConsumo(String codLimiteConsumo) {
		this.codLimiteConsumo = codLimiteConsumo;
	}
	public String getCodPlanTarif() {
		return codPlanTarif;
	}
	public void setCodPlanTarif(String codPlanTarif) {
		this.codPlanTarif = codPlanTarif;
	}
	public int getCodProducto() {
		return codProducto;
	}
	public void setCodProducto(int codProducto) {
		this.codProducto = codProducto;
	}
	public String getCodSituacion() {
		return codSituacion;
	}
	public void setCodSituacion(String codSituacion) {
		this.codSituacion = codSituacion;
	}
	public String getCodTecnologia() {
		return codTecnologia;
	}
	public void setCodTecnologia(String codTecnologia) {
		this.codTecnologia = codTecnologia;
	}
	public String getCodTipContrato() {
		return codTipContrato;
	}
	public void setCodTipContrato(String codTipContrato) {
		this.codTipContrato = codTipContrato;
	}
	public int getCodUso() {
		if(codUsoString!=null)
			return (Integer.parseInt(codUsoString));
		else
			return codUso;	

	}
	
	public void setCodUso(int codUso) {
		this.codUso = codUso;
	}

	public Date getFecBajaCen() {
		return fecBajaCen;
	}
	public void setFecBajaCen(Date fecBajaCen) {
		this.fecBajaCen = fecBajaCen;
	}
	public Date getFecAlta() {
		return fecAlta;
	}
	public void setFecAlta(Date fecAlta) {
		this.fecAlta = fecAlta;
	}
	public Date getFecBaja() {
		return fecBaja;
	}
	public void setFecBaja(Date fecBaja) {
		this.fecBaja = fecBaja;
	}
	public Date getFecCumplan() {
		return fecCumplan;
	}
	public void setFecCumplan(Date fecCumplan) {
		this.fecCumplan = fecCumplan;
	}
	public Date getFecFinContra() {
		return fecFinContra;
	}
	public void setFecFinContra(Date fecFinContra) {
		this.fecFinContra = fecFinContra;
	}
	public long getIdSecuencia() {
		return idSecuencia;
	}
	public void setIdSecuencia(long idSecuencia) {
		this.idSecuencia = idSecuencia;
	}
	public long getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(long numAbonado) {
		this.numAbonado = numAbonado;
	}
	public String getNumAnexo() {
		return numAnexo;
	}
	public void setNumAnexo(String numAnexo) {
		this.numAnexo = numAnexo;
	}
	public String getNumContrato() {
		return numContrato;
	}
	public void setNumContrato(String numContrato) {
		this.numContrato = numContrato;
	}
	public int getNumDia() {
		return numDia;
	}
	public void setNumDia(int numDia) {
		this.numDia = numDia;
	}
	public long getNumVenta() {
		return numVenta;
	}
	public void setNumVenta(long numVenta) {
		this.numVenta = numVenta;
	}
	public String getTipPlanTarif() {
		return tipPlanTarif;
	}
	public void setTipPlanTarif(String tipPlanTarif) {
		this.tipPlanTarif = tipPlanTarif;
	}
	public String getCodUsoString() {
		return codUsoString;
	}
	public void setCodUsoString(String codUsoString) {
		this.codUsoString = codUsoString;
	}

              
}
