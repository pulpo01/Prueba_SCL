package com.tmmas.scl.operations.crm.f.sel.negsal.helper;

import java.io.Serializable;

import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.dataTransferObject.GlobalBase;

public class GlobalFrmk extends GlobalBase implements Serializable{
		private static final long serialVersionUID = 1L;
		private static GlobalFrmk instance;

		public GlobalFrmk(String archivo) {
			super(archivo);
		}
		 
		public static synchronized GlobalFrmk getInstance() {
			if (instance == null) {
				instance = new GlobalFrmk("com.tmmas.scl.operations.crm.f.sel.negsal.properties.negocio");
			}
			return instance;
		}	
}
