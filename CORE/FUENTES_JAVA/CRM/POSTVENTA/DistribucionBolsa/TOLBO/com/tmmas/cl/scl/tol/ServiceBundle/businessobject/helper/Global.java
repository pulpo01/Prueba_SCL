package com.tmmas.cl.scl.tol.ServiceBundle.businessobject.helper;

import java.io.Serializable;

import org.apache.log4j.Category;

import com.tmmas.cl.framework.base.JndiForDataSource;
import com.tmmas.cl.framework.util.MessageResourcesConfig;

public class Global implements Serializable {
	private static final long serialVersionUID = 1L;

	private MessageResourcesConfig recurso;

	private static Global instance;

	private JndiForDataSource jndiForDataSource = null;
	private JndiForDataSource jndiForDataSourceTOL = null;

	private final Category cat = Category.getInstance(Global.class);

	private final String archivoRecurso = "com.tmmas.cl.scl.tol.ServiceBundle.businessobject.properties.businessobject";

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

	public String getJndiSCLDataSource() {
		cat.debug("JNDI"+recurso.obtenerValorClave("jndi.tol25.tol.scl.dataSource"));
		return this.recurso.obtenerValorClave("jndi.tol25.tol.scl.dataSource");
	}

	public String getJndiTOLDataSource() {
		cat.debug("JNDI"+recurso.obtenerValorClave("jndi.tol25.tol.tol.dataSource"));
		return this.recurso.obtenerValorClave("jndi.tol25.tol.tol.dataSource");		
	}
	
	public JndiForDataSource getJndiSCLForDataSource() 
	{
		if (jndiForDataSource == null) {
			jndiForDataSource = new JndiForDataSource();
			jndiForDataSource.setJndiDataSource(this.getJndiSCLDataSource());
		}
		return jndiForDataSource;
	}
	
	
	public JndiForDataSource getJndiTOLForDataSource() 
	{
		if (jndiForDataSourceTOL == null) {
			jndiForDataSourceTOL = new JndiForDataSource();
			jndiForDataSourceTOL.setJndiDataSource(this.getJndiTOLDataSource());
		}
		return jndiForDataSourceTOL;
	}
}