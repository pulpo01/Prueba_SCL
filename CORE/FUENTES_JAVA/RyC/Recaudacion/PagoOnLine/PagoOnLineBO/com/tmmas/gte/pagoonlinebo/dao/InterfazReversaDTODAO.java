/**
* Generated file - You can edit!
* @author Jimmy A. Lopez P.
* @version 1.0
* @xdoclet-generated
*/

package com.tmmas.gte.pagoonlinebo.dao;

public interface InterfazReversaDTODAO {
	/**
	* Valida que el Pago a reversar exista (CO_INTERFAZ_PAGOS)
	*/
	public com.tmmas.gte.pagoonlinecommon.dto.RespuestaDTO validaReversa(com.tmmas.gte.pagoonlinecommon.dto.InterfazReversaDTO inParam0)
			 throws com.tmmas.gte.pagoonlinecommon.exception.PagoOnLineException;
	/**
	* Inserta Reversa en la Interfaz de Pago (CO_INTERFAZ_PAGOS)
	*/
	public com.tmmas.gte.pagoonlinecommon.dto.RespuestaDTO aplicaReversa(com.tmmas.gte.pagoonlinecommon.dto.InterfazReversaDTO inParam0)
			 throws com.tmmas.gte.pagoonlinecommon.exception.PagoOnLineException;

}