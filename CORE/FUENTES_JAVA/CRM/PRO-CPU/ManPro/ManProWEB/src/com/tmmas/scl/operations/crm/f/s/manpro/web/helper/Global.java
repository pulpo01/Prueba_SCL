/**
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 18/05/2007	     	Elizabeth Vera        				Versión Inicial
 * 
 */
package com.tmmas.scl.operations.crm.f.s.manpro.web.helper;

import java.io.Serializable;


import com.tmmas.cl.framework.util.MessageResourcesConfig;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.dataTransferObject.GlobalBase;

public class Global extends GlobalBase implements Serializable {
		private static final long serialVersionUID = 1L;
	private static Global instance;

	public Global(String archivo) {
		super(archivo);
	}
	 
	public static synchronized Global getInstance() {
		if (instance == null) {
			instance = new Global("com.tmmas.scl.operations.crm.f.s.manpro.web.properties.web");
		}
		return instance;
	}
		
	public String getJndiFactory()
	{
		return this.recurso.obtenerValorClave("jndi.Factory");
	}	
	
	public String getJndiQueueVenta()
	{
		return this.recurso.obtenerValorClave("queue.Venta");
	}	
	
}
