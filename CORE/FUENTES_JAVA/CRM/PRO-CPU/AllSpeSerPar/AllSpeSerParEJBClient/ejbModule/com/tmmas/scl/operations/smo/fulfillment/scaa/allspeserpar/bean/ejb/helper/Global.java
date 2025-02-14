package com.tmmas.scl.operations.smo.fulfillment.scaa.allspeserpar.bean.ejb.helper;

import java.io.Serializable;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.util.MessageResourcesConfig;

public class Global implements Serializable {
	private static final long serialVersionUID = 1L;

	private MessageResourcesConfig recurso;

	private static Global instance;

	private static Logger logger = Logger.getLogger(Global.class);

	private final String archivoRecurso = "com.tmmas.scl.operations.smo.fulfillment.scaa.allspeserpar.bean.ejb.properties.negocio";

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
