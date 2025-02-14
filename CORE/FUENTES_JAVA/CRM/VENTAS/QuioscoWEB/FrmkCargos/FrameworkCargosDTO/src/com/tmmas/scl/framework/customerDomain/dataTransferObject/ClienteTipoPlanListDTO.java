package com.tmmas.scl.framework.customerDomain.dataTransferObject;

import java.io.Serializable;

public class ClienteTipoPlanListDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	private ClienteDTO clientesPrepago[];
	private ClienteDTO clientesPospago[];
	private ClienteDTO clientesHibrido[];
	
	public ClienteDTO[] getClientesHibrido() {
		return clientesHibrido;
	}
	public void setClientesHibrido(ClienteDTO[] clientesHibrido) {
		this.clientesHibrido = clientesHibrido;
	}
	public ClienteDTO[] getClientesPospago() {
		return clientesPospago;
	}
	public void setClientesPospago(ClienteDTO[] clientesPospago) {
		this.clientesPospago = clientesPospago;
	}
	public ClienteDTO[] getClientesPrepago() {
		return clientesPrepago;
	}
	public void setClientesPrepago(ClienteDTO[] clientesPrepago) {
		this.clientesPrepago = clientesPrepago;
	}
	


	
}
