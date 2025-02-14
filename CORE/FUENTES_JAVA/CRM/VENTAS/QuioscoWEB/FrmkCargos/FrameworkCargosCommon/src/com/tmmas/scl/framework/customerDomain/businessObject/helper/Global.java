/**
 * Copyright © 2006 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 20/09/2006     Jimmy Lopez              					Versión Inicial
 */
package com.tmmas.scl.framework.customerDomain.businessObject.helper;

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
				instance = new Global("com.tmmas.scl.framework.customerDomain.businessObject.properties.businessobject");
			}
			return instance;
		}

	public String getJndiDataSource() {
		return this.recurso.obtenerValorClave("jndi.scl.frmkCargos.dataSource");
	}	
	
	public JndiForDataSource getJndiForDataSource() {
		if (jndiForDataSource == null) {
			jndiForDataSource = new JndiForDataSource();
			jndiForDataSource.setJndiDataSource(this.getJndiDataSource());
		}
		return jndiForDataSource;
	}	
	
	public JndiForDataSource getCustomJndiForDataSource() 
	{
		JndiForDataSource jndiForDataSourceCPU=new JndiForDataSource();		 
		jndiForDataSourceCPU.setJndiDataSource(this.recurso.obtenerValorClave("jndi.scl.custom.dataSource"));		
		return jndiForDataSourceCPU;
	}	
	
}
