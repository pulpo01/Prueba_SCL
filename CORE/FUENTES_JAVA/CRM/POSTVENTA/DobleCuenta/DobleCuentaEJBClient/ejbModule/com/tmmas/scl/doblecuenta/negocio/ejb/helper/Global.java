package com.tmmas.scl.doblecuenta.negocio.ejb.helper;

import java.io.Serializable;

import com.tmmas.cl.framework.util.MessageResourcesConfig;

public class Global implements Serializable{
	private static final long serialVersionUID = 1L;

	private MessageResourcesConfig recurso = null;

	private static Global instance = null;

	private final String archivoRecurso = "com.tmmas.scl.doblecuenta.negocio.ejb.properties.negocio";

	// --------------------------------------------------------------------------
	private Global() {
		this.recurso = new MessageResourcesConfig(archivoRecurso);
	}

	// --------------------------------------------------------------------------
	public static synchronized Global getInstance() {
		if (instance == null) {
			instance = new Global();
		}
		return instance;
	}

	public MessageResourcesConfig getMessageResourcesConfig() {
		return this.recurso;
	}

	public String getValor(String valorClave) {
		String valor = this.recurso.obtenerValorClave(valorClave);
		return valor;
	}

}
