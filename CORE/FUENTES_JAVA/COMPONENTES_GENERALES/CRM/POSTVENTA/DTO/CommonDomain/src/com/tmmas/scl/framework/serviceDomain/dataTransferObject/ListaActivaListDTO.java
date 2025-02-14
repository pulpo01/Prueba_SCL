/**
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 24/07/2007	     	Elizabeth Vera        				Versión Inicial
 */
package com.tmmas.scl.framework.serviceDomain.dataTransferObject;

import java.io.Serializable;

public class ListaActivaListDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private ListaActivaDTO[] lista;

	public ListaActivaDTO[] getLista() {
		return lista;
	}

	public void setLista(ListaActivaDTO[] lista) {
		this.lista = lista;
	}
	
}
