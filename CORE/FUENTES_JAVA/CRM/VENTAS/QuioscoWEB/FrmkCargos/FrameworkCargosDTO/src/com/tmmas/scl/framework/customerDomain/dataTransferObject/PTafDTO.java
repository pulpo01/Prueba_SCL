package com.tmmas.scl.framework.customerDomain.dataTransferObject;

import java.io.Serializable;

public class PTafDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	int cod;
	String desc;
	public int getCod() {
		return cod;
	}
	public void setCod(int cod) {
		this.cod = cod;
	}
	public String getDesc() {
		return desc;
	}
	public void setDesc(String desc) {
		this.desc = desc;
	}
	

}
