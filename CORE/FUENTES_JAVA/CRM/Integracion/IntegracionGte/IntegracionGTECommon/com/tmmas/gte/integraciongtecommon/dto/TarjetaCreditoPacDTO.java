package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;


public class TarjetaCreditoPacDTO  implements Serializable {

	private static final long serialVersionUID = 1L;
	private String  codTipTarjeta;
	private String  desTipTarjeta;
	
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}
	public String getCodTipTarjeta() {
		return codTipTarjeta;
	}
	public void setCodTipTarjeta(String codTipTarjeta) {
		this.codTipTarjeta = codTipTarjeta;
	}
	public String getDesTipTarjeta() {
		return desTipTarjeta;
	}
	public void setDesTipTarjeta(String desTipTarjeta) {
		this.desTipTarjeta = desTipTarjeta;
	}
	
	
		
	
	

}