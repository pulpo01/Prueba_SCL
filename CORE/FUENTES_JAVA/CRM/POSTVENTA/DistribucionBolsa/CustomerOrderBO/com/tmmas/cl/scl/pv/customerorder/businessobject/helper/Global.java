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
 * 17/08/2006     Jimmy Lopez              					Versión Inicial
 */
package com.tmmas.cl.scl.pv.customerorder.businessobject.helper;

import java.io.Serializable;

import org.apache.log4j.Category;

import com.tmmas.cl.framework.base.JndiForDataSource;
import com.tmmas.cl.framework.util.MessageResourcesConfig;

public class Global implements Serializable {
	private static final long serialVersionUID = 1L;

	private MessageResourcesConfig recurso;

	private static Global instance;

	private JndiForDataSource jndiForDataSource = null;

	private final Category cat = Category.getInstance(Global.class);

	private final String archivoRecurso = "com.tmmas.cl.scl.pv.customerorder.businessobject.properties.businessobject";

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
		return this.recurso.obtenerValorClave("jndi.tol25.Customer.scl.dataSource");
	}

	public JndiForDataSource getJndiForDataSource() {

		cat.debug("jndiForDataSource ["+(jndiForDataSource==null)+"]");
		
		if (jndiForDataSource == null) {

			jndiForDataSource = new JndiForDataSource();

			jndiForDataSource.setJndiDataSource(this.getJndiDataSource());
		}else{
			cat.debug("jndiForDataSource ["+jndiForDataSource.getJndiDataSource()+"]");
		}
		return jndiForDataSource;
	}
}
