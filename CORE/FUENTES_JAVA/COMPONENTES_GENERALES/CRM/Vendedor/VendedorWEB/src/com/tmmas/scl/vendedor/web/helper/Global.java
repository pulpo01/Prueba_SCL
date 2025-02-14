package com.tmmas.scl.vendedor.web.helper;

import java.io.Serializable;

public class Global extends  com.tmmas.scl.operations.crm.fab.customerinterfacemanagement.common.helper.GlobalBase implements Serializable {
	private static final long serialVersionUID = 1L;
	private static Global instance;

	public Global(String archivo) {
		super(archivo);
	}
	 
	public static synchronized Global getInstance() {
			if (instance == null) {
				instance = new Global("com.tmmas.scl.vendedor.web.properties.web");
			}
			return instance;
		}

/*
	private static final long serialVersionUID = 1L;
	private MessageResourcesConfig recurso;
	private static Global instance;
	private final String archivoRecurso = "com.tmmas.scl.vendedor.web.properties.web";

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
*/	
}
