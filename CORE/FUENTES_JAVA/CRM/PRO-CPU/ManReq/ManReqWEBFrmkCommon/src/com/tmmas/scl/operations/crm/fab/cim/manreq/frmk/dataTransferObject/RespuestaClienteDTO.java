package com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject;

import java.io.Serializable;

public class RespuestaClienteDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private String mensaje;
	private String codMensaje;
	private long codTipMensaje;
	private long codCliente;
	private long numAbonados;
	public long getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(long codCliente) {
		this.codCliente = codCliente;
	}
	public String getCodMensaje() {
		return codMensaje;
	}
	public void setCodMensaje(String codMensaje) {
		this.codMensaje = codMensaje;
	}
	public long getCodTipMensaje() {
		return codTipMensaje;
	}
	public void setCodTipMensaje(long codTipMensaje) {
		this.codTipMensaje = codTipMensaje;
	}
	public String getMensaje() {
		return mensaje;
	}
	public void setMensaje(String mensaje) {
		this.mensaje = mensaje;
	}
	public long getNumAbonados() {
		return numAbonados;
	}
	public void setNumAbonados(long numAbonados) {
		this.numAbonados = numAbonados;
	}
}
