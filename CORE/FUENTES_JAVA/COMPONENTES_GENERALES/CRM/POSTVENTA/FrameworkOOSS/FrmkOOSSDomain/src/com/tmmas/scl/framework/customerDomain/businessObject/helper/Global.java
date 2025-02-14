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

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.JndiForDataSource;
import com.tmmas.cl.framework.util.MessageResourcesConfig;

public class Global implements Serializable {
	private static final long serialVersionUID = 1L;

	private MessageResourcesConfig recurso;

	private static Global instance;

	private final Logger logger = Logger.getLogger(Global.class);
	private final String archivoRecurso = "com.tmmas.scl.framework.customerDomain.businessObject.properties.businessobject";
	
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
