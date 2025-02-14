package com.tmmas.cl.scl.direccion.presentacion.helper;

import java.io.Serializable;

public class Global extends GlobalBase implements Serializable{
	private static final long serialVersionUID = 1L;

	private static Global instance;

	public Global(String archivo) {
		super(archivo);
	}
	 
	public static synchronized Global getInstance() {
		if (instance == null) {
			instance = new Global("com.tmmas.cl.scl.direccion.presentacion.properties.direccionweb");
		}
		return instance;
	}

}
