package com.tmmas.gte.integraciongtecommon.dto;

import java.io.Serializable;

public class EntServSupleDTO  implements Serializable {
	private static final long serialVersionUID = 1L;

	private	 String  codServicio;

	public static long getSerialVersionUID() {
		return serialVersionUID;
	}

	public String getCodServicio() {
		return codServicio;
	}

	public void setCodServicio(String codServicio) {
		this.codServicio = codServicio;
	}

		
}
