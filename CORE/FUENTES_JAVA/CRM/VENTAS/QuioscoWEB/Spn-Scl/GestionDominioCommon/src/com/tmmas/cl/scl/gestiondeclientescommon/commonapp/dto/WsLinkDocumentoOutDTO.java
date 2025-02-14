package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class WsLinkDocumentoOutDTO  extends RetornoDTO implements Serializable {
	private static final long serialVersionUID = 1L;

	private String linkDocumento;

	public String getLinkDocumento() {
		return linkDocumento;
	}

	public void setLinkDocumento(String linkDocumento) {
		this.linkDocumento = linkDocumento;
	}

}
