package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class WsArticuloStockOutDTO  extends RetornoDTO implements Serializable {
	private static final long serialVersionUID = 1L;

	private String ackNack;

	public String getAckNack() {
		return ackNack;
	}

	public void setAckNack(String ackNack) {
		this.ackNack = ackNack;
	}
}