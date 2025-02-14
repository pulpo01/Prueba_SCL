package com.tmmas.cl.scl.integracionsicsa.common.dto;

import java.io.Serializable;

public class DatosCorreoDTO implements Serializable{
	
	private static final long serialVersionUID = 1L;

	
	private String ipSmtp;
	private String remitenteMail;
	private String destinosMail;
	
	public String getIpSmtp() {
		return ipSmtp;
	}
	public void setIpSmtp(String ipSmtp) {
		this.ipSmtp = ipSmtp;
	}
	public String getRemitenteMail() {
		return remitenteMail;
	}
	public void setRemitenteMail(String remitenteMail) {
		this.remitenteMail = remitenteMail;
	}
	public String getDestinosMail() {
		return destinosMail;
	}
	public void setDestinosMail(String destinosMail) {
		this.destinosMail = destinosMail;
	}
	

}
