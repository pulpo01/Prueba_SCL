/**
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 18/05/2007	     	Elizabeth Vera        				Versión Inicial
 */
package com.tmmas.scl.framework.productDomain.dataTransferObject;

import java.io.Serializable;

public class CambioPlanComercialDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	private long idSecuencia;
	private String codActAbo;
	private int codProducto;
	private long numAbonado;
	private String codTipoPlanTarif;
	private String codTipoPlanTarifDestino;
	private String codHoldingEmpresa;
	private long codOOSS;
	
	public long getCodOOSS() {
		return codOOSS;
	}
	public void setCodOOSS(long codOOSS) {
		this.codOOSS = codOOSS;
	}
	public String getCodActAbo() {
		return codActAbo;
	}
	public void setCodActAbo(String codActAbo) {
		this.codActAbo = codActAbo;
	}
	public String getCodHoldingEmpresa() {
		return codHoldingEmpresa;
	}
	public void setCodHoldingEmpresa(String codHoldingEmpresa) {
		this.codHoldingEmpresa = codHoldingEmpresa;
	}
	public int getCodProducto() {
		return codProducto;
	}
	public void setCodProducto(int codProducto) {
		this.codProducto = codProducto;
	}
	public String getCodTipoPlanTarif() {
		return codTipoPlanTarif;
	}
	public void setCodTipoPlanTarif(String codTipoPlanTarif) {
		this.codTipoPlanTarif = codTipoPlanTarif;
	}
	public String getCodTipoPlanTarifDestino() {
		return codTipoPlanTarifDestino;
	}
	public void setCodTipoPlanTarifDestino(String codTipoPlanTarifDestino) {
		this.codTipoPlanTarifDestino = codTipoPlanTarifDestino;
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
	

}
