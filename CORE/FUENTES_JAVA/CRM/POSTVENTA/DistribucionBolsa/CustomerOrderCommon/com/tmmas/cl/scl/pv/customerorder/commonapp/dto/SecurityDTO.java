package com.tmmas.cl.scl.pv.customerorder.commonapp.dto;


import java.io.Serializable;

public class SecurityDTO implements Serializable{
	private static final long serialVersionUID = 1L;
	private String key;
	private String userName;

	public String getKey() {
		return key;
	}

	public void setKey(String key) {
		this.key = key;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}
}
