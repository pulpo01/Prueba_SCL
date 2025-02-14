package com.tmmas.scl.framework.ProductDomain.dto;

import java.io.Serializable;

public class SolicitudAvisoDeSiniestroDTO implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private long num_solucionequipo;
	private long num_solucionSimcard;
	
	public long getNum_solucionequipo() {
		return num_solucionequipo;
	}
	public void setNum_solucionequipo(long num_solucionequipo) {
		this.num_solucionequipo = num_solucionequipo;
	}
	public long getNum_solucionSimcard() {
		return num_solucionSimcard;
	}
	public void setNum_solucionSimcard(long num_solucionSimcard) {
		this.num_solucionSimcard = num_solucionSimcard;
	}
	

}
