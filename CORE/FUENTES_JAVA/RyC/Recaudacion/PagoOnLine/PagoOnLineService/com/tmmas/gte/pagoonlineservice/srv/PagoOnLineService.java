package com.tmmas.gte.pagoonlineservice.srv;

public interface PagoOnLineService {

	public com.tmmas.gte.pagoonlinecommon.dto.RespuestaPagoDTO aplicaPagoOnLine(com.tmmas.gte.pagoonlinecommon.dto.PagoDTO inParam0)
	 throws com.tmmas.gte.pagoonlinecommon.exception.PagoOnLineException;
	
	public com.tmmas.gte.pagoonlinecommon.dto.RespuestaReversaDTO reversarPagoOnLine(com.tmmas.gte.pagoonlinecommon.dto.ReversaDTO inParam0)
	 throws com.tmmas.gte.pagoonlinecommon.exception.PagoOnLineException;	
}
