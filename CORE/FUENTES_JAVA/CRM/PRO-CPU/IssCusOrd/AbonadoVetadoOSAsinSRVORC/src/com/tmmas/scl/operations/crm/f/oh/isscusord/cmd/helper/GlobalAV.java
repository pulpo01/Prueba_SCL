package com.tmmas.scl.operations.crm.f.oh.isscusord.cmd.helper;

import java.io.Serializable;

import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.dataTransferObject.GlobalBase;

public class GlobalAV extends GlobalBase implements Serializable{
	private static final long serialVersionUID = 1L;
	private static GlobalAV instance;

	public GlobalAV(String archivo) {
		super(archivo);
	}
	 
	public static synchronized GlobalAV getInstance() {
		if (instance == null) {
			instance = new GlobalAV("com.tmmas.scl.operations.crm.f.oh.isscusord.cmd.properties.cmdAV");
		}
		return instance;
	}
}
