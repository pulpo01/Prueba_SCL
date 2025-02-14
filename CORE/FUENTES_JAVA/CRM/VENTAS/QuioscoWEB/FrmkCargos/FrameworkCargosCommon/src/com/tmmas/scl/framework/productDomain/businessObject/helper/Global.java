package com.tmmas.scl.framework.productDomain.businessObject.helper;

import java.io.Serializable;

import com.tmmas.cl.framework.base.JndiForDataSource;
import com.tmmas.scl.framework.commonDoman.common.helper.GlobalBase;

public class Global extends  GlobalBase implements Serializable {
	private static final long serialVersionUID = 1L;
	private JndiForDataSource jndiForDataSource;
	private static Global instance;

	public Global(String archivo) {
		super(archivo);
	}
	 
	public static synchronized Global getInstance() {
			if (instance == null) {
				instance = new Global("com.tmmas.scl.framework.productDomain.businessObject.properties.businessobject");
			}
			return instance;
		}

/*
	private static final long serialVersionUID = 1L;
	private MessageResourcesConfig recurso;
	private static Global instance;
	private final Logger logger = Logger.getLogger(Global.class);
	private final String archivoRecurso = "com.tmmas.scl.framework.productDomain.businessObject.properties.businessobject";
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
*/
	
	public String getJndiDataSource() {
		return this.recurso.obtenerValorClave("jndi.scl.siscel.dataSource");
	}	
	
	public JndiForDataSource getJndiForDataSource() 
	{	
			jndiForDataSource = new JndiForDataSource();
			jndiForDataSource.setJndiDataSource(this.getJndiDataSource());	
		return jndiForDataSource;
	}	
	
	public JndiForDataSource getJndiForSCLDataSource() 
	{		
		jndiForDataSource = new JndiForDataSource();
		jndiForDataSource.setJndiDataSource(this.recurso.obtenerValorClave("jndi.scl.siscel.dataSource"));
		return jndiForDataSource;
	}
	
	public JndiForDataSource getCPUJndiForDataSource() 
	{
		JndiForDataSource jndiForDataSourceCPU=new JndiForDataSource();		 
		jndiForDataSourceCPU.setJndiDataSource(this.recurso.obtenerValorClave("jndi.scl.CPU.dataSource"));		
		return jndiForDataSourceCPU;
	}
	
	public JndiForDataSource getJndiForDataSourceSCL() 
	{
		jndiForDataSource = new JndiForDataSource();
		jndiForDataSource.setJndiDataSource(this.recurso.obtenerValorClave("jndi.scl.siscel.dataSource"));
		return jndiForDataSource;
	}
	
}
