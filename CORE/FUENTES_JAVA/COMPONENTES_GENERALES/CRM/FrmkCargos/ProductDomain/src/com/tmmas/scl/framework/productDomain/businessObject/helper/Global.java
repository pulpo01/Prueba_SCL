package com.tmmas.scl.framework.productDomain.businessObject.helper;

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
				instance = new Global("com.tmmas.scl.framework.productDomain.businessObject.properties.businessobject");
			}
			return instance;
		}


	
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
