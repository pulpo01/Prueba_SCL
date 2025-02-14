/**
* Generated file - You can edit!
* @author Jimmy A. Lopez P.
* @version 1.0
* @xdoclet-generated
*/

package com.tmmas.gte.integraciongtebo.dao;

public interface ConsAbonadoPospagoDTODAO {
	/**
	* Retorna numAbonado y codCliente a partir de un numCelular pospago
	*/
	public com.tmmas.gte.integraciongtecommon.dto.AbonadoPospagoOutDTO consultarAbonadoPospago(com.tmmas.gte.integraciongtecommon.dto.NumeroTelefonoDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;

}