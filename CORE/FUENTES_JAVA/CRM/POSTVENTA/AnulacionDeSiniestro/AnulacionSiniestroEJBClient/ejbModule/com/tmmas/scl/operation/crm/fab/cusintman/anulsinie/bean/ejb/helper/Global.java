package com.tmmas.scl.operation.crm.fab.cusintman.anulsinie.bean.ejb.helper;

import java.io.Serializable;

public class Global extends  com.tmmas.scl.operations.crm.fab.customerinterfacemanagement.common.helper.GlobalBase implements Serializable {
	private static final long serialVersionUID = 1L;
	private static Global instance;

	public Global(String archivo) {
		super(archivo);
	}
	 
	public static synchronized Global getInstance() {
			if (instance == null) {
				instance = new Global("com.tmmas.scl.operation.crm.fab.cusintman.anulsinie.bean.ejb.properties.negocio");
			}
			return instance;
		}

}
