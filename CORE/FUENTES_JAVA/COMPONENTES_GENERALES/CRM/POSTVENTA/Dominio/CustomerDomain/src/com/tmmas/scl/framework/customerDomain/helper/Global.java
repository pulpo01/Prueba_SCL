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
package com.tmmas.scl.framework.customerDomain.helper;

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
				instance = new Global("com.tmmas.scl.framework.customerDomain.properties.businessobject");
			}
			return instance;
		}

/*	
	private static final long serialVersionUID = 1L;
	private MessageResourcesConfig recurso;
	private static Global instance;
	private final String archivoRecurso = "com.tmmas.scl.framework.customerDomain.properties.businessobject";
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
		return this.recurso.obtenerValorClave("jndi.scl.customerDomain.dataSource");
	}	
	
	public JndiForDataSource getJndiForDataSource() {
		if (jndiForDataSource == null) {
			jndiForDataSource = new JndiForDataSource();
			jndiForDataSource.setJndiDataSource(this.getJndiDataSource());
		}
		return jndiForDataSource;
	}	
	
}
