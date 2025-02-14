package com.tmmas.scl.operations.crm.fab.cim.manreq.web.form;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Category;
import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

public class ProductosContratadosFrecForm extends ActionForm {
	
	private long numCelular;

	public long getNumCelular() {
		return numCelular;
	}

	public void setNumCelular(long numCelular) {
		this.numCelular = numCelular;
	}
	
}
