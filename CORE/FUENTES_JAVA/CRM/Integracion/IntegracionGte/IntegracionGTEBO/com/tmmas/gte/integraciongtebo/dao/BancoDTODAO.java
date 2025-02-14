/**
* Generated file - You can edit!
* @author Jimmy A. Lopez P.
* @version 1.0
* @xdoclet-generated
*/

package com.tmmas.gte.integraciongtebo.dao;

public interface BancoDTODAO {
	/**
	* Ingresa como parametros un objeto de tipo BancoInDTO y despues devuelve un objeto BancoDTO, devuelve la codigo del banco y la descipcion
	*/
	public com.tmmas.gte.integraciongtecommon.dto.BancoDTO consultarBanco(com.tmmas.gte.integraciongtecommon.dto.BancoInDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	/**
	* Entrega datos de los bancos disponibles para la contratación de PAC
	*/
	public com.tmmas.gte.integraciongtecommon.dto.BancoResponseDTO listarBancosDisponibles(com.tmmas.gte.integraciongtecommon.dto.BancoDispInDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
}