package com.tmmas.scl.framework.serviceDomain.businessObject.helper;

import java.io.Serializable;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.JndiForDataSource;
import com.tmmas.cl.framework.util.MessageResourcesConfig;

public class Global implements Serializable {
	private static final long serialVersionUID = 1L;

	private MessageResourcesConfig recurso;

	private static Global instance;

	private final Logger logger = Logger.getLogger(Global.class);

	private final String archivoRecurso = "com.tmmas.scl.framework.serviceDomain.businessObject.properties.businessobject";
	
	private JndiForDataSource jndiForDataSource;

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
	
	public String getJndiDataSource() {
		return this.recurso.obtenerValorClave("jndi.scl.serviceDomain.dataSource");
	}	
	
	public JndiForDataSource getJndiForDataSource() {		
			jndiForDataSource = new JndiForDataSource();
			jndiForDataSource.setJndiDataSource(this.getJndiDataSource());		
		return jndiForDataSource;
	}	
	
	public JndiForDataSource getJndiForTOLDataSource() {		
			jndiForDataSource = new JndiForDataSource();
			jndiForDataSource.setJndiDataSource(this.recurso.obtenerValorClave("jndi.scl.serviceDomain_TOL.dataSource"));		
		return jndiForDataSource;
	}	
	
	public JndiForDataSource getJndiForTOLServiceDataSource() 
	{		
			jndiForDataSource = new JndiForDataSource();
			jndiForDataSource.setJndiDataSource(this.recurso.obtenerValorClave("jndi.scl.serviceDomain_TOL.SERVICE.dataSource"));		
		return jndiForDataSource;
	}
	
	public JndiForDataSource getJndiForDataSourceSCL() 
	{
		jndiForDataSource = new JndiForDataSource();
		jndiForDataSource.setJndiDataSource(this.recurso.obtenerValorClave("jndi.scl.serviceDomain.dataSource"));
		return jndiForDataSource;
	}
	public JndiForDataSource getJndiForDataSourceTol() 
	{
		jndiForDataSource = new JndiForDataSource();
		jndiForDataSource.setJndiDataSource(this.recurso.obtenerValorClave("jndi.scl.dataSource_TOL.dataSource"));
		return jndiForDataSource;
	}
}
