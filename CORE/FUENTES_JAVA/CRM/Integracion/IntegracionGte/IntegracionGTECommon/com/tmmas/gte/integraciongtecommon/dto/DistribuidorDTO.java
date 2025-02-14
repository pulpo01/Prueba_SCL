package com.tmmas.gte.integraciongtecommon.dto;

import java.io.Serializable;

/**
* 
* @tmas.legacy.jdbc.storedprocedure id = "consDatosDistrib" package = "GE_INTEGRACION_PG" sp = "ge_obtener_datos_distrib_pr"
* jndiProperty = "IntegracionGteSclDs"
* servicioMetodo = "consDatosDistrib"
* servicioPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroEntrada = "DistribuidorDTO"
* servicioPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroSalida = "DistribuidorResponseDTO"
* comentario = "Retorna los Datos del Distribuidor asociado al Código de Distribuidor ingresado"
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consDatosDistrib"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "DistribuidorDTO" mappingProperty = "codDistribuidor" parentProperty = ""
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consDatosDistrib" clase="salida" name="" tipo="VARCHAR" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "DistribuidorResponseDTO" mappingProperty = "nomVendedor" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consDatosDistrib" clase="salida" name="" tipo="VARCHAR" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "DistribuidorResponseDTO" mappingProperty = "codTipident" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consDatosDistrib" clase="salida" name="" tipo="VARCHAR" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "DistribuidorResponseDTO" mappingProperty = "desTipident" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consDatosDistrib" clase="salida" name="" tipo="VARCHAR" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "DistribuidorResponseDTO" mappingProperty = "numIdent" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consDatosDistrib" clase="salida" name="" tipo="VARCHAR" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "DistribuidorResponseDTO" mappingProperty = "codCliente" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consDatosDistrib" clase="salida" name="" tipo="VARCHAR" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "DistribuidorResponseDTO" mappingProperty = "codTipContrato" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consDatosDistrib" clase="salida" name="" tipo="VARCHAR" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "DistribuidorResponseDTO" mappingProperty = "desTipContrato" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consDatosDistrib" clase="salida" name="" tipo="VARCHAR" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "DistribuidorResponseDTO" mappingProperty = "numContrato" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consDatosDistrib" clase="salida" name="" tipo="VARCHAR" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "DistribuidorResponseDTO" mappingProperty = "numAnexo"
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consDatosDistrib" clase="salida" name="" tipo="DATE" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "DistribuidorResponseDTO" mappingProperty = "fecContrato"
*
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consDatosDistrib" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "codigoError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consDatosDistrib" clase="salida" name="" tipo="VARCHAR" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "mensajeError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consDatosDistrib" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "numeroEvento"
*
*
*
*
* @tmas.legacy.jdbc.storedprocedure id = "consBodegasDistrib" package = "GE_INTEGRACION_PG" sp = "ge_obtener_bodegas_distrib_pr"
* jndiProperty = "IntegracionGteSclDs"
* servicioMetodo = "consBodegasDistrib"
* servicioPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroEntrada = "DistribuidorDTO"
* servicioPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroSalida = "DistribBodegasResponseDTO"
* comentario = "Retorna un listado de Bodegas asociadas al Código de Distribuidor ingresado"
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consBodegasDistrib"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "DistribuidorDTO" mappingProperty = "codDistribuidor" parentProperty = ""
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consBodegasDistrib"   clase="salida" name="CURSOROUT" tipo="CURSOR"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "DistribBodegasDTO" mappingProperty = "" parentProperty = "listBodegas"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consBodegasDistrib" name="CURSOROUT" mappingProperty = "codBodega" mappingField = "cod_bodega"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consBodegasDistrib" name="CURSOROUT" mappingProperty = "desBodega" mappingField = "des_bodega"
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consBodegasDistrib" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "codigoError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consBodegasDistrib" clase="salida" name="" tipo="VARCHAR" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "mensajeError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consBodegasDistrib" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "numeroEvento"
* 
*  
*  
* @tmas.legacy.jdbc.storedprocedure id = "consPedidoDistrib" package = "GE_INTEGRACION_PG" sp = "ge_obtener_pedido_distrib_pr"
* jndiProperty = "IntegracionGteSclDs"
* servicioMetodo = "consPedidoDistrib"
* servicioPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroEntrada = "DistribuidorDTO"
* servicioPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroSalida = "DistribPedidoResponseDTO"
* comentario = "Retorna los Datos del Pedido asociados al Código de Distribuidor y Código de Pedido ingresado"
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consPedidoDistrib"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "DistribuidorDTO" mappingProperty = "codClienteDistrib" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consPedidoDistrib"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "DistribuidorDTO" mappingProperty = "codPedido" parentProperty = ""
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consPedidoDistrib" clase="salida" name="" tipo="NUMERIC" parentProperty = "datosPedido"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "DistribPedidoDTO" mappingProperty = "mtoNetoPedido" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consPedidoDistrib" clase="salida" name="" tipo="NUMERIC" parentProperty = "datosPedido"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "DistribPedidoDTO" mappingProperty = "cantTotalPedido" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consPedidoDistrib" clase="salida" name="" tipo="NUMERIC" parentProperty = "datosPedido"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "DistribPedidoDTO" mappingProperty = "mtoTotalPedido" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consPedidoDistrib" clase="salida" name="" tipo="NUMERIC" parentProperty = "datosPedido"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "DistribPedidoDTO" mappingProperty = "codBodega" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consPedidoDistrib" clase="salida" name="" tipo="VARCHAR" parentProperty = "datosPedido"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "DistribPedidoDTO" mappingProperty = "desBodega" 
*
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consPedidoDistrib" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "codigoError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consPedidoDistrib" clase="salida" name="" tipo="VARCHAR" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "mensajeError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consPedidoDistrib" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "numeroEvento"
*
*
* @tmas.legacy.jdbc.storedprocedure id = "consultarDistribuidor" package = "GE_INTEGRACION_PG" sp = "GE_CONS_DISTRIBUIDOR_PR"
* jndiProperty = "IntegracionGteSclDs"
* servicioMetodo = "consultarDistribuidor"
* servicioPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroEntrada = "DistribuidorDTO"
* servicioPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroSalida = "DistribuidorDTO"
* comentario = "ingresa el codigo del distribuidor para sacar el codigo del cliente"
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarDistribuidor"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"  mappingParametroEntrada = "DistribuidorDTO"  mappingProperty = "codVendedor" parentProperty = ""
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarDistribuidor"   clase="salida" name="" tipo="NUMERIC" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "DistribuidorDTO" mappingProperty = "codCliente" 
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarDistribuidor" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "codigoError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarDistribuidor" clase="salida" name="" tipo="VARCHAR" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "mensajeError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarDistribuidor" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "numeroEvento"
*
*
*/

public class DistribuidorDTO implements Serializable  {
    /**
	 * Autor : Alejandro Lorca
	 */
	private static final long serialVersionUID = 1L;

    private long codDistribuidor;
    private long codClienteDistrib;
    private long codPedido;
    private long   codVendedor;    
    private long   codCliente;
    private RespuestaDTO respuesta;
    
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}
	public long getCodClienteDistrib() {
		return codClienteDistrib;
	}
	public void setCodClienteDistrib(long codClienteDistrib) {
		this.codClienteDistrib = codClienteDistrib;
	}
	public long getCodDistribuidor() {
		return codDistribuidor;
	}
	public void setCodDistribuidor(long codDistribuidor) {
		this.codDistribuidor = codDistribuidor;
	}
	public long getCodPedido() {
		return codPedido;
	}
	public void setCodPedido(long codPedido) {
		this.codPedido = codPedido;
	}
	public long getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(long codCliente) {
		this.codCliente = codCliente;
	}
	public long getCodVendedor() {
		return codVendedor;
	}
	public void setCodVendedor(long codVendedor) {
		this.codVendedor = codVendedor;
	}
	public RespuestaDTO getRespuesta() {
		return respuesta;
	}
	public void setRespuesta(RespuestaDTO respuesta) {
		this.respuesta = respuesta;
	}

}