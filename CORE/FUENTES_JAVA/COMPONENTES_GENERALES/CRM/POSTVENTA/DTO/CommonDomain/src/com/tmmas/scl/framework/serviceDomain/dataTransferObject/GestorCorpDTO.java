/**
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 18/05/2007	     	Elizabeth Vera        				Versión Inicial
 */
package com.tmmas.scl.framework.serviceDomain.dataTransferObject;

import java.io.Serializable;

public class GestorCorpDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	private long numAbonado;
	private String codActAboGestor;
	private String usuarioOracle;
	private String codPlanTarif;
	private String codPlanTarifDestino;
	private String codTipoMovimiento;
	private String codActAbo;
	private String flagGestor;
	private String flagGestorDefault;
	private long idSecuencia;
	
	private String generaComandOut;
	private String abonadoGestorOut;
	private String abonadoGestorDefOut;
	
	public String getAbonadoGestorDefOut() {
		return abonadoGestorDefOut;
	}
	public void setAbonadoGestorDefOut(String abonadoGestorDefOut) {
		this.abonadoGestorDefOut = abonadoGestorDefOut;
	}
	public String getAbonadoGestorOut() {
		return abonadoGestorOut;
	}
	public void setAbonadoGestorOut(String abonadoGestorOut) {
		this.abonadoGestorOut = abonadoGestorOut;
	}
	public String getGeneraComandOut() {
		return generaComandOut;
	}
	public void setGeneraComandOut(String generaComandOut) {
		this.generaComandOut = generaComandOut;
	}
	public long getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(long numAbonado) {
		this.numAbonado = numAbonado;
	}
	public String getCodActAbo() {
		return codActAbo;
	}
	public void setCodActAbo(String codActAbo) {
		this.codActAbo = codActAbo;
	}
	public String getCodActAboGestor() {
		return codActAboGestor;
	}
	public void setCodActAboGestor(String codActAboGestor) {
		this.codActAboGestor = codActAboGestor;
	}
	public String getCodPlanTarif() {
		return codPlanTarif;
	}
	public void setCodPlanTarif(String codPlanTarif) {
		this.codPlanTarif = codPlanTarif;
	}
	public String getCodPlanTarifDestino() {
		return codPlanTarifDestino;
	}
	public void setCodPlanTarifDestino(String codPlanTarifDestino) {
		this.codPlanTarifDestino = codPlanTarifDestino;
	}
	public String getCodTipoMovimiento() {
		return codTipoMovimiento;
	}
	public void setCodTipoMovimiento(String codTipoMovimiento) {
		this.codTipoMovimiento = codTipoMovimiento;
	}
	public String getFlagGestor() {
		return flagGestor;
	}
	public void setFlagGestor(String flagGestor) {
		this.flagGestor = flagGestor;
	}
	public String getFlagGestorDefault() {
		return flagGestorDefault;
	}
	public void setFlagGestorDefault(String flagGestorDefault) {
		this.flagGestorDefault = flagGestorDefault;
	}

	public long getIdSecuencia() {
		return idSecuencia;
	}
	public void setIdSecuencia(long idSecuencia) {
		this.idSecuencia = idSecuencia;
	}
	public String getUsuarioOracle() {
		return usuarioOracle;
	}
	public void setUsuarioOracle(String usuarioOracle) {
		this.usuarioOracle = usuarioOracle;
	}
	
}
