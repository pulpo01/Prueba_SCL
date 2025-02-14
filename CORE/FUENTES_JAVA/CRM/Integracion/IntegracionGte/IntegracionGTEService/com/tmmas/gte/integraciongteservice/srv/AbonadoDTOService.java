/**
* Generated file - you can edit!
* @author Jimmy A. Lopez P.
* @version 1.0
* @xdoclet-generated
*/
package com.tmmas.gte.integraciongteservice.srv;

public interface AbonadoDTOService {

	/**
	* Entrega Datos del Abonado
	*/
	public com.tmmas.gte.integraciongtecommon.dto.RespBooleanDTO validarClienteTelefono(com.tmmas.gte.integraciongtecommon.dto.EsClieTelefDTO inParam0)
	 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;

	/**
	* retorna el numero de Cliente
	*/
	public com.tmmas.gte.integraciongtecommon.dto.RespBooleanDTO validarTelIgualCli(com.tmmas.gte.integraciongtecommon.dto.EsTelefIgualClieDTO inParam0)
		throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	
	/**
	* Entrega Tecnología según número de teléfono del Abonado
	*/ 
	public com.tmmas.gte.integraciongtecommon.dto.TecnologiaDTO consultarTecnologia(com.tmmas.gte.integraciongtecommon.dto.NumeroTelefonoDTO inParam0)
		throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	/**
	* Valida Numero de Telefono Pospago o Hibrido
	*/
	public com.tmmas.gte.integraciongtecommon.dto.RespBooleanDTO validarNumPospagoHibrido(com.tmmas.gte.integraciongtecommon.dto.NumeroPlanTarifDTO inParam0)
	 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	/**
	 * Servicio que permite retornar el tipo de abonado (pospago, hibrido, prepago) asociado a un número de teléfono.
	 */
	public com.tmmas.gte.integraciongtecommon.dto.ConsultarTipoAbonadoResponseDTO consultarTipoAbonado(com.tmmas.gte.integraciongtecommon.dto.NumeroTelefonoDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	/**
	* Consulta la fecha de Alta de un numero ingresado
	*/
	public com.tmmas.gte.integraciongtecommon.dto.AltaPrepagoResponseDTO consultarFechaAltaPrepago(com.tmmas.gte.integraciongtecommon.dto.NumeroTelefonoDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	/**
	* se ingresa un numero de abonado, el metodo retorna el BloqueoDTO Los datos correspondiente
	*/
	public com.tmmas.gte.integraciongtecommon.dto.BloqueoResponseDTO consultarBloqueoTelefono(com.tmmas.gte.integraciongtecommon.dto.NumeroTelefonoDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	
	/**
	* Servicio que permite consultar si el último cambio de equipo realizado fue ejecutado por el módulo de renovación y obtener los datos asociados al cambio de equipo.
	*/
	public com.tmmas.gte.integraciongtecommon.dto.ConsRenovacionDTO consultarDatosRenovacion(com.tmmas.gte.integraciongtecommon.dto.NumeroTelefonoDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;

}