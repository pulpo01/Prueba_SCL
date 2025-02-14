package com.tmmas.scl.frameworkcargos.srv.helper;

import java.io.Serializable;

import com.tmmas.scl.framework.commonDoman.common.helper.GlobalBase;

public class Global extends  GlobalBase implements Serializable {
	private static final long serialVersionUID = 1L;
	private static Global instance;

	public Global(String archivo) {
		super(archivo);
	}
	 
	public static synchronized Global getInstance() {
			if (instance == null) {
				instance = new Global("com.tmmas.scl.frameworkcargos.srv.properties.servicios");
			}
			return instance;
		}

/*	
	private static final long serialVersionUID = 1L;
	private MessageResourcesConfig recurso;
	private static Global instance;
	private final String archivoRecurso = "com.tmmas.cl.scl.frameworkcargos.srv.gcd.properties.service";

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
