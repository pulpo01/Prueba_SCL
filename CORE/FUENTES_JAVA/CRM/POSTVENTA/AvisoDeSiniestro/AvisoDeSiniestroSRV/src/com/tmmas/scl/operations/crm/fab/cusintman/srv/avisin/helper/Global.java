package com.tmmas.scl.operations.crm.fab.cusintman.srv.avisin.helper;

import java.io.Serializable;

public class Global extends  com.tmmas.scl.operations.crm.fab.customerinterfacemanagement.common.helper.GlobalBase implements Serializable {
	private static final long serialVersionUID = 1L;
	private static Global instance;

	public Global(String archivo) {
		super(archivo);
	}
	 
	public static synchronized Global getInstance() {
			if (instance == null) {
				instance = new Global("com.tmmas.scl.operations.crm.fab.cusintman.srv.avisin.properties.service");
			}
			return instance;
		}

}
