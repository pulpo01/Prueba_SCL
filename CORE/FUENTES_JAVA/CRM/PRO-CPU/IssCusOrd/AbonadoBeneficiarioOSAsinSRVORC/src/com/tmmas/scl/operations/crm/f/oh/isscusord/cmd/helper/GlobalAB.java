package com.tmmas.scl.operations.crm.f.oh.isscusord.cmd.helper;

import java.io.Serializable;

import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.dataTransferObject.GlobalBase;

public class GlobalAB extends GlobalBase implements Serializable{
	private static final long serialVersionUID = 1L;
	private static GlobalAB instance;

	public GlobalAB(String archivo) {
		super(archivo);
	}
	 
	public static synchronized GlobalAB getInstance() {
		if (instance == null) {
			instance = new GlobalAB("com.tmmas.scl.operations.crm.f.oh.isscusord.cmd.properties.cmdAB");
		}
		return instance;
	}
}
