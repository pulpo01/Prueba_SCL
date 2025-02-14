package com.tmmas.scl.framework.customerDomain.dataTransferObject;

import java.io.Serializable;

public class ConfiguradorTareasDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	private boolean prebilling;
	public boolean isPrebilling() {
		return prebilling;
	}
	public void setPrebilling(boolean prebilling) {
		this.prebilling = prebilling;
	}
	
}
