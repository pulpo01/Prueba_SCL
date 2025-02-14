package com.tmmas.cl.scl.spnsclwscommon.commonapp.dto.retorno;

import java.io.Serializable;

import com.tmmas.cl.scl.spnsclwscommon.commonapp.dto.WsConsSSuplementariosOutDTO;
import com.tmmas.cl.scl.spnsclwscommon.commonapp.dto.WsRespuestaOutDTO;

public class ConsSSuplementariosRetornoDTO implements Serializable{
	
	private static final long serialVersionUID = 1L;
	private WsConsSSuplementariosOutDTO[] ConsSSuplementarios;
	private WsRespuestaOutDTO[] Respuesta; 
	
	
	public WsRespuestaOutDTO[] getRespuesta() {
		return Respuesta;
	}
	public void setRespuesta(WsRespuestaOutDTO[] respuesta) {
		Respuesta = respuesta;
	}
	public WsConsSSuplementariosOutDTO[] getConsSSuplementarios() {
		return ConsSSuplementarios;
	}
	public void setConsSSuplementarios(
			WsConsSSuplementariosOutDTO[] consSSuplementarios) {
		ConsSSuplementarios = consSSuplementarios;
	}
	

}
