package com.tmmas.scl.operations.crm.common.dataTransferObject;

import java.io.Serializable;

import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;

public class RetornoConTokenDTO extends RetornoDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private String token;

	public String getToken() {
		return token;
	}

	public void setToken(String token) {
		this.token = token;
	}


}
