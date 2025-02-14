/**
* Generated file - You can edit!
* @author Jimmy A. Lopez P.
* @version 1.0
* @xdoclet-generated
*/

package com.tmmas.gte.integraciongtebo.dao;

public interface ClienteDTODAO {
	/**
	* Entrega Listado de Clientes por número de identificación del cliente (NIT) y el código de tipo de identificación
	*/
	public com.tmmas.gte.integraciongtecommon.dto.LstCliResponseDTO listarClientes(com.tmmas.gte.integraciongtecommon.dto.DatosLstCliNitDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	/**
	* Entrega Listado de Clientes por código de Cuenta
	*/
	public com.tmmas.gte.integraciongtecommon.dto.LstCliResponseDTO listarClientes(com.tmmas.gte.integraciongtecommon.dto.DatosLstCliCueDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	/**
	* Entrega número de identificación del cliente (NIT) y el código de tipo de identificación
	*/
	public com.tmmas.gte.integraciongtecommon.dto.LstDatosCliNitDTO consultarDatosCliente(com.tmmas.gte.integraciongtecommon.dto.DatosLstCliCliDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	/**
	* 
	*/
	public com.tmmas.gte.integraciongtecommon.dto.DatosClienteResponseDTO consultarClientePospago(com.tmmas.gte.integraciongtecommon.dto.NumeroTelefonoDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	/**
	* 
	*/
	public com.tmmas.gte.integraciongtecommon.dto.DatosClienteResponseDTO consultarClientePrepago(com.tmmas.gte.integraciongtecommon.dto.NumeroTelefonoDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	/**
	* 
	*/
	public com.tmmas.gte.integraciongtecommon.dto.DatosClienteResponseDTO consultarClienteXCodigo(com.tmmas.gte.integraciongtecommon.dto.CodClienteDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	/**
	* 
	*/
	public com.tmmas.gte.integraciongtecommon.dto.DatosClienteResponseDTO consultarTipoCliente(com.tmmas.gte.integraciongtecommon.dto.CodClienteDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	/**
	* Entrega segmento del Cliente (Obtener Segmento del Cliente)
	*/
	public com.tmmas.gte.integraciongtecommon.dto.SegmentoClienteResponseDTO obtenerSegmentoCliente(com.tmmas.gte.integraciongtecommon.dto.CodClienteDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	/**
	* Consulta si Cliente es Facturable
	*/
	public com.tmmas.gte.integraciongtecommon.dto.RespBooleanDTO validarClieFacturable(com.tmmas.gte.integraciongtecommon.dto.ConsClieFacturableDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	/**
	* Retorna los Datos del Distribuidor asociado al Código de Distribuidor ingresado
	*/
	public com.tmmas.gte.integraciongtecommon.dto.DistribuidorResponseDTO consultarDatosDistrib(com.tmmas.gte.integraciongtecommon.dto.DistribuidorDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	/**
	* Retorna un listado de Bodegas asociadas al Código de Distribuidor ingresado
	*/
	public com.tmmas.gte.integraciongtecommon.dto.DistribBodegasResponseDTO consultarBodegasDistrib(com.tmmas.gte.integraciongtecommon.dto.DistribuidorDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	/**
	* Retorna los Datos del Pedido asociados al Código de Distribuidor y Código de Pedido ingresado
	*/
	public com.tmmas.gte.integraciongtecommon.dto.DistribPedidoResponseDTO consultarPedidoDistrib(com.tmmas.gte.integraciongtecommon.dto.DistribuidorDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	/**
	* ingresa el codigo del distribuidor para sacar el codigo del cliente
	*/
	public com.tmmas.gte.integraciongtecommon.dto.DistribuidorDTO consultarDistribuidor(com.tmmas.gte.integraciongtecommon.dto.DistribuidorDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;

			 
}