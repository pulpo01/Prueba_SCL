/**
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 18/05/2007	     	Elizabeth Vera        				Versión Inicial
 */
package com.tmmas.scl.framework.customerDomain.dataTransferObject;

import java.io.Serializable;
import java.util.Date;

public class ModAboCliDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	private long codClienteAbonado;
	private String codTipModif;
	private Date fecha;
	private String usuarioOracle;
	
		
	public long getCodClienteAbonado() {
		return codClienteAbonado;
	}
	public void setCodClienteAbonado(long codClienteAbonado) {
		this.codClienteAbonado = codClienteAbonado;
	}
	public String getCodTipModif() {
		return codTipModif;
	}
	public void setCodTipModif(String codTipModif) {
		this.codTipModif = codTipModif;
	}
	public Date getFecha() {
		return fecha;
	}
	public void setFecha(Date fecha) {
		this.fecha = fecha;
	}
	public String getUsuarioOracle() {
		return usuarioOracle;
	}
	public void setUsuarioOracle(String usuarioOracle) {
		this.usuarioOracle = usuarioOracle;
	}
}
