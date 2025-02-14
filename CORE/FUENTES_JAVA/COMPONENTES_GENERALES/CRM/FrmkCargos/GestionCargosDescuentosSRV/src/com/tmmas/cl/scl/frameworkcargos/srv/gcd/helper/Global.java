package com.tmmas.cl.scl.frameworkcargos.srv.gcd.helper;

import java.io.Serializable;

import com.tmmas.scl.framework.commonDoman.helper.GlobalBase;

public class Global extends  GlobalBase implements Serializable {
	private static final long serialVersionUID = 1L;
	private static Global instance;

	public Global(String archivo) {
		super(archivo);
	}
	 
	public static synchronized Global getInstance() {
			if (instance == null) {
				instance = new Global("com.tmmas.cl.scl.frameworkcargos.srv.gcd.properties.service");
			}
			return instance;
		}

}
