package com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject;

import java.io.Serializable;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteDTO;

public class RetornoListaClientesDTO implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	private ClienteDTO[] clientesFiltrados;
	private String codMensaje;
	private long codTipMensaje;
	private String mensaje;
	private String strComboCliente;
	private String muestraBuscador;
	
	public String getMuestraBuscador() {
		return muestraBuscador;
	}
	public void setMuestraBuscador(String muestraBuscador) {
		this.muestraBuscador = muestraBuscador;
	}
	public String getMensaje() {
		return mensaje;
	}
	public void setMensaje(String mensaje) {
		this.mensaje = mensaje;
	}
	public ClienteDTO[] getClientesFiltrados() {
		return clientesFiltrados;
	}
	public void setClientesFiltrados(ClienteDTO[] clientesFiltrados) {
		this.clientesFiltrados = clientesFiltrados;
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
	public String getStrComboCliente() {
		return strComboCliente;
	}
	public void setStrComboCliente(String strComboCliente) {
		this.strComboCliente = strComboCliente;
	}

	
}
