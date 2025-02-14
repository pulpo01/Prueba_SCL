package com.tmmas.gte.integraciongtecommon.dto;

import java.io.Serializable;
import java.util.Date;


/**
* 
* @tmas.legacy.jdbc.storedprocedure id = "listadoClientes" package = "GE_INTEGRACION_PG" sp = "ge_listar_cli_cuenta_pr"
* jndiProperty = "IntegracionGteSclDs"
* servicioMetodo = "listadoClientes"
* servicioPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroEntrada = "DatosLstCliCueDTO"
* servicioPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroSalida = "LstCliResponseDTO"
* comentario = "Entrega Listado de Clientes por código de Cuenta"
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "listadoClientes"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "DatosLstCliCueDTO" mappingProperty = "codCuenta" parentProperty = ""  
*  
* @tmas.legacy.jdbc.storedprocedure.parametro id = "listadoClientes"   clase="salida" name="CURSOROUT" tipo="CURSOR"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "ClienteAuxDTO" mappingProperty = "" parentProperty = "listadoClientes"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "listadoClientes" name="CURSOROUT" mappingProperty = "codCuenta" mappingField = "cod_cuenta" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "listadoClientes" name="CURSOROUT" mappingProperty = "codCliente" mappingField = "cod_cliente" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "listadoClientes" name="CURSOROUT" mappingProperty = "nomCliente" mappingField = "nom_cliente"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "listadoClientes" name="CURSOROUT" mappingProperty = "nomApeClien1" mappingField = "nom_apeclien1"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "listadoClientes" name="CURSOROUT" mappingProperty = "nomApeClien2" mappingField = "nom_apeclien2"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "listadoClientes" name="CURSOROUT" mappingProperty = "codTipo" mappingField = "cod_tipo"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "listadoClientes" name="CURSOROUT" mappingProperty = "desValor" mappingField = "des_valor"
* 
*    
* @tmas.legacy.jdbc.storedprocedure.parametro id = "listadoClientes" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "codigoError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "listadoClientes" clase="salida" name="" tipo="VARCHAR" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "mensajeError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "listadoClientes" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "numeroEvento"
* 
* @tmas.legacy.jdbc.storedprocedure id = "consultarDatosCliente" package = "GE_INTEGRACION_PG" sp = "ge_cons_datos_cli_cod_pr"
* jndiProperty = "IntegracionGteSclDs"
* servicioMetodo = "consultarDatosCliente"
* servicioPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroEntrada = "DatosLstCliCliDTO"
* servicioPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroSalida = "LstDatosCliNitDTO"
* comentario = "Entrega número de identificación del cliente (NIT) y el código de tipo de identificación"
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarDatosCliente"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "DatosLstCliCliDTO" mappingProperty = "codCliente" parentProperty = ""  
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarDatosCliente" clase="salida" name="" tipo="VARCHAR" parentProperty = "listadoClientes"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "DatosCliNitDTO" mappingProperty = "numIdem" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarDatosCliente" clase="salida" name="" tipo="VARCHAR" parentProperty = "listadoClientes"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "DatosCliNitDTO" mappingProperty = "codTipIdent"
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarDatosCliente" clase="salida" name="" tipo="NUMERIC" parentProperty = "listadoClientes"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "DatosCliNitDTO" mappingProperty = "codCiclo"      
*  
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarDatosCliente" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "codigoError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarDatosCliente" clase="salida" name="" tipo="VARCHAR" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "mensajeError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarDatosCliente" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "numeroEvento"
* 
* @tmas.legacy.jdbc.storedprocedure id = "consultarClientePospago" package = "GE_INTEGRACION_PG" sp = "GE_CONS_CLIE_POS_PR"
* jndiProperty = "IntegracionGteSclDs"
* servicioMetodo = "consultarClientePospago"
* servicioPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroEntrada = "ClienteTelInDTO"
* servicioPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroSalida = "DatosClienteResponseDTO"
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarClientePospago" clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "ClienteTelInDTO" mappingProperty = "numeroTelefono" parentProperty = ""
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarClientePospago" clase="salida" name="" tipo="DATE" parentProperty = "datosCliente"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "ClienteDTO" mappingProperty = "sysDate"
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarClientePospago" clase="salida" name="" tipo="NUMERIC" parentProperty = "datosCliente"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "ClienteDTO" mappingProperty = "numCelular"
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarClientePospago" clase="salida" name="" tipo="NUMERIC" parentProperty = "datosCliente"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "ClienteDTO" mappingProperty = "codCliente"
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarClientePospago" clase="salida" name="" tipo="DATE" parentProperty = "datosCliente"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "ClienteDTO" mappingProperty = "fecAlta"
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarClientePospago" clase="salida" name="" tipo="DATE" parentProperty = "datosCliente"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "ClienteDTO" mappingProperty = "fecFincontra"
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarClientePospago" clase="salida" name="" tipo="VARCHAR" parentProperty = "datosCliente"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "ClienteDTO" mappingProperty = "nomCliente"
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarClientePospago" clase="salida" name="" tipo="VARCHAR" parentProperty = "datosCliente"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "ClienteDTO" mappingProperty = "nomApeclien1"
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarClientePospago" clase="salida" name="" tipo="VARCHAR" parentProperty = "datosCliente"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "ClienteDTO" mappingProperty = "nomApeclien2"
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarClientePospago" clase="salida" name="" tipo="VARCHAR" parentProperty = "datosCliente"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "ClienteDTO" mappingProperty = "numIdent"
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarClientePospago" clase="salida" name="" tipo="VARCHAR" parentProperty = "datosCliente"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "ClienteDTO" mappingProperty = "codTipident"
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarClientePospago" clase="salida" name="" tipo="VARCHAR" parentProperty = "datosCliente"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "ClienteDTO" mappingProperty = "desNit"
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarClientePospago" clase="salida" name="" tipo="VARCHAR" parentProperty = "datosCliente"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "ClienteDTO" mappingProperty = "numIdent2"
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarClientePospago" clase="salida" name="" tipo="VARCHAR" parentProperty = "datosCliente"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "ClienteDTO" mappingProperty = "codTipident2"
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarClientePospago" clase="salida" name="" tipo="VARCHAR" parentProperty = "datosCliente"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "ClienteDTO" mappingProperty = "numIdentapor"
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarClientePospago" clase="salida" name="" tipo="VARCHAR" parentProperty = "datosCliente"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "ClienteDTO" mappingProperty = "codTipidentapor"
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarClientePospago" clase="salida" name="" tipo="DATE" parentProperty = "datosCliente"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "ClienteDTO" mappingProperty = "fecNacimien"
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarClientePospago" clase="salida" name="" tipo="NUMERIC" parentProperty = "datosCliente"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "ClienteDTO" mappingProperty = "codProfesion"
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarClientePospago" clase="salida" name="" tipo="VARCHAR" parentProperty = "datosCliente"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "ClienteDTO" mappingProperty = "codOcupacion"
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarClientePospago" clase="salida" name="" tipo="VARCHAR" parentProperty = "datosCliente"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "ClienteDTO" mappingProperty = "nomApoderado"
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarClientePospago" clase="salida" name="" tipo="VARCHAR" parentProperty = "datosCliente"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "ClienteDTO" mappingProperty = "indEstcivil"
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarClientePospago" clase="salida" name="" tipo="VARCHAR" parentProperty = "datosCliente"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "ClienteDTO" mappingProperty = "estadoCivil"
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarClientePospago" clase="salida" name="" tipo="VARCHAR" parentProperty = "datosCliente"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "ClienteDTO" mappingProperty = "codPais"
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarClientePospago" clase="salida" name="" tipo="VARCHAR" parentProperty = "datosCliente"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "ClienteDTO" mappingProperty = "desPais"
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarClientePospago" clase="salida" name="" tipo="VARCHAR" parentProperty = "datosCliente"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "ClienteDTO" mappingProperty = "codTecnologia"
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarClientePospago" clase="salida" name="" tipo="VARCHAR" parentProperty = "datosCliente"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "ClienteDTO" mappingProperty = "numSerie"
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarClientePospago" clase="salida" name="" tipo="VARCHAR" parentProperty = "datosCliente"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "ClienteDTO" mappingProperty = "numImei"
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarClientePospago" clase="salida" name="" tipo="VARCHAR" parentProperty = "datosCliente"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "ClienteDTO" mappingProperty = "codPlantarif"
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarClientePospago" clase="salida" name="" tipo="VARCHAR" parentProperty = "datosCliente"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "ClienteDTO" mappingProperty = "desPlantarif"
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarClientePospago" clase="salida" name="" tipo="VARCHAR" parentProperty = "datosCliente"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "ClienteDTO" mappingProperty = "codTipo"
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarClientePospago" clase="salida" name="" tipo="VARCHAR" parentProperty = "datosCliente"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "ClienteDTO" mappingProperty = "tipCliente"
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarClientePospago" clase="salida" name="" tipo="VARCHAR" parentProperty = "datosCliente"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "ClienteDTO" mappingProperty = "tefCliente1"
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarClientePospago" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "codigoError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarClientePospago" clase="salida" name="" tipo="VARCHAR" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "mensajeError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarClientePospago" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "numeroEvento"
* 
* @tmas.legacy.jdbc.storedprocedure id = "consultarClientePrepago" package = "GE_INTEGRACION_PG" sp = "GE_CONS_CLIE_PRE_PR"
* jndiProperty = "IntegracionGteSclDs"
* servicioMetodo = "consultarClientePrepago"
* servicioPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroEntrada = "ClienteTelInDTO"
* servicioPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroSalida = "DatosClienteResponseDTO"
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarClientePrepago" clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "ClienteTelInDTO" mappingProperty = "numeroTelefono" parentProperty = ""
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarClientePrepago" clase="salida" name="" tipo="DATE" parentProperty = "datosCliente"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "ClienteDTO" mappingProperty = "sysDate" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarClientePrepago" clase="salida" name="" tipo="NUMERIC" parentProperty = "datosCliente"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "ClienteDTO" mappingProperty = "numCelular" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarClientePrepago" clase="salida" name="" tipo="NUMERIC" parentProperty = "datosCliente"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "ClienteDTO" mappingProperty = "codCliente" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarClientePrepago" clase="salida" name="" tipo="VARCHAR" parentProperty = "datosCliente"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "ClienteDTO" mappingProperty = "nomCliente" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarClientePrepago" clase="salida" name="" tipo="VARCHAR" parentProperty = "datosCliente"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "ClienteDTO" mappingProperty = "nomApeclien1" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarClientePrepago" clase="salida" name="" tipo="VARCHAR" parentProperty = "datosCliente"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "ClienteDTO" mappingProperty = "nomApeclien2" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarClientePrepago" clase="salida" name="" tipo="VARCHAR" parentProperty = "datosCliente"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "ClienteDTO" mappingProperty = "numIdent" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarClientePrepago" clase="salida" name="" tipo="VARCHAR" parentProperty = "datosCliente"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "ClienteDTO" mappingProperty = "codTipident" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarClientePrepago" clase="salida" name="" tipo="VARCHAR" parentProperty = "datosCliente"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "ClienteDTO" mappingProperty = "desNit"
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarClientePrepago" clase="salida" name="" tipo="VARCHAR" parentProperty = "datosCliente"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "ClienteDTO" mappingProperty = "numIdent2" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarClientePrepago" clase="salida" name="" tipo="VARCHAR" parentProperty = "datosCliente"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "ClienteDTO" mappingProperty = "codTipident2" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarClientePrepago" clase="salida" name="" tipo="DATE" parentProperty = "lstDatCliente"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "ClienteDTO" mappingProperty = "fecNacimien"
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarClientePrepago" clase="salida" name="" tipo="VARCHAR" parentProperty = "datosCliente"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "ClienteDTO" mappingProperty = "codTecnologia" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarClientePrepago" clase="salida" name="" tipo="VARCHAR" parentProperty = "lstDatCliente"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "ClienteDTO" mappingProperty = "numSerie" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarClientePrepago" clase="salida" name="" tipo="VARCHAR" parentProperty = "datosCliente"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "ClienteDTO" mappingProperty = "numImei"  
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarClientePrepago" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "codigoError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarClientePrepago" clase="salida" name="" tipo="VARCHAR" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "mensajeError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarClientePrepago" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "numeroEvento"
* 
* @tmas.legacy.jdbc.storedprocedure id = "consultarClienteXCodigo" package = "GE_INTEGRACION_PG" sp = "GE_CONS_CLIE_COD_PR"
* jndiProperty = "IntegracionGteSclDs"
* servicioMetodo = "consultarClienteXCodigo"
* servicioPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroEntrada = "ClienteCodInDTO"
* servicioPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroSalida = "DatosClienteResponseDTO"
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarClienteXCodigo" clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "ClienteCodInDTO" mappingProperty = "codCliente" parentProperty = ""
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarClienteXCodigo" clase="salida" name="" tipo="DATE" parentProperty = "datosCliente"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "ClienteDTO" mappingProperty = "sysDate"
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarClienteXCodigo" clase="salida" name="" tipo="NUMERIC" parentProperty = "datosCliente"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "ClienteDTO" mappingProperty = "codCliente"
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarClienteXCodigo" clase="salida" name="" tipo="VARCHAR" parentProperty = "datosCliente"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "ClienteDTO" mappingProperty = "nomCliente"
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarClienteXCodigo" clase="salida" name="" tipo="VARCHAR" parentProperty = "datosCliente"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "ClienteDTO" mappingProperty = "nomApeclien1"
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarClienteXCodigo" clase="salida" name="" tipo="VARCHAR" parentProperty = "datosCliente"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "ClienteDTO" mappingProperty = "nomApeclien2"
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarClienteXCodigo" clase="salida" name="" tipo="VARCHAR" parentProperty = "datosCliente"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "ClienteDTO" mappingProperty = "numIdent"
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarClienteXCodigo" clase="salida" name="" tipo="VARCHAR" parentProperty = "datosCliente"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "ClienteDTO" mappingProperty = "codTipident"
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarClienteXCodigo" clase="salida" name="" tipo="VARCHAR" parentProperty = "datosCliente"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "ClienteDTO" mappingProperty = "desNit"
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarClienteXCodigo" clase="salida" name="" tipo="VARCHAR" parentProperty = "datosCliente"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "ClienteDTO" mappingProperty = "numIdent2"
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarClienteXCodigo" clase="salida" name="" tipo="VARCHAR" parentProperty = "datosCliente"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "ClienteDTO" mappingProperty = "codTipident2"
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarClienteXCodigo" clase="salida" name="" tipo="VARCHAR" parentProperty = "datosCliente"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "ClienteDTO" mappingProperty = "numIdentapor"
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarClienteXCodigo" clase="salida" name="" tipo="VARCHAR" parentProperty = "datosCliente"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "ClienteDTO" mappingProperty = "codTipidentapor"
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarClienteXCodigo" clase="salida" name="" tipo="DATE" parentProperty = "datosCliente"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "ClienteDTO" mappingProperty = "fecNacimien"
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarClienteXCodigo" clase="salida" name="" tipo="NUMERIC" parentProperty = "datosCliente"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "ClienteDTO" mappingProperty = "codProfesion"
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarClientePospago" clase="salida" name="" tipo="VARCHAR" parentProperty = "datosCliente"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "ClienteDTO" mappingProperty = "codOcupacion"
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarClienteXCodigo" clase="salida" name="" tipo="VARCHAR" parentProperty = "datosCliente"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "ClienteDTO" mappingProperty = "nomApoderado"
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarClienteXCodigo" clase="salida" name="" tipo="VARCHAR" parentProperty = "datosCliente"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "ClienteDTO" mappingProperty = "indEstcivil"
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarClienteXCodigo" clase="salida" name="" tipo="VARCHAR" parentProperty = "datosCliente"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "ClienteDTO" mappingProperty = "estadoCivil"
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarClienteXCodigo" clase="salida" name="" tipo="VARCHAR" parentProperty = "datosCliente"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "ClienteDTO" mappingProperty = "codPais"
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarClienteXCodigo" clase="salida" name="" tipo="VARCHAR" parentProperty = "datosCliente"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "ClienteDTO" mappingProperty = "desPais"
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarClienteXCodigo" clase="salida" name="" tipo="VARCHAR" parentProperty = "datosCliente"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "ClienteDTO" mappingProperty = "codTipo"
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarClienteXCodigo" clase="salida" name="" tipo="VARCHAR" parentProperty = "datosCliente"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "ClienteDTO" mappingProperty = "tipCliente"
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarClienteXCodigo" clase="salida" name="" tipo="VARCHAR" parentProperty = "datosCliente"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "ClienteDTO" mappingProperty = "tefCliente1"
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarClienteXCodigo" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "codigoError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarClienteXCodigo" clase="salida" name="" tipo="VARCHAR" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "mensajeError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarClienteXCodigo" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "numeroEvento"
* 
* @tmas.legacy.jdbc.storedprocedure id = "consultarTipoCliente" package = "GE_INTEGRACION_PG" sp = "GE_CONS_TIPO_CLIENTE_PR"
* jndiProperty = "IntegracionGteSclDs"
* servicioMetodo = "consultarTipoCliente"
* servicioPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroEntrada = "ClienteCodInDTO"
* servicioPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroSalida = "DatosClienteResponseDTO"
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarTipoCliente" clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "ClienteCodInDTO" mappingProperty = "codCliente" parentProperty = ""
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarTipoCliente" clase="salida" name="" tipo="NUMERIC" parentProperty = "lstDatCliente"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "ClienteDTO" mappingProperty = "codCliente" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarTipoCliente" clase="salida" name="" tipo="VARCHAR" parentProperty = "datosCliente"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "ClienteDTO" mappingProperty = "codTipo" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarTipoCliente" clase="salida" name="" tipo="VARCHAR" parentProperty = "datosCliente"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "ClienteDTO" mappingProperty = "tipCliente" 
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarTipoCliente" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "codigoError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarTipoCliente" clase="salida" name="" tipo="VARCHAR" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "mensajeError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarTipoCliente" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "numeroEvento"
* 
* 
* @tmas.legacy.jdbc.storedprocedure id = "obtenerSegmentoCliente" package = "GE_INTEGRACION_PG" sp = "ge_obtener_seg_cliente_pr"
* jndiProperty = "IntegracionGteSclDs"
* servicioMetodo = "obtenerSegmentoCliente"
* servicioPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroEntrada = "CodClienteDTO"
* servicioPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroSalida = "SegmentoClienteResponseDTO"
* comentario = "Entrega segmento del Cliente (Obtener Segmento del Cliente)"
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "obtenerSegmentoCliente"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "CodClienteDTO" mappingProperty = "codCliente" parentProperty = ""  
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "obtenerSegmentoCliente" clase="salida" name="" tipo="VARCHAR" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "SegmentoClienteResponseDTO" mappingProperty = "codSegmento" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "obtenerSegmentoCliente" clase="salida" name="" tipo="VARCHAR" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "SegmentoClienteResponseDTO" mappingProperty = "desSegmento"
* @tmas.legacy.jdbc.storedprocedure.parametro id = "obtenerSegmentoCliente" clase="salida" name="" tipo="VARCHAR" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "SegmentoClienteResponseDTO" mappingProperty = "codTipo"   
* @tmas.legacy.jdbc.storedprocedure.parametro id = "obtenerSegmentoCliente" clase="salida" name="" tipo="VARCHAR" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "SegmentoClienteResponseDTO" mappingProperty = "desTipo"          
*  
* @tmas.legacy.jdbc.storedprocedure.parametro id = "obtenerSegmentoCliente" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "codigoError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "obtenerSegmentoCliente" clase="salida" name="" tipo="VARCHAR" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "mensajeError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "obtenerSegmentoCliente" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "numeroEvento"
*
* 
* @tmas.legacy.jdbc.storedprocedure id = "validarClieFacturable" package = "GE_INTEGRACION_PG" sp = "ge_val_clie_facturable_pr"
* jndiProperty = "IntegracionGteSclDs"
* servicioMetodo = "validarClieFacturable"
* servicioPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroEntrada = "ConsClieFacturableDTO"
* servicioPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroSalida = "RespBooleanDTO"
* comentario = "Consulta si Cliente es Facturable"
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "validarClieFacturable"   clase="entrada" name="" tipo="" parentProperty = ""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "ConsClieFacturableDTO" mappingProperty = "codCliente" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "validarClieFacturable"   clase="entrada" name="" tipo="" parentProperty = ""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "ConsClieFacturableDTO" mappingProperty = "numAbonado" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "validarClieFacturable"   clase="entrada" name="" tipo="" parentProperty = ""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "ConsClieFacturableDTO" mappingProperty = "codCicloFact" 
*  
* @tmas.legacy.jdbc.storedprocedure.parametro id = "validarClieFacturable" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "codigoError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "validarClieFacturable" clase="salida" name="" tipo="VARCHAR" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "mensajeError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "validarClieFacturable" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "numeroEvento"
* 
*/ 

public class ClienteDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	private Date sysDate;
	private long codCuenta;
	private long codCliente; 
	private String nomCliente;
	private String nomApeClien1; 
	private String nomApeClien2; 
	private String codTipo; 
	private String desValor;
	private long numCelular;
	private Date fecAlta; 
	private Date fecFincontra; 
	private String codTecnologia; 
	private String numSerie; 
	private String numImei; 
	private String codPlantarif;
	private String nomApeclien1;
	private String nomApeclien2; 
	private String numIdent; 
	private String codTipident;
	private String desNit;
	private String numIdent2; 
	private String codTipident2;
	private String desIdent2;	
	private String numIdentapor; 
	private String codTipidentapor; 
	private String desIdentApor;
	private Date fecNacimien; 
	private long codProfesion; 
	private String desProfesion;
	private String codOcupacion;
	private String desOcupacion;
	private String nomApoderado;
	private String indEstcivil;
	private String nacionalidad;
	private String codPais;
	private String desPais;
	private String desPlantarif;
	private String estadoCivil;
	private String tipCliente;
	private String tefCliente1;
	private String desEquipo;
	private DireccionDTO[] lstDireccion;
	private String desActividad;
	private long codArticulo;
	
	public long getCodArticulo() {
		return codArticulo;
	}
	public void setCodArticulo(long codArticulo) {
		this.codArticulo = codArticulo;
	}
	public long getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(long codCliente) {
		this.codCliente = codCliente;
	}
	public long getCodCuenta() {
		return codCuenta;
	}
	public void setCodCuenta(long codCuenta) {
		this.codCuenta = codCuenta;
	}
	public String getCodPais() {
		return codPais;
	}
	public void setCodPais(String codPais) {
		this.codPais = codPais;
	}
	public String getCodPlantarif() {
		return codPlantarif;
	}
	public void setCodPlantarif(String codPlantarif) {
		this.codPlantarif = codPlantarif;
	}
	public long getCodProfesion() {
		return codProfesion;
	}
	public void setCodProfesion(long codProfesion) {
		this.codProfesion = codProfesion;
	}
	public String getCodTecnologia() {
		return codTecnologia;
	}
	public void setCodTecnologia(String codTecnologia) {
		this.codTecnologia = codTecnologia;
	}
	public String getCodTipident() {
		return codTipident;
	}
	public void setCodTipident(String codTipident) {
		this.codTipident = codTipident;
	}
	public String getCodTipident2() {
		return codTipident2;
	}
	public void setCodTipident2(String codTipident2) {
		this.codTipident2 = codTipident2;
	}
	public String getCodTipidentapor() {
		return codTipidentapor;
	}
	public void setCodTipidentapor(String codTipidentapor) {
		this.codTipidentapor = codTipidentapor;
	}
	public String getCodTipo() {
		return codTipo;
	}
	public void setCodTipo(String codTipo) {
		this.codTipo = codTipo;
	}
	public String getDesActividad() {
		return desActividad;
	}
	public void setDesActividad(String desActividad) {
		this.desActividad = desActividad;
	}
	public String getDesEquipo() {
		return desEquipo;
	}
	public void setDesEquipo(String desEquipo) {
		this.desEquipo = desEquipo;
	}
	public String getDesNit() {
		return desNit;
	}
	public void setDesNit(String desNit) {
		this.desNit = desNit;
	}
	public String getDesPais() {
		return desPais;
	}
	public void setDesPais(String desPais) {
		this.desPais = desPais;
	}
	public String getDesPlantarif() {
		return desPlantarif;
	}
	public void setDesPlantarif(String desPlantarif) {
		this.desPlantarif = desPlantarif;
	}
	public String getDesValor() {
		return desValor;
	}
	public void setDesValor(String desValor) {
		this.desValor = desValor;
	}
	public String getEstadoCivil() {
		return estadoCivil;
	}
	public void setEstadoCivil(String estadoCivil) {
		this.estadoCivil = estadoCivil;
	}
	public Date getFecAlta() {
		return fecAlta;
	}
	public void setFecAlta(Date fecAlta) {
		this.fecAlta = fecAlta;
	}
	public Date getFecFincontra() {
		return fecFincontra;
	}
	public void setFecFincontra(Date fecFincontra) {
		this.fecFincontra = fecFincontra;
	}
	public Date getFecNacimien() {
		return fecNacimien;
	}
	public void setFecNacimien(Date fecNacimien) {
		this.fecNacimien = fecNacimien;
	}
	public String getIndEstcivil() {
		return indEstcivil;
	}
	public void setIndEstcivil(String indEstcivil) {
		this.indEstcivil = indEstcivil;
	}
	public DireccionDTO[] getLstDireccion() {
		return lstDireccion;
	}
	public void setLstDireccion(DireccionDTO[] lstDireccion) {
		this.lstDireccion = lstDireccion;
	}
	public String getNomApeclien1() {
		return nomApeclien1;
	}
	public void setNomApeclien1(String nomApeclien1) {
		this.nomApeclien1 = nomApeclien1;
	}
	public String getNomApeClien1() {
		return nomApeClien1;
	}
	public void setNomApeClien1(String nomApeClien1) {
		this.nomApeClien1 = nomApeClien1;
	}
	public String getNomApeclien2() {
		return nomApeclien2;
	}
	public void setNomApeclien2(String nomApeclien2) {
		this.nomApeclien2 = nomApeclien2;
	}
	public String getNomApeClien2() {
		return nomApeClien2;
	}
	public void setNomApeClien2(String nomApeClien2) {
		this.nomApeClien2 = nomApeClien2;
	}
	public String getNomApoderado() {
		return nomApoderado;
	}
	public void setNomApoderado(String nomApoderado) {
		this.nomApoderado = nomApoderado;
	}
	public String getNomCliente() {
		return nomCliente;
	}
	public void setNomCliente(String nomCliente) {
		this.nomCliente = nomCliente;
	}
	public long getNumCelular() {
		return numCelular;
	}
	public void setNumCelular(long numCelular) {
		this.numCelular = numCelular;
	}
	public String getNumIdent() {
		return numIdent;
	}
	public void setNumIdent(String numIdent) {
		this.numIdent = numIdent;
	}
	public String getNumIdent2() {
		return numIdent2;
	}
	public void setNumIdent2(String numIdent2) {
		this.numIdent2 = numIdent2;
	}
	public String getNumIdentapor() {
		return numIdentapor;
	}
	public void setNumIdentapor(String numIdentapor) {
		this.numIdentapor = numIdentapor;
	}
	public String getNumImei() {
		return numImei;
	}
	public void setNumImei(String numImei) {
		this.numImei = numImei;
	}
	public String getNumSerie() {
		return numSerie;
	}
	public void setNumSerie(String numSerie) {
		this.numSerie = numSerie;
	}
	public Date getSysDate() {
		return sysDate;
	}
	public void setSysDate(Date sysDate) {
		this.sysDate = sysDate;
	}
	public String getTefCliente1() {
		return tefCliente1;
	}
	public void setTefCliente1(String tefCliente1) {
		this.tefCliente1 = tefCliente1;
	}
	public String getTipCliente() {
		return tipCliente;
	}
	public void setTipCliente(String tipCliente) {
		this.tipCliente = tipCliente;
	}
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}
	public String getDesIdent2() {
		return desIdent2;
	}
	public void setDesIdent2(String desIdent2) {
		this.desIdent2 = desIdent2;
	}
	public String getDesIdentApor() {
		return desIdentApor;
	}
	public void setDesIdentApor(String desIdentApor) {
		this.desIdentApor = desIdentApor;
	}
	public String getDesProfesion() {
		return desProfesion;
	}
	public void setDesProfesion(String desProfesion) {
		this.desProfesion = desProfesion;
	}
	public String getNacionalidad() {
		return nacionalidad;
	}
	public void setNacionalidad(String nacionalidad) {
		this.nacionalidad = nacionalidad;
	}
	public String getCodOcupacion() {
		return codOcupacion;
	}
	public void setCodOcupacion(String codOcupacion) {
		this.codOcupacion = codOcupacion;
	}
	public String getDesOcupacion() {
		return desOcupacion;
	}
	public void setDesOcupacion(String desOcupacion) {
		this.desOcupacion = desOcupacion;
	}
	
	
}
