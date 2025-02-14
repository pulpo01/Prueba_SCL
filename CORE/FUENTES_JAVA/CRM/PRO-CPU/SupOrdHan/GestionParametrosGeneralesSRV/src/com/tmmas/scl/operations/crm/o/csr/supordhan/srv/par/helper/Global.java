package com.tmmas.scl.operations.crm.o.csr.supordhan.srv.par.helper;

import java.io.Serializable;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.util.MessageResourcesConfig;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.dataTransferObject.GlobalBase;

public class Global extends GlobalBase implements Serializable{
	private static final long serialVersionUID = 1L;
	private static Global instance;

	public Global(String archivo) {
		super(archivo);
	}
	 
	public static synchronized Global getInstance() {
		if (instance == null) {
			instance = new Global("com.tmmas.scl.operations.crm.o.csr.supordhan.srv.par.properties.service");
		}
		return instance;
	}	
}



