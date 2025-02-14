/**
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 18/05/2007	     	Elizabeth Vera        				Versión Inicial
 */
package com.tmmas.scl.framework.customerDomain.dataTransferObject;

import java.io.Serializable;

public class RegistroNivelDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	private long codClienteAbonado;
	private String codNivel;
	private String codActAbo;
	private ModAboCliDTO modCliente;
	private ModAboCliDTO modAbonado;
	private ComplementoDTO complemento;
	
	public String getCodActAbo() {
		return codActAbo;
	}
	public void setCodActAbo(String codActAbo) {
		this.codActAbo = codActAbo;
	}
	public long getCodClienteAbonado() {
		return codClienteAbonado;
	}
	public void setCodClienteAbonado(long codClienteAbonado) {
		this.codClienteAbonado = codClienteAbonado;
	}
	public String getCodNivel() {
		return codNivel;
	}
	public void setCodNivel(String codNivel) {
		this.codNivel = codNivel;
	}
	public ComplementoDTO getComplemento() {
		return complemento;
	}
	public void setComplemento(ComplementoDTO complemento) {
		this.complemento = complemento;
	}
	public ModAboCliDTO getModAbonado() {
		return modAbonado;
	}
	public void setModAbonado(ModAboCliDTO modAbonado) {
		this.modAbonado = modAbonado;
	}
	public ModAboCliDTO getModCliente() {
		return modCliente;
	}
	public void setModCliente(ModAboCliDTO modCliente) {
		this.modCliente = modCliente;
	}
	
}
