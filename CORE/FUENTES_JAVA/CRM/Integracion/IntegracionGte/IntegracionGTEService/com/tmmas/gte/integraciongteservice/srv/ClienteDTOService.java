/**
* Generated file - you can edit!
* @author Jimmy A. Lopez P.
* @version 1.0
* @xdoclet-generated
*/
package com.tmmas.gte.integraciongteservice.srv;

public interface ClienteDTOService {
	/**
	* Entrega Listado de Clientes por c�digo de Cuenta
	*/
	public com.tmmas.gte.integraciongtecommon.dto.LstCliResponseDTO listarClientes(com.tmmas.gte.integraciongtecommon.dto.DatosLstCliCueDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	/**
	* Entrega Listado de Clientes por n�mero de telefono
	*/
	public com.tmmas.gte.integraciongtecommon.dto.LstCliResponseDTO listarClientes(com.tmmas.gte.integraciongtecommon.dto.NumeroTelefonoDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	/**
	* Entrega n�mero de identificaci�n del cliente (NIT) y el c�digo de tipo de identificaci�n
	*/
	public com.tmmas.gte.integraciongtecommon.dto.LstDatosCliNitDTO consultarDatosCliente(com.tmmas.gte.integraciongtecommon.dto.DatosLstCliCliDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	/**
	* Entrega un listado de datos de cliente a trav�s de un n�mero de tel�fono y c�digo de cliente.
	* M�todo sobrecargado.
	*/
	public com.tmmas.gte.integraciongtecommon.dto.DatosClientePospHibrPrepDTO consultarDatosGenCliente(com.tmmas.gte.integraciongtecommon.dto.NumeroTelefonoDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	/**
	* Entrega un listado de datos de cliente a trav�s de un n�mero de tel�fono y c�digo de cliente.
	* M�todo sobrecargado.
	*/
	public com.tmmas.gte.integraciongtecommon.dto.DatosClienteOutDTO consultarDatosGenCliente(com.tmmas.gte.integraciongtecommon.dto.CodClienteDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	/**
	* Servicio que permite identificar si una persona es de tipo natural o empresa. 
	* Autor: Leonardo Mu�oz R. 
	*/
	public com.tmmas.gte.integraciongtecommon.dto.RespTipoClienteDTO consultarTipoCliente(com.tmmas.gte.integraciongtecommon.dto.NumeroTelefonoDTO inParam0)
		throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	/**
	* Entrega Datos Del segmento del Cliente (Obtener Segmento del Cliente)
	*/
	public com.tmmas.gte.integraciongtecommon.dto.SegmentoClienteResponseDTO obtenerSegmentoCliente(com.tmmas.gte.integraciongtecommon.dto.NumeroTelefonoDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	/**
	* Retorna los Datos del Distribuidor asociado al C�digo de Distribuidor ingresado
	*/
	public com.tmmas.gte.integraciongtecommon.dto.DistribuidorResponseDTO consultarDatosDistribuidor(com.tmmas.gte.integraciongtecommon.dto.ConsDistribuidorInDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	/**
	* Retorna los Datos del Distribuidor y datos del Pedido asociados al C�digo de Distribuidor y C�digo de Pedido ingresado
	*/
	public com.tmmas.gte.integraciongtecommon.dto.DistribPedidoResponseDTO consultarDatosDistribuidor(com.tmmas.gte.integraciongtecommon.dto.DistribPedidoInDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	
}