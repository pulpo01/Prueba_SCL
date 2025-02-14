package com.tmmas.cl.scl.frameworkcargos.helper;

import java.io.Serializable;
import com.tmmas.cl.framework.base.JndiForDataSource;
import com.tmmas.scl.framework.commonDoman.helper.GlobalBase;

public class Global extends  GlobalBase implements Serializable {
	private static final long serialVersionUID = 1L;
	private JndiForDataSource jndiForDataSource;
	private static Global instance;

	public Global(String archivo) {
		super(archivo);
	}
	 
	public static synchronized Global getInstance() {
			if (instance == null) {
				instance = new Global("com.tmmas.cl.scl.frameworkcargos.properties.service");
			}
			return instance;
		}
	
	public String getJndiDataSource() {
		return this.recurso.obtenerValorClave("jndi.scl.dataSource");
	}	
	
	public JndiForDataSource getJndiForDataSource() {
		if (jndiForDataSource == null) {
			jndiForDataSource = new JndiForDataSource();
			jndiForDataSource.setJndiDataSource(this.getJndiDataSource());
		}
		return jndiForDataSource;
	}	
	
}

