/**
* Generated file - You can edit!
* @author Jimmy A. Lopez P.
* @version 1.0
* @xdoclet-generated
*/

package com.tmmas.gte.integraciongtebo.dao;

public interface AbonadoDTODAO {
	/**
	* Entrega Datos del Abonado
	*/
	public com.tmmas.gte.integraciongtecommon.dto.AbonadoOutDTO consultarAbonadoCliTel(com.tmmas.gte.integraciongtecommon.dto.EsClieTelefDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	/**
	* retorna el numero de Cliente
	*/
	public com.tmmas.gte.integraciongtecommon.dto.AbonadoOutDTO consultarAbonadoTelefono(com.tmmas.gte.integraciongtecommon.dto.EsTelefIgualClieDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;	 
	/**
	* Retorna numAbonado y codCliente a partir de un numCelular pospago o hibrido
	*/
	public com.tmmas.gte.integraciongtecommon.dto.AbonadoPospagoOutDTO consAbonadoPospagoHibrido(com.tmmas.gte.integraciongtecommon.dto.NumeroPlanTarifDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	
	/**
	* Consulta la fecha de Alta de un numero ingresado
	*/
	public com.tmmas.gte.integraciongtecommon.dto.AltaPrepagoResponseDTO consultarFechaAlta(com.tmmas.gte.integraciongtecommon.dto.AltaPrepagoDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;

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
	
	/**
	* se ingresa un código de OOSS y un numero de abonado, el metodo retorna el OrdenServicioOutDTO
	*/
	public com.tmmas.gte.integraciongtecommon.dto.OrdenServicioOutDTO consultarOOSSEjec(com.tmmas.gte.integraciongtecommon.dto.OrdenServicioDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	
	/**
	* se ingresa un código de orden de servicio y un numero de orden de servicio, el metodo retorna el ConsRenovacionDTO
	*/
	public com.tmmas.gte.integraciongtecommon.dto.ConsRenovacionDTO consultarIndRenova(com.tmmas.gte.integraciongtecommon.dto.OrdenServicioDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	
	
	
}