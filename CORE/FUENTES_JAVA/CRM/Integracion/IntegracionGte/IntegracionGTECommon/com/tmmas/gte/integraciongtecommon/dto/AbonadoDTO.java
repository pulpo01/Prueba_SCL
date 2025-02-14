package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
 
/**
* 
* @tmas.legacy.jdbc.storedprocedure id = "consultarAbonadoCliTel" package = "GE_INTEGRACION_PG" sp = "ge_cons_abo_clie_telef_pr"
* jndiProperty = "IntegracionGteSclDs"
* servicioMetodo = "consultarAbonadoCliTel"
* servicioPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroEntrada = "EsClieTelefDTO"
* servicioPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroSalida = "AbonadoOutDTO"
* comentario = "Entrega Datos del Abonado"
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarAbonadoCliTel"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "EsClieTelefDTO" mappingProperty = "codCliente" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarAbonadoCliTel"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "EsClieTelefDTO" mappingProperty = "numeroTelefono" parentProperty = ""
*  
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarAbonadoCliTel" clase="salida" name="" tipo="NUMERIC" parentProperty = "listadoClientes"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "AbonadoDTO" mappingProperty = "numAbonado" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarAbonadoCliTel" clase="salida" name="" tipo="NUMERIC" parentProperty = "listadoClientes"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "AbonadoDTO" mappingProperty = "codCuenta" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarAbonadoCliTel" clase="salida" name="" tipo="NUMERIC" parentProperty = "listadoClientes"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "AbonadoDTO" mappingProperty = "codUso" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarAbonadoCliTel" clase="salida" name="" tipo="VARCHAR" parentProperty = "listadoClientes"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "AbonadoDTO" mappingProperty = "codSituacion" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarAbonadoCliTel" clase="salida" name="" tipo="NUMERIC" parentProperty = "listadoClientes"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "AbonadoDTO" mappingProperty = "codVendedor" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarAbonadoCliTel" clase="salida" name="" tipo="VARCHAR" parentProperty = "listadoClientes"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "AbonadoDTO" mappingProperty = "tipPlantarif" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarAbonadoCliTel" clase="salida" name="" tipo="VARCHAR" parentProperty = "listadoClientes"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "AbonadoDTO" mappingProperty = "tipTerminal" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarAbonadoCliTel" clase="salida" name="" tipo="VARCHAR" parentProperty = "listadoClientes"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "AbonadoDTO" mappingProperty = "codPlantarif" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarAbonadoCliTel" clase="salida" name="" tipo="VARCHAR" parentProperty = "listadoClientes"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "AbonadoDTO" mappingProperty = "numSerie"
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarAbonadoCliTel" clase="salida" name="" tipo="DATE" parentProperty = "listadoClientes"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "AbonadoDTO" mappingProperty = "fecAlta"
*  
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarAbonadoCliTel" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "codigoError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarAbonadoCliTel" clase="salida" name="" tipo="VARCHAR" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "mensajeError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarAbonadoCliTel" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "numeroEvento"
* 
* 
* @tmas.legacy.jdbc.storedprocedure id = "consultarAbonadoTelefono" package = "GE_INTEGRACION_PG" sp = "ge_cons_abo_tel_pr"
* jndiProperty = "IntegracionGteSclDs"
* servicioMetodo = "consultarAbonadoTelefono"
* servicioPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroEntrada = "EsTelefIgualClieDTO"
* servicioPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroSalida = "AbonadoOutDTO"
* comentario = "retorna Datos del cliente a partir de un numero de telefono " 
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarAbonadoTelefono"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "EsTelefIgualClieDTO" mappingProperty = "num_telefono1" parentProperty = ""
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarAbonadoTelefono" clase="salida" name="" tipo="NUMERIC" parentProperty = "listadoClientes"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "AbonadoDTO" mappingProperty = "numAbonado" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarAbonadoTelefono" clase="salida" name="" tipo="NUMERIC" parentProperty = "listadoClientes"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "AbonadoDTO" mappingProperty = "codCliente" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarAbonadoTelefono" clase="salida" name="" tipo="VARCHAR" parentProperty = "listadoClientes"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "AbonadoDTO" mappingProperty = "tipAbonado" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarAbonadoTelefono" clase="salida" name="" tipo="VARCHAR" parentProperty = "listadoClientes"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "AbonadoDTO" mappingProperty = "codTecnologia"  
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarAbonadoTelefono" clase="salida" name="" tipo="VARCHAR" parentProperty = "listadoClientes"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "AbonadoDTO" mappingProperty = "numSerie" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarAbonadoTelefono" clase="salida" name="" tipo="VARCHAR" parentProperty = "listadoClientes"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "AbonadoDTO" mappingProperty = "numImei"
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarAbonadoTelefono" clase="salida" name="" tipo="VARCHAR" parentProperty = "listadoClientes"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "AbonadoDTO" mappingProperty = "codPrestacion"
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarAbonadoTelefono" clase="salida" name="" tipo="NUMERIC" parentProperty = "listadoClientes"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "AbonadoDTO" mappingProperty = "codCuenta"
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarAbonadoTelefono" clase="salida" name="" tipo="VARCHAR" parentProperty = "listadoClientes"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "AbonadoDTO" mappingProperty = "codPlanTarif"
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarAbonadoTelefono" clase="salida" name="" tipo="VARCHAR" parentProperty = "listadoClientes"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "AbonadoDTO" mappingProperty = "desPrestacion"
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarAbonadoTelefono" clase="salida" name="" tipo="VARCHAR" parentProperty = "listadoClientes"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "AbonadoDTO" mappingProperty = "codTiplan"
*  
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarAbonadoTelefono" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "codigoError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarAbonadoTelefono" clase="salida" name="" tipo="VARCHAR" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "mensajeError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarAbonadoTelefono" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "numeroEvento"
*
*
* @tmas.legacy.jdbc.storedprocedure id = "consAbonadoPospagoHibrido" package = "GE_INTEGRACION_PG" sp = "ge_val_pospago_hib_pr"
* jndiProperty = "IntegracionGteSclDs"
* servicioMetodo = "consAbonadoPospagoHibrido"
* servicioPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroEntrada = "NumeroPlanTarifDTO"
* servicioPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroSalida = "AbonadoPospagoOutDTO"
* comentario = "Retorna numAbonado y codCliente a partir de un numCelular pospago o hibrido"
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consAbonadoPospagoHibrido"   clase="entrada" name="" tipo="" parentProperty = ""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "NumeroPlanTarifDTO" mappingProperty = "numeroTelefono" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consAbonadoPospagoHibrido"   clase="entrada" name="" tipo="" parentProperty = ""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "NumeroPlanTarifDTO" mappingProperty = "desPlanTarifario" 
*  
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consAbonadoPospagoHibrido" clase="salida" name="" tipo="NUMERIC" parentProperty = "listadoClientes"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "AbonadoPospagoDTO" mappingProperty = "numAbonado" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consAbonadoPospagoHibrido" clase="salida" name="" tipo="NUMERIC" parentProperty = "listadoClientes"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "AbonadoPospagoDTO" mappingProperty = "codCliente" 
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consAbonadoPospagoHibrido" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "codigoError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consAbonadoPospagoHibrido" clase="salida" name="" tipo="VARCHAR" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "mensajeError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consAbonadoPospagoHibrido" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "numeroEvento"
* 
* 
* @tmas.legacy.jdbc.storedprocedure id = "consultarKit" package = "GE_INTEGRACION_PG" sp = "GE_CONS_ABO_PROD_PR"
* jndiProperty = "IntegracionGteSclDs"
* servicioMetodo = "consultarKit"
* servicioPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroEntrada = "AbonadoDTO"
* servicioPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroSalida = "AbonadoProductoResponseDTO"
* comentario = "Retorna el número de kit asociado al número de serie de un abonado."
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarKit"   clase="entrada" name="" tipo="" parentProperty = ""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "AbonadoDTO" mappingProperty = "numSerie" 
*  
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarKit" clase="salida" name="" tipo="VARCHAR"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "AbonadoProductoResponseDTO" mappingProperty = "tipProducto" parentProperty = ""
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarKit" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "codigoError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarKit" clase="salida" name="" tipo="VARCHAR" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "mensajeError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarKit" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "numeroEvento"
* 
* 
* 
* colocando el metodos de bloquedos 
* 
* @tmas.legacy.jdbc.storedprocedure id = "consultarBloqueoTelefonoPospago" package = "GE_INTEGRACION_PG" sp = "GE_CONS_TEL_BLOQ_POSP_PR"
* jndiProperty = "IntegracionGteSclDs"
* servicioMetodo = "consultarBloqueoTelefonoPospago"
* servicioPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroEntrada = "BloqueoInDTO"
* servicioPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroSalida = "BloqueoDTO"
* comentario = "se ingresa un numero de abonado, el metodo retorna el BloqueoDTO Los datos correspondiente"
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarBloqueoTelefonoPospago"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"  mappingParametroEntrada = "BloqueoInDTO"  mappingProperty = "codAbonado" parentProperty = ""
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarBloqueoTelefonoPospago"   clase="salida" name="" tipo="DATE" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "BloqueoDTO" mappingProperty = "fecSuspbd" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarBloqueoTelefonoPospago"   clase="salida" name="" tipo="VARCHAR" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "BloqueoDTO" mappingProperty = "numTerminal" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarBloqueoTelefonoPospago"   clase="salida" name="" tipo="DATE" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "BloqueoDTO" mappingProperty = "fecSuspcen" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarBloqueoTelefonoPospago"   clase="salida" name="" tipo="VARCHAR" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "BloqueoDTO" mappingProperty = "codCaususp" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarBloqueoTelefonoPospago"   clase="salida" name="" tipo="VARCHAR" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "BloqueoDTO" mappingProperty = "desCaususp" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarBloqueoTelefonoPospago"   clase="salida" name="" tipo="NUMERIC" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "BloqueoDTO" mappingProperty = "indFraude" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarBloqueoTelefonoPospago"   clase="salida" name="" tipo="VARCHAR" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "BloqueoDTO" mappingProperty = "codTipfraude" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarBloqueoTelefonoPospago"   clase="salida" name="" tipo="NUMERIC" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "BloqueoDTO" mappingProperty = "tipSuspencion" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarBloqueoTelefonoPospago"   clase="salida" name="" tipo="VARCHAR" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "BloqueoDTO" mappingProperty = "desValor" 
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarBloqueoTelefonoPospago" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "codigoError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarBloqueoTelefonoPospago" clase="salida" name="" tipo="VARCHAR" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "mensajeError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarBloqueoTelefonoPospago" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "numeroEvento"
* 
*
*
*
*
* @tmas.legacy.jdbc.storedprocedure id = "consultarBloqueoTelefonoPrepago" package = "GE_INTEGRACION_PG" sp = "GE_CONS_TEL_BLOQ_PREP_PR"
* jndiProperty = "IntegracionGteSclDs"
* servicioMetodo = "consultarBloqueoTelefonoPrepago"
* servicioPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroEntrada = "BloqueoInDTO"
* servicioPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroSalida = "BloqueoDTO"
* comentario = "se ingresa un numero de abonado, el metodo retorna el BloqueoDTO Los datos correspondiente"
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarBloqueoTelefonoPrepago"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"  mappingParametroEntrada = "BloqueoInDTO"  mappingProperty = "codAbonado" parentProperty = ""
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarBloqueoTelefonoPrepago"   clase="salida" name="" tipo="DATE" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "BloqueoDTO" mappingProperty = "fecSuspbd" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarBloqueoTelefonoPrepago"   clase="salida" name="" tipo="VARCHAR" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "BloqueoDTO" mappingProperty = "numTerminal" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarBloqueoTelefonoPrepago"   clase="salida" name="" tipo="DATE" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "BloqueoDTO" mappingProperty = "fecSuspcen" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarBloqueoTelefonoPrepago"   clase="salida" name="" tipo="VARCHAR" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "BloqueoDTO" mappingProperty = "codCaususp" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarBloqueoTelefonoPrepago"   clase="salida" name="" tipo="VARCHAR" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "BloqueoDTO" mappingProperty = "desCaususp" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarBloqueoTelefonoPrepago"   clase="salida" name="" tipo="NUMERIC" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "BloqueoDTO" mappingProperty = "indFraude" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarBloqueoTelefonoPrepago"   clase="salida" name="" tipo="VARCHAR" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "BloqueoDTO" mappingProperty = "codTipfraude" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarBloqueoTelefonoPrepago"   clase="salida" name="" tipo="NUMERIC" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "BloqueoDTO" mappingProperty = "tipSuspencion" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarBloqueoTelefonoPrepago"   clase="salida" name="" tipo="VARCHAR" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "BloqueoDTO" mappingProperty = "desTipsuspension" 
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarBloqueoTelefonoPrepago" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "codigoError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarBloqueoTelefonoPrepago" clase="salida" name="" tipo="VARCHAR" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "mensajeError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarBloqueoTelefonoPrepago" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "numeroEvento"
* 
*/ 

public class AbonadoDTO  implements Serializable {

	private static final long serialVersionUID = 1L;
	
	
	private long numAbonado;
	private long codCuenta;
	private int codUso;
	private String codSituacion;
	private int codVendedor;
	private String tipPlantarif;
	private String tipTerminal;
	private String codPlantarif;
	private String numSerie;
	private Date fecAlta;
	private int codCliente;
	private long numeroTelefono;
	private String tipAbonado;
	private RespuestaDTO respuesta;
	private String codTecnologia;
	private String numImei;
	private String codPrestacion;
	private String codPlanTarif;
	private String codTiplan;
	private String desPrestacion;
	private String codPlanServi;
	
	
	public String getCodTiplan() {
		return codTiplan;
	}
	public void setCodTiplan(String codTiplan) {
		this.codTiplan = codTiplan;
	}
	public String getDesPrestacion() {
		return desPrestacion;
	}
	public void setDesPrestacion(String desPrestacion) {
		this.desPrestacion = desPrestacion;
	}
	public String getCodPlanTarif() {
		return codPlanTarif;
	}
	public void setCodPlanTarif(String codPlanTarif) {
		this.codPlanTarif = codPlanTarif;
	}
	public String getNumImei() {
		return numImei;
	}
	public void setNumImei(String numImei) {
		this.numImei = numImei;
	}
	public String getCodPrestacion() {
		return codPrestacion;
	}
	public void setCodPrestacion(String codPrestacion) {
		this.codPrestacion = codPrestacion;
	}
	public String getCodTecnologia() {
		return codTecnologia;
	}
	public void setCodTecnologia(String codTecnologia) {
		this.codTecnologia = codTecnologia;
	}
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}
	public int getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(int codCliente) {
		this.codCliente = codCliente;
	}
	public long getCodCuenta() {
		return codCuenta;
	}
	public void setCodCuenta(long codCuenta) {
		this.codCuenta = codCuenta;
	}
	public String getCodPlantarif() {
		return codPlantarif;
	}
	public void setCodPlantarif(String codPlantarif) {
		this.codPlantarif = codPlantarif;
	}
	public String getCodSituacion() {
		return codSituacion;
	}
	public void setCodSituacion(String codSituacion) {
		this.codSituacion = codSituacion;
	}
	public int getCodUso() {
		return codUso;
	}
	public void setCodUso(int codUso) {
		this.codUso = codUso;
	}
	public int getCodVendedor() {
		return codVendedor;
	}
	public void setCodVendedor(int codVendedor) {
		this.codVendedor = codVendedor;
	}
	public Date getFecAlta() {
		return fecAlta;
	}
	public void setFecAlta(Date fecAlta) {
		this.fecAlta = fecAlta;
	}
	public long getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(long numAbonado) {
		this.numAbonado = numAbonado;
	}
	public long getNumeroTelefono() {
		return numeroTelefono;
	}
	public void setNumeroTelefono(long numeroTelefono) {
		this.numeroTelefono = numeroTelefono;
	}
	public String getNumSerie() {
		return numSerie;
	}
	public void setNumSerie(String numSerie) {
		this.numSerie = numSerie;
	}
	public RespuestaDTO getRespuesta() {
		return respuesta;
	}
	public void setRespuesta(RespuestaDTO respuesta) {
		this.respuesta = respuesta;
	}
	public String getTipAbonado() {
		return tipAbonado;
	}
	public void setTipAbonado(String tipAbonado) {
		this.tipAbonado = tipAbonado;
	}
	public String getTipPlantarif() {
		return tipPlantarif;
	}
	public void setTipPlantarif(String tipPlantarif) {
		this.tipPlantarif = tipPlantarif;
	}
	public String getTipTerminal() {
		return tipTerminal;
	}
	public void setTipTerminal(String tipTerminal) {
		this.tipTerminal = tipTerminal;
	}
	public String getCodPlanServi() {
		return codPlanServi;
	}
	public void setCodPlanServi(String codPlanServi) {
		this.codPlanServi = codPlanServi;
	}

	
	

}