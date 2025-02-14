package com.tmmas.scl.operations.crm.bean.ejb.helper;

import java.io.Serializable;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.util.MessageResourcesConfig;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.dataTransferObject.GlobalBase;

public class Global extends GlobalBase implements Serializable {

	private final String archivoRecurso = "com.tmmas.scl.operations.crm.bean.ejb.properties.negocio";

	private static final long serialVersionUID = 1L;
	private static Global instance;

	public Global(String archivo) {
		super(archivo);
	}
	 
	public static synchronized Global getInstance() {
		if (instance == null) {
			String propertiesCRMEJB = "com.tmmas.scl.operations.crm.bean.ejb.properties.negocio";
			String propertiesExternoPDT = "/com/tmmas/scl/general/PDTDefault.properties";
			instance = new Global(propertiesCRMEJB+"|"+propertiesExternoPDT);
		}
		return instance;
	}

		
}
