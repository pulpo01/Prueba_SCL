/**
* Generated file - You can edit!
* @author Jimmy A. Lopez P.
* @version 1.0
* @xdoclet-generated
*/

package com.tmmas.gte.integraciongtebo.dao;

public interface BloqueoDTODAO {
	/**
	* se ingresa un numero de abonado, el metodo retorna el BloqueoDTO Los datos correspondiente a pospago
	*/
	public com.tmmas.gte.integraciongtecommon.dto.BloqueoDTO consultarBloqueoTelefonoPospago(com.tmmas.gte.integraciongtecommon.dto.BloqueoInDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	
	/**
	* se ingresa un numero de abonado, el metodo retorna el BloqueoDTO Los datos correspondiente a prepago
	*/
	public com.tmmas.gte.integraciongtecommon.dto.BloqueoDTO consultarBloqueoTelefonoPrepago(com.tmmas.gte.integraciongtecommon.dto.BloqueoInDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	

}