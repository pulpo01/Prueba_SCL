package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;
import java.util.Date;
/**
* 
* @tmas.legacy.jdbc.storedprocedure id = "lstLlamadasNoFacturadas" package = "TOL_CONSULTA_TRAFICO_PG" sp = "TOL_DETALLETRAF_CLIENTE_PR"
* jndiProperty = "IntegracionGteTolDs"
* servicioMetodo = "lstLlamadasNoFacturadas"
* servicioPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroEntrada = "LlamadaInDTO"
* servicioPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroSalida = "TraficoResponseDTO"
* comentario = "Ingresa como parametros un LlamadaInDTO y despues devuelve un cursor con datos, este se setean los datos en LlamadaDTO y se genera una lista"
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "lstLlamadasNoFacturadas"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "LlamadaInDTO" mappingProperty = "codCliente" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "lstLlamadasNoFacturadas"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "LlamadaInDTO" mappingProperty = "numAbonado" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "lstLlamadasNoFacturadas"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "LlamadaInDTO" mappingProperty = "numCelular" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "lstLlamadasNoFacturadas"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "LlamadaInDTO" mappingProperty = "codCiclo" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "lstLlamadasNoFacturadas"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "LlamadaInDTO" mappingProperty = "fecTasa" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "lstLlamadasNoFacturadas"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "LlamadaInDTO" mappingProperty = "fecDesde" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "lstLlamadasNoFacturadas"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "LlamadaInDTO" mappingProperty = "fecHasta" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "lstLlamadasNoFacturadas"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "LlamadaInDTO" mappingProperty = "impuesto" parentProperty = ""
*  
* @tmas.legacy.jdbc.storedprocedure.parametro id = "lstLlamadasNoFacturadas"   clase="salida" name="CURSOROUT" tipo="CURSOR"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "TraficoDTO" mappingProperty = "" parentProperty = "lstListadoLlamados"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "lstLlamadasNoFacturadas" name="CURSOROUT" mappingProperty = "fechaLlamada" mappingField = "Fecha_llamada"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "lstLlamadasNoFacturadas" name="CURSOROUT" mappingProperty = "horaLlamada"  mappingField = "hora_llamada" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "lstLlamadasNoFacturadas" name="CURSOROUT" mappingProperty = "numeroDestino"  mappingField = "numero_destino" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "lstLlamadasNoFacturadas" name="CURSOROUT" mappingProperty = "mtoLlamSinImp"  mappingField = "mto_fact_sin_impuesto" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "lstLlamadasNoFacturadas" name="CURSOROUT" mappingProperty = "mtoLlamConImp"  mappingField = "mto_fact_con_impuesto" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "lstLlamadasNoFacturadas" name="CURSOROUT" mappingProperty = "tipoLlamada"  mappingField = "tipo_llamada" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "lstLlamadasNoFacturadas" name="CURSOROUT" mappingProperty = "duración"  mappingField = "duracion" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "lstLlamadasNoFacturadas" name="CURSOROUT" mappingProperty = "unidad"  mappingField = "unidad" cod_dopeb
* @tmas.legacy.jdbc.storedprocedure.cursor id = "lstLlamadasNoFacturadas" name="CURSOROUT" mappingProperty = "codDopeb"  mappingField = "cod_dopeb" 
*    
* @tmas.legacy.jdbc.storedprocedure.parametro id = "lstLlamadasNoFacturadas" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "codigoError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "lstLlamadasNoFacturadas" clase="salida" name="" tipo="VARCHAR" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "mensajeError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "lstLlamadasNoFacturadas" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "numeroEvento"
* 
* 
*  
* @tmas.legacy.jdbc.storedprocedure id = "validacionFechasCicloFacturacion" package = "GE_INTEGRACION_PG" sp = "GE_VALIDA_FECHA_CICLO_PR"
* jndiProperty = "IntegracionGteSclDs"
* servicioMetodo = "validacionFechasCicloFacturacion"
* servicioPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroEntrada = "ConsLlamadaInternaDTO"
* servicioPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroSalida = "ConsLlamadaInternaDTO"
* comentario = "se ingresa el codigo de ciclo + las fechas (inicio y termino ), las fechas puede variar pueden ir hasta nulas o una de ella nula, de vuelve las fechas correspondiente al ciclo."
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "validacionFechasCicloFacturacion"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"  mappingParametroEntrada = "ConsLlamadaInternaDTO"  mappingProperty = "fecDesde" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "validacionFechasCicloFacturacion"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"  mappingParametroEntrada = "ConsLlamadaInternaDTO"  mappingProperty = "fecHasta" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "validacionFechasCicloFacturacion"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"  mappingParametroEntrada = "ConsLlamadaInternaDTO"  mappingProperty = "cicloFacturacion" parentProperty = ""
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "validacionFechasCicloFacturacion"   clase="salida" name="" tipo="DATE" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "ConsLlamadaInternaDTO" mappingProperty = "fecDesde" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "validacionFechasCicloFacturacion"   clase="salida" name="" tipo="DATE" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "ConsLlamadaInternaDTO" mappingProperty = "fecHasta" 
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "validacionFechasCicloFacturacion" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "codigoError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "validacionFechasCicloFacturacion" clase="salida" name="" tipo="VARCHAR" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "mensajeError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "validacionFechasCicloFacturacion" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "numeroEvento"
* 
* 
* 
* @tmas.legacy.jdbc.storedprocedure id = "lstConsumoMensajesCortos" package = "TOL_CONSULTA_TRAFICO_PG" sp = "TOL_RESUMEN_TRAFICO_PR"
* jndiProperty = "IntegracionGteTolDs"
* servicioMetodo = "lstConsumoMensajesCortos"
* servicioPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroEntrada = "LlamadaInDTO"
* servicioPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroSalida = "ConsumoResponseDTO"
* comentario = "parametros de entreda  LlamadaInDTO pero sin impuestos y despues devuelve un cursor con datos, este se setean los datos en ConsumoDTO y se genera una lista"
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "lstConsumoMensajesCortos"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "LlamadaInDTO" mappingProperty = "codCliente" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "lstConsumoMensajesCortos"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "LlamadaInDTO" mappingProperty = "numAbonado" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "lstConsumoMensajesCortos"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "LlamadaInDTO" mappingProperty = "numCelular" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "lstConsumoMensajesCortos"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "LlamadaInDTO" mappingProperty = "codCiclo" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "lstConsumoMensajesCortos"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "LlamadaInDTO" mappingProperty = "fecTasa" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "lstConsumoMensajesCortos"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "LlamadaInDTO" mappingProperty = "fecDesde" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "lstConsumoMensajesCortos"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "LlamadaInDTO" mappingProperty = "fecHasta" parentProperty = ""
*  
* @tmas.legacy.jdbc.storedprocedure.parametro id = "lstConsumoMensajesCortos"   clase="salida" name="CURSOROUT" tipo="CURSOR"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "ConsumoDTO" mappingProperty = "" parentProperty = "lstListadoConsumosMensajesCortos"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "lstConsumoMensajesCortos" name="CURSOROUT" mappingProperty = "codUnidad" mappingField = "cod_unidad"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "lstConsumoMensajesCortos" name="CURSOROUT" mappingProperty = "desUnidad"  mappingField = "des_unidad" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "lstConsumoMensajesCortos" name="CURSOROUT" mappingProperty = "codTdir"  mappingField = "cod_tdir" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "lstConsumoMensajesCortos" name="CURSOROUT" mappingProperty = "durReal"  mappingField = "dur_real" 
*    
* @tmas.legacy.jdbc.storedprocedure.parametro id = "lstConsumoMensajesCortos" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "codigoError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "lstConsumoMensajesCortos" clase="salida" name="" tipo="VARCHAR" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "mensajeError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "lstConsumoMensajesCortos" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "numeroEvento"
* 
* 
* @tmas.legacy.jdbc.storedprocedure id = "consultarMinutosConsumidos" package = "tol_consulta_trafico_pg" sp = "tol_consumo_cliente_pr"
* jndiProperty = "IntegracionGteTolDs"
* servicioMetodo = "consultarMinutosConsumidos"
* servicioPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroEntrada = "ConsumoClienteDTO"
* servicioPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroSalida = "MinutosConsumidosDTO"
* comentario = "Entrega Minutos consumidos"
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarMinutosConsumidos"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "ConsumoClienteDTO" mappingProperty = "numAbonado" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarMinutosConsumidos"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "ConsumoClienteDTO" mappingProperty = "codCliente" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarMinutosConsumidos"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "ConsumoClienteDTO" mappingProperty = "fecTasa" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarMinutosConsumidos"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "ConsumoClienteDTO" mappingProperty = "codCiclo" parentProperty = ""
*  
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarMinutosConsumidos" clase="salida" name="" tipo="NUMERIC" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "MinutosConsumidosDTO" mappingProperty = "consumoTelefono"
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarMinutosConsumidos" clase="salida" name="" tipo="DATE" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "MinutosConsumidosDTO" mappingProperty = "ultLlamada"  
*  
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarMinutosConsumidos" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "codigoError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarMinutosConsumidos" clase="salida" name="" tipo="VARCHAR" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "mensajeError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarMinutosConsumidos" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "numeroEvento"
* 
* 
* @tmas.legacy.jdbc.storedprocedure id = "consultarLlamadasFacturadas" package = "PV_CONSLLAMADA_PG" sp = "PV_DETALLE_FACTURADO_PR"
* jndiProperty = "IntegracionGteSclDs"
* servicioMetodo = "consultarLlamadasFacturadas"
* servicioPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroEntrada = "LlamadaInFactDTO"
* servicioPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroSalida = "LlamadasFacturadasResponseDTO"
* comentario = "Servicio que entrega un listado de las llamadas facturadas para un número de teléfono y una factura específica"
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarLlamadasFacturadas" clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "LlamadaInFactDTO" mappingProperty = "numAbonado" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarLlamadasFacturadas" clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "LlamadaInFactDTO" mappingProperty = "codCicloFact" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarLlamadasFacturadas" clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "LlamadaInFactDTO" mappingProperty = "numFolio" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarLlamadasFacturadas" clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "LlamadaInFactDTO" mappingProperty = "fecIni" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarLlamadasFacturadas" clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "LlamadaInFactDTO" mappingProperty = "fecTerm" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarLlamadasFacturadas" clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "LlamadaInFactDTO" mappingProperty = "usuario" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarLlamadasFacturadas" clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "LlamadaInFactDTO" mappingProperty = "campoOrden" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarLlamadasFacturadas" clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "LlamadaInFactDTO" mappingProperty = "tipoOrden" parentProperty = ""
*  
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarLlamadasFacturadas" clase="salida" name="CURSOROUT" tipo="CURSOR"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "TraficoDTO" mappingProperty = "" parentProperty = "lstLlamadasFact"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarLlamadasFacturadas" name="CURSOROUT" mappingProperty = "numFolio" mappingField = "num_Folio"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarLlamadasFacturadas" name="CURSOROUT" mappingProperty = "fecLlamada" mappingField = "fec_Llamada" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarLlamadasFacturadas" name="CURSOROUT" mappingProperty = "horaLlamada" mappingField = "hora_Llamada"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarLlamadasFacturadas" name="CURSOROUT" mappingProperty = "numDestino" mappingField = "num_Destino"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarLlamadasFacturadas" name="CURSOROUT" mappingProperty = "mtoLlamSinImp" mappingField = "mto_Llam_Sin_Imp"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarLlamadasFacturadas" name="CURSOROUT" mappingProperty = "mtoLlamConImp" mappingField = "mto_Llam_Con_Imp"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarLlamadasFacturadas" name="CURSOROUT" mappingProperty = "desLlamada" mappingField = "des_Llamada"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarLlamadasFacturadas" name="CURSOROUT" mappingProperty = "duracion" mappingField = "dur_llamada"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarLlamadasFacturadas" name="CURSOROUT" mappingProperty = "unidad" mappingField = "unidad_llamada"
*    
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarLlamadasFacturadas" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "codigoError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarLlamadasFacturadas" clase="salida" name="" tipo="VARCHAR" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "mensajeError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarLlamadasFacturadas" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "numeroEvento"
*

* 
* 
* 
*/ 



public class TraficoDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	private String fechaLlamada;  
	private String horaLlamada;   
	private String numeroDestino; 
	private double mtoLlamSinImp;   
	private double mtoLlamConImp;   
	private String tipoLlamada;   
	private long duracion;        
	private String unidad;
	private String codDopeb;
	
	/*datos asicionales para el caso de uso 19*/
	private long   	codCiclo;
	private Date 	fecLlamada;
	private long 	numDestino;
	private String 	desLlamada;
	private String  usuario;
	private long   	numFolio;
	
	private RespuestaDTO respuesta;
	
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}

	public String getFechaLlamada() {
		return fechaLlamada;
	}
	public void setFechaLlamada(String fechaLlamada) {
		this.fechaLlamada = fechaLlamada;
	}
	public String getHoraLlamada() {
		return horaLlamada;
	}
	public void setHoraLlamada(String horaLlamada) {
		this.horaLlamada = horaLlamada;
	}
	public String getNumeroDestino() {
		return numeroDestino;
	}
	public void setNumeroDestino(String numeroDestino) {
		this.numeroDestino = numeroDestino;
	}
	public RespuestaDTO getRespuesta() {
		return respuesta;
	}
	public void setRespuesta(RespuestaDTO respuesta) {
		this.respuesta = respuesta;
	}
	public String getTipoLlamada() {
		return tipoLlamada;
	}
	public void setTipoLlamada(String tipoLlamada) {
		this.tipoLlamada = tipoLlamada;
	}
	public String getUnidad() {
		return unidad;
	}
	public void setUnidad(String unidad) {
		this.unidad = unidad;
	}
	public double getMtoLlamConImp() {
		return mtoLlamConImp;
	}
	public void setMtoLlamConImp(double mtoLlamConImp) {
		this.mtoLlamConImp = mtoLlamConImp;
	}
	public double getMtoLlamSinImp() {
		return mtoLlamSinImp;
	}
	public void setMtoLlamSinImp(double mtoLlamSinImp) {
		this.mtoLlamSinImp = mtoLlamSinImp;
	}
	public String getCodDopeb() {
		return codDopeb;
	}
	public void setCodDopeb(String codDopeb) {
		this.codDopeb = codDopeb;
	}
	public long getCodCiclo() {
		return codCiclo;
	}
	public void setCodCiclo(long codCiclo) {
		this.codCiclo = codCiclo;
	}
	public String getDesLlamada() {
		return desLlamada;
	}
	public void setDesLlamada(String desLlamada) {
		this.desLlamada = desLlamada;
	}
	public Date getFecLlamada() {
		return fecLlamada;
	}
	public void setFecLlamada(Date fecLlamada) {
		this.fecLlamada = fecLlamada;
	}
	public long getNumDestino() {
		return numDestino;
	}
	public void setNumDestino(long numDestino) {
		this.numDestino = numDestino;
	}
	public String getUsuario() {
		return usuario;
	}
	public void setUsuario(String usuario) {
		this.usuario = usuario;
	}
	public long getNumFolio() {
		return numFolio;
	}
	public void setNumFolio(long numFolio) {
		this.numFolio = numFolio;
	}

	public long getDuracion() {
		return duracion;
	}

	public void setDuracion(long duracion) {
		this.duracion = duracion;
	}
	
	

     

	
	


}
