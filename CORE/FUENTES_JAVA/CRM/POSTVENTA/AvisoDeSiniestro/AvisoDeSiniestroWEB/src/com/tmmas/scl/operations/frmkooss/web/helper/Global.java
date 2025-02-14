/**
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 3/12/2007	     	Daniel Sagredo        				Versión Inicial
 * 
 */
package com.tmmas.scl.operations.frmkooss.web.helper;

import java.io.Serializable;

public class Global extends  com.tmmas.scl.operations.crm.fab.customerinterfacemanagement.common.helper.GlobalBase implements Serializable {
	private static final long serialVersionUID = 1L;
	private static Global instance;

	public Global(String archivo) {
		super(archivo);
	}
	 
	public static synchronized Global getInstance() {
			if (instance == null) {
				instance = new Global("com.tmmas.scl.operations.frmkooss.web.properties.web");
			}
			return instance;
		}


	public String getJndiFactory()
	{
		return this.recurso.obtenerValorClave("jndi.Factory");
	}	
	
	public String getJndiQueueOrdenServicio()
	{
		return this.recurso.obtenerValorClave("queue.OrdenServicio");
	}	
	
}
