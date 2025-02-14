package com.tmmas.cl.scl.crmcommon.commonapp.dto;

import java.io.Serializable;

public class TiposContratoListOutDTO implements Serializable
{

private static final long serialVersionUID = 1L;
private TipoContratoDTO allTipoContratoDTO[];
private Long codError;
private String msgError;
private Long codEvento;


public TipoContratoDTO[] getAllTipoContratoDTO() {
	return allTipoContratoDTO;
}
public void setAllTipoContratoDTO(TipoContratoDTO[] allTipoContratoDTO) {
	this.allTipoContratoDTO = allTipoContratoDTO;
}
public Long getCodError() {
	return codError;
}
public void setCodError(Long codError) {
	this.codError = codError;
}
public Long getCodEvento() {
	return codEvento;
}
public void setCodEvento(Long codEvento) {
	this.codEvento = codEvento;
}
public String getMsgError() {
	return msgError;
}
public void setMsgError(String msgError) {
	this.msgError = msgError;
}

}	
