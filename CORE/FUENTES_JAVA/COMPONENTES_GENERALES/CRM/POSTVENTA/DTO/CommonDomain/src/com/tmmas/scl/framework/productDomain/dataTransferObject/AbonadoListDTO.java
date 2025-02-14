/**
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 17/05/2007	     	Elizabeth Vera        				Versión Inicial
 */
package com.tmmas.scl.framework.productDomain.dataTransferObject;

import java.io.Serializable;

public class AbonadoListDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	private AbonadoDTO abonados[];
	//private ClienteDTO cliente;
	
	public AbonadoDTO[] getAbonados() {
		return abonados;
	}
	public void setAbonados(AbonadoDTO[] abonados) {
		this.abonados = abonados;
	}
	/*public ClienteDTO getCliente() {
		return cliente;
	}
	public void setCliente(ClienteDTO cliente) {
		this.cliente = cliente;
	}*/
	
}
