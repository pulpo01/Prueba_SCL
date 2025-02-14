/**
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 17/05/2007	     	Elizabeth Vera        				Versión Inicial
 */
package com.tmmas.scl.framework.serviceDomain.dataTransferObject;

import java.io.Serializable;

public class LimiteConsumoDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	private long sujeto;
	private String tipSujeto;
	private String codNivel;
	private String fechaDesde;
	private String fechaHasta;
	private String codActAbo;
	private String codPlanTarifDestino;
	private String codTipoMovimiento;
	private int codProducto;
	
	public String getCodActAbo() {
		return codActAbo;
	}
	public void setCodActAbo(String codActAbo) {
		this.codActAbo = codActAbo;
	}

	public String getCodNivel() {
		return codNivel;
	}
	public void setCodNivel(String codNivel) {
		this.codNivel = codNivel;
	}
	public String getCodPlanTarifDestino() {
		return codPlanTarifDestino;
	}
	public void setCodPlanTarifDestino(String codPlanTarifDestino) {
		this.codPlanTarifDestino = codPlanTarifDestino;
	}
	public int getCodProducto() {
		return codProducto;
	}
	public void setCodProducto(int codProducto) {
		this.codProducto = codProducto;
	}
	public String getCodTipoMovimiento() {
		return codTipoMovimiento;
	}
	public void setCodTipoMovimiento(String codTipoMovimiento) {
		this.codTipoMovimiento = codTipoMovimiento;
	}


	public String getFechaDesde() {
		return fechaDesde;
	}
	public void setFechaDesde(String fechaDesde) {
		this.fechaDesde = fechaDesde;
	}
	public String getFechaHasta() {
		return fechaHasta;
	}
	public void setFechaHasta(String fechaHasta) {
		this.fechaHasta = fechaHasta;
	}
	public long getSujeto() {
		return sujeto;
	}
	public void setSujeto(long sujeto) {
		this.sujeto = sujeto;
	}
	public String getTipSujeto() {
		return tipSujeto;
	}
	public void setTipSujeto(String tipSujeto) {
		this.tipSujeto = tipSujeto;
	}

	
}
