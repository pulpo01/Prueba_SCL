package com.tmmas.scl.vendedor.negocio.ejb.session.helper;

import java.io.Serializable;
import com.tmmas.cl.framework.base.JndiForDataSource;


public class Global extends  com.tmmas.scl.operations.crm.fab.customerinterfacemanagement.common.helper.GlobalBase implements Serializable {
	private static final long serialVersionUID = 1L;
	private JndiForDataSource jndiForDataSource;
	private static Global instance;

	public Global(String archivo) {
		super(archivo);
	}
	 
	public static synchronized Global getInstance() {
			if (instance == null) {
				instance = new Global("com.tmmas.scl.vendedor.negocio.ejb.session.properties.negocio");
			}
			return instance;
		}


	
	public String getJndiDataSource() {
		return this.recurso.obtenerValorClave("jndi.scl.vendedor.dataSource");
	}
	
	public JndiForDataSource getJndiForDataSource() {
		if (jndiForDataSource == null) {
			jndiForDataSource = new JndiForDataSource();
			jndiForDataSource.setJndiDataSource(this.getJndiDataSource());
		}
		return jndiForDataSource;
	}	
}
