/**
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 18/05/2007	     	Elizabeth Vera        				Versión Inicial
 * 
 */
package com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper;

import java.io.Serializable;

import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.dataTransferObject.GlobalBase;

public class Global extends GlobalBase implements Serializable {
		private static final long serialVersionUID = 1L;
	private static Global instance;

	public Global(String archivo) {
		super(archivo);
	}
	 
	public static synchronized Global getInstance() {
		if (instance == null) {
			instance = new Global("com.tmmas.scl.operations.crm.fab.cim.manreq.web.properties.web");
		}
		return instance;
	}
/*
	private static final long serialVersionUID = 1L;

	private MessageResourcesConfig recurso;

	private static Global instance;

	private static Logger logger = Logger.getLogger(Global.class);

	private final String archivoRecurso = "com.tmmas.scl.operations.crm.fab.cim.manreq.web.properties.web";

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
	
	public String getJndiFactory()
	{
		return this.recurso.obtenerValorClave("jndi.Factory");
	}	
	
	public String getJndiQueueOrdenServicio()
	{
		return this.recurso.obtenerValorClave("queue.OrdenServicio");
	}	
	
}
