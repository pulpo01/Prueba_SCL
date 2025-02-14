package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;
import java.util.Date;

/**
* 
* @tmas.legacy.jdbc.storedprocedure id = "consultarConceptosFactura" package = "GE_INTEGRACION_PG" sp = "ge_cons_conc_factura_pr"
* jndiProperty = "IntegracionGteSclDs"
* servicioMetodo = "consultarConceptosFactura"
* servicioPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroEntrada = "ConsultarConscFactDTO"
* servicioPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroSalida = "LstConceptoFacturaDTO"
* comentario = "Entrega Datos de Conceptos de Factura"
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarConceptosFactura"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "ConsultarConscFactDTO" mappingProperty = "codCliente" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarConceptosFactura"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "ConsultarConscFactDTO" mappingProperty = "codTipDocum" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarConceptosFactura"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "ConsultarConscFactDTO" mappingProperty = "numFolio" parentProperty = "" 
*  
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarConceptosFactura"   clase="salida" name="CURSOROUT" tipo="CURSOR"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "ConceptoFacturasDTO" mappingProperty = "" parentProperty = "listadoConcFactura"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarConceptosFactura" name="CURSOROUT" mappingProperty = "codConcepto" mappingField = "cod_concepto"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarConceptosFactura" name="CURSOROUT" mappingProperty = "desConcepto" mappingField = "des_concepto" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarConceptosFactura" name="CURSOROUT" mappingProperty = "importeDebe" mappingField = "importe_debe"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarConceptosFactura" name="CURSOROUT" mappingProperty = "importeHaber" mappingField = "importe_haber" 
*  
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarConceptosFactura" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "codigoError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarConceptosFactura" clase="salida" name="" tipo="VARCHAR" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "mensajeError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarConceptosFactura" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "numeroEvento"
* 
* 
* @tmas.legacy.jdbc.storedprocedure id = "consultarFacturas" package = "GE_INTEGRACION_PG" sp = "GE_CONS_FACT_CLIE_PR"
* jndiProperty = "IntegracionGteSclDs"
* servicioMetodo = "consultarFacturas"
* servicioPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroEntrada = "FacturaInDTO"
* servicioPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroSalida = "FacturaResponseDTO"
* comentario = "Ingresa como parametros el codigo del cliente, numero de iteraciones (devuelve una lista con facturas pagas e inpagas)"
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarFacturas"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "FacturaInDTO" mappingProperty = "codCliente" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarFacturas"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "FacturaInDTO" mappingProperty = "cantidadIteracion" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarFacturas"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "FacturaInDTO" mappingProperty = "opcion" parentProperty = ""
*  
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarFacturas"   clase="salida" name="CURSOROUT" tipo="CURSOR"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "FacturaDTO" mappingProperty = "" parentProperty = "lstListadoFacturas"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarFacturas" name="CURSOROUT" mappingProperty = "codCliente" mappingField = "cod_cliente"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarFacturas" name="CURSOROUT" mappingProperty = "numProceso"  mappingField = "num_proceso" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarFacturas" name="CURSOROUT" mappingProperty = "impSaldoAnt"  mappingField = "imp_saldoant" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarFacturas" name="CURSOROUT" mappingProperty = "numFolio"  mappingField = "num_folio" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarFacturas" name="CURSOROUT" mappingProperty = "estado"  mappingField = "estado" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarFacturas" name="CURSOROUT" mappingProperty = "codTipDocum"  mappingField = "cod_tipdocum" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarFacturas" name="CURSOROUT" mappingProperty = "desTipDocum"  mappingField = "des_tipdocum" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarFacturas" name="CURSOROUT" mappingProperty = "fecEmision"  mappingField = "fec_emision" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarFacturas" name="CURSOROUT" mappingProperty = "fecVencimie"  mappingField = "fec_vencimie" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarFacturas" name="CURSOROUT" mappingProperty = "totalFactura"  mappingField = "tot_factura" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarFacturas" name="CURSOROUT" mappingProperty = "totalPagar"  mappingField = "tot_pagar" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarFacturas" name="CURSOROUT" mappingProperty = "acumIva"  mappingField = "acum_iva" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarFacturas" name="CURSOROUT" mappingProperty = "totDescuento"  mappingField = "tot_descuento" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarFacturas" name="CURSOROUT" mappingProperty = "totCargosMe"  mappingField = "tot_cargosme" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarFacturas" name="CURSOROUT" mappingProperty = "fecDesdeLlam"  mappingField = "fec_desdellam" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarFacturas" name="CURSOROUT" mappingProperty = "fecHastaLlam"  mappingField = "fec_hastallam" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarFacturas" name="CURSOROUT" mappingProperty = "codCiclo"  mappingField = "cod_ciclfact" 
*    
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarFacturas" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "codigoError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarFacturas" clase="salida" name="" tipo="VARCHAR" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "mensajeError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarFacturas" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "numeroEvento"
*
*
* @tmas.legacy.jdbc.storedprocedure id = "consultarFacturasImpagas" package = "GE_INTEGRACION_PG" sp = "GE_CONS_FACT_CLIE_PR"
* jndiProperty = "IntegracionGteSclDs"
* servicioMetodo = "consultarFacturasImpagas"
* servicioPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroEntrada = "FacturaInDTO"
* servicioPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroSalida = "FacturaResponseDTO"
* comentario = "Ingresa como parametros el codigo del cliente, numero de iteraciones (devuelve una lista con facturas impagas)"
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarFacturasImpagas"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "FacturaInDTO" mappingProperty = "codCliente" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarFacturasImpagas"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "FacturaInDTO" mappingProperty = "cantidadIteracion" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarFacturas"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "FacturaInDTO" mappingProperty = "opcion" parentProperty = ""
*  
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarFacturasImpagas"   clase="salida" name="CURSOROUT" tipo="CURSOR"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "FacturaDTO" mappingProperty = "" parentProperty = "lstListadoFacturas"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarFacturasImpagas" name="CURSOROUT" mappingProperty = "codCliente" mappingField = "cod_cliente"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarFacturasImpagas" name="CURSOROUT" mappingProperty = "numProceso"  mappingField = "num_proceso" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarFacturasImpagas" name="CURSOROUT" mappingProperty = "impSaldoAnt"  mappingField = "imp_saldoant" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarFacturasImpagas" name="CURSOROUT" mappingProperty = "numFolio"  mappingField = "num_folio" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarFacturasImpagas" name="CURSOROUT" mappingProperty = "estado"  mappingField = "estado" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarFacturasImpagas" name="CURSOROUT" mappingProperty = "codTipDocum"  mappingField = "cod_tipdocum" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarFacturasImpagas" name="CURSOROUT" mappingProperty = "desTipDocum"  mappingField = "des_tipdocum" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarFacturasImpagas" name="CURSOROUT" mappingProperty = "fecEmision"  mappingField = "fec_emision" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarFacturasImpagas" name="CURSOROUT" mappingProperty = "fecVencimie"  mappingField = "fec_vencimie" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarFacturasImpagas" name="CURSOROUT" mappingProperty = "totalFactura"  mappingField = "tot_factura" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarFacturasImpagas" name="CURSOROUT" mappingProperty = "totalPagar"  mappingField = "tot_pagar" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarFacturasImpagas" name="CURSOROUT" mappingProperty = "acumIva"  mappingField = "acum_iva" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarFacturasImpagas" name="CURSOROUT" mappingProperty = "totDescuento"  mappingField = "tot_descuento" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarFacturasImpagas" name="CURSOROUT" mappingProperty = "totCargosMe"  mappingField = "tot_cargosme" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarFacturasImpagas" name="CURSOROUT" mappingProperty = "fecDesdeLlam"  mappingField = "fec_desdellam" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarFacturasImpagas" name="CURSOROUT" mappingProperty = "fecHastaLlam"  mappingField = "fec_hastallam" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarFacturasImpagas" name="CURSOROUT" mappingProperty = "codCiclo"  mappingField = "cod_ciclfact" 
*    
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarFacturasImpagas" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "codigoError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarFacturasImpagas" clase="salida" name="" tipo="VARCHAR" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "mensajeError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarFacturasImpagas" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "numeroEvento"
*
*
* @tmas.legacy.jdbc.storedprocedure id = "consultarFechasReporteConsumo" package = "GE_INTEGRACION_PG" sp = "GE_CONS_FECH_REP_CON_PR"
* jndiProperty = "IntegracionGteSclDs"
* servicioMetodo = "consultarFechasReporteConsumo"
* servicioPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroEntrada = "FacturaInDTO"
* servicioPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroSalida = "FacturaResponseDTO"
* comentario = "Ingresa como parametros el codigo del cliente, y devuele una lista de 12 FacturaDTO pero solo con datos en el atributo fecHastallam"
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarFechasReporteConsumo"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "FacturaInDTO" mappingProperty = "codCliente" parentProperty = ""
*  
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarFechasReporteConsumo"   clase="salida" name="CURSOROUT" tipo="CURSOR"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "FacturaDTO" mappingProperty = "" parentProperty = "lstListadoFacturas"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarFechasReporteConsumo" name="CURSOROUT" mappingProperty = "fecHastaLlam" mappingField = "fec_hastallam"
*    
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarFechasReporteConsumo" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "codigoError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarFechasReporteConsumo" clase="salida" name="" tipo="VARCHAR" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "mensajeError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarFechasReporteConsumo" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "numeroEvento"
*
*
* @tmas.legacy.jdbc.storedprocedure id = "consultarFacturasPagadas" package = "GE_INTEGRACION_PG" sp = "GE_CONS_FACT_CLIE_PR"
* jndiProperty = "IntegracionGteSclDs"
* servicioMetodo = "consultarFacturasPagadas"
* servicioPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroEntrada = "FacturaInDTO"
* servicioPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroSalida = "FacturaResponseDTO"
* comentario = "Ingresa como parametros el codigo del cliente, numero de iteraciones (devuelve una lista con facturas pagadas)"
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarFacturasPagadas"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "FacturaInDTO" mappingProperty = "codCliente" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarFacturasPagadas"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "FacturaInDTO" mappingProperty = "cantidadIteracion" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarFacturasPagadas"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "FacturaInDTO" mappingProperty = "opcion" parentProperty = ""
*  
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarFacturasPagadas"   clase="salida" name="CURSOROUT" tipo="CURSOR"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "FacturaDTO" mappingProperty = "" parentProperty = "lstListadoFacturas"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarFacturasPagadas" name="CURSOROUT" mappingProperty = "codCliente" mappingField = "cod_cliente"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarFacturasPagadas" name="CURSOROUT" mappingProperty = "numProceso"  mappingField = "num_proceso" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarFacturasPagadas" name="CURSOROUT" mappingProperty = "impSaldoAnt"  mappingField = "imp_saldoant" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarFacturasPagadas" name="CURSOROUT" mappingProperty = "numFolio"  mappingField = "num_folio" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarFacturasPagadas" name="CURSOROUT" mappingProperty = "estado"  mappingField = "estado" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarFacturasPagadas" name="CURSOROUT" mappingProperty = "codTipDocum"  mappingField = "cod_tipdocum" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarFacturasPagadas" name="CURSOROUT" mappingProperty = "desTipDocum"  mappingField = "des_tipdocum" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarFacturasPagadas" name="CURSOROUT" mappingProperty = "fecEmision"  mappingField = "fec_emision" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarFacturasPagadas" name="CURSOROUT" mappingProperty = "fecVencimie"  mappingField = "fec_vencimie" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarFacturasPagadas" name="CURSOROUT" mappingProperty = "totalFactura"  mappingField = "tot_factura" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarFacturasPagadas" name="CURSOROUT" mappingProperty = "totalPagar"  mappingField = "tot_pagar" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarFacturasPagadas" name="CURSOROUT" mappingProperty = "acumIva"  mappingField = "acum_iva" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarFacturasPagadas" name="CURSOROUT" mappingProperty = "totDescuento"  mappingField = "tot_descuento" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarFacturasPagadas" name="CURSOROUT" mappingProperty = "totCargosMe"  mappingField = "tot_cargosme" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarFacturasPagadas" name="CURSOROUT" mappingProperty = "fecDesdeLlam"  mappingField = "fec_desdellam" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarFacturasPagadas" name="CURSOROUT" mappingProperty = "fecHastaLlam"  mappingField = "fec_hastallam" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarFacturasPagadas" name="CURSOROUT" mappingProperty = "codCiclo"  mappingField = "cod_ciclfact" 
*    
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarFacturasPagadas" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "codigoError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarFacturasPagadas" clase="salida" name="" tipo="VARCHAR" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "mensajeError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarFacturasPagadas" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "numeroEvento"
*
*
*
* @tmas.legacy.jdbc.storedprocedure id = "consultarFacturasNoCicloCliente" package = "GE_INTEGRACION_PG" sp = "GE_CONS_FACT_CLIE_PR"
* jndiProperty = "IntegracionGteSclDs"
* servicioMetodo = "consultarFacturasNoCicloCliente"
* servicioPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroEntrada = "FacturaInDTO"
* servicioPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroSalida = "FacturaResponseDTO"
* comentario = "Ingresa como parametros el codigo del cliente, numero de iteraciones, la opcion, fecha de inicio y de termino en formato (yyyymmdd)y devuelve yna lista con facturas "
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarFacturasNoCicloCliente"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "FacturaInDTO" mappingProperty = "codCliente" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarFacturasNoCicloCliente"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "FacturaInDTO" mappingProperty = "cantidadIteracion" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarFacturasNoCicloCliente"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "FacturaInDTO" mappingProperty = "opcion" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarFacturasNoCicloCliente"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "FacturaInDTO" mappingProperty = "fechaDesde" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarFacturasNoCicloCliente"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "FacturaInDTO" mappingProperty = "fechaHasta" parentProperty = ""
*  
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarFacturasNoCicloCliente"   clase="salida" name="CURSOROUT" tipo="CURSOR"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "FacturaDTO" mappingProperty = "" parentProperty = "lstListadoFacturas"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarFacturasNoCicloCliente" name="CURSOROUT" mappingProperty = "codCliente" mappingField = "cod_cliente"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarFacturasNoCicloCliente" name="CURSOROUT" mappingProperty = "numProceso"  mappingField = "num_proceso" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarFacturasNoCicloCliente" name="CURSOROUT" mappingProperty = "impSaldoAnt"  mappingField = "imp_saldoant" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarFacturasNoCicloCliente" name="CURSOROUT" mappingProperty = "numFolio"  mappingField = "num_folio" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarFacturasNoCicloCliente" name="CURSOROUT" mappingProperty = "estado"  mappingField = "estado" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarFacturasNoCicloCliente" name="CURSOROUT" mappingProperty = "codTipDocum"  mappingField = "cod_tipdocum" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarFacturasNoCicloCliente" name="CURSOROUT" mappingProperty = "desTipDocum"  mappingField = "des_tipdocum" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarFacturasNoCicloCliente" name="CURSOROUT" mappingProperty = "fecEmision"  mappingField = "fec_emision" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarFacturasNoCicloCliente" name="CURSOROUT" mappingProperty = "fecVencimie"  mappingField = "fec_vencimie" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarFacturasNoCicloCliente" name="CURSOROUT" mappingProperty = "totalFactura"  mappingField = "tot_factura" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarFacturasNoCicloCliente" name="CURSOROUT" mappingProperty = "totalPagar"  mappingField = "tot_pagar" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarFacturasNoCicloCliente" name="CURSOROUT" mappingProperty = "acumIva"  mappingField = "acum_iva" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarFacturasNoCicloCliente" name="CURSOROUT" mappingProperty = "totDescuento"  mappingField = "tot_descuento" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarFacturasNoCicloCliente" name="CURSOROUT" mappingProperty = "totCargosMe"  mappingField = "tot_cargosme" 
*    
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarFacturasNoCicloCliente" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "codigoError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarFacturasNoCicloCliente" clase="salida" name="" tipo="VARCHAR" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "mensajeError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarFacturasNoCicloCliente" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "numeroEvento"
*
* @tmas.legacy.jdbc.storedprocedure id = "consultarCicloFact" package = "GE_INTEGRACION_PG" sp = "ge_cons_ciclo_fact_pr"
* jndiProperty = "IntegracionGteSclDs"
* servicioMetodo = "consultarCicloFact"
* servicioPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroEntrada = "ConsCicloFactDTO"
* servicioPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroSalida = "ConsAbonadoPospagoDTO"
* comentario = "Retorna codCicloFact a partir de un codCiclo pospago"
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarCicloFact"   clase="entrada" name="" tipo="" parentProperty = ""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "ConsCicloFactDTO" mappingProperty = "codCiclo" 
*  
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarCicloFact"   clase="salida" name="" tipo="NUMERIC" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "ConsAbonadoPospagoDTO" mappingProperty = "codCicloFact" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarCicloFact" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "codigoError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarCicloFact" clase="salida" name="" tipo="VARCHAR" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "mensajeError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarCicloFact" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "numeroEvento"
*
*
* @tmas.legacy.jdbc.storedprocedure id = "obtieneFechaCorte" package = "GE_INTEGRACION_PG" sp = "ge_obtiene_fecha_corte_pr"
* jndiProperty = "IntegracionGteSclDs"
* servicioMetodo = "obtieneFechaCorte"
* servicioPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroEntrada = "CodCicloFacturaDTO"
* servicioPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroSalida = "MinutosConsumidosDTO"
* comentario = "Obtiene la fecha de corte del ciclo de facturacion"
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "obtieneFechaCorte"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "CodCicloFacturaDTO" mappingProperty = "codCicloFactura" parentProperty = ""
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "obtieneFechaCorte" clase="salida" name="" tipo="DATE" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "MinutosConsumidosDTO" mappingProperty = "corteCiclo"  
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "obtieneFechaCorte" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "codigoError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "obtieneFechaCorte" clase="salida" name="" tipo="VARCHAR" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "mensajeError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "obtieneFechaCorte" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "numeroEvento"
*
*
*
* @tmas.legacy.jdbc.storedprocedure id = "consultarImpuesto" package = "PV_CONSLLAMADA_PG" sp = "PV_IMPUESTO_PR"
* jndiProperty = "IntegracionGteSclDs"
* servicioMetodo = "consultarImpuesto"
* servicioPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroEntrada = "FacturaDTO"
* servicioPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroSalida = "ImpuestoResponseDTO"
* comentario = "Llama a la funcion FA_ObtenerImpuesto_FN"
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarImpuesto"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "FacturaDTO" mappingProperty = "codCliente" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarImpuesto"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "FacturaDTO" mappingProperty = "usuario" parentProperty = ""
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarImpuesto" clase="salida" name="" tipo="NUMERIC" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "ImpuestoResponseDTO" mappingProperty = "impuesto"  
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarImpuesto" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "codigoError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarImpuesto" clase="salida" name="" tipo="VARCHAR" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "mensajeError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarImpuesto" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "numeroEvento"
*
*/ 

public class FacturaDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	private long   	codCliente;
	private long   	numProceso;
	private double  impSaldoAnt;
	private long   	numFolio;
	private String 	estado;
	private long   	codTipDocum;
	private String 	desTipDocum;
	private Date   	fecEmision;
	private Date   	fecVencimie;
	private double  totalFactura;
	private double  totalPagar;
	private double  acumIva;
	private double  totDescuento;
	private double  totCargosMe;
	private Date   	fecDesdeLlam;
	private Date   	fecHastaLlam;
	private long    codCiclo;
	private String	usuario;
	private Date	fecCancelacion;	

	public Date getFecCancelacion() {
		return fecCancelacion;
	}
	public void setFecCancelacion(Date fecCancelacion) {
		this.fecCancelacion = fecCancelacion;
	}
	public double getAcumIva() {
		return acumIva;
	}
	public void setAcumIva(double acumIva) {
		this.acumIva = acumIva;
	}
	public long getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(long codCliente) {
		this.codCliente = codCliente;
	}
	public long getCodTipDocum() {
		return codTipDocum;
	}
	public void setCodTipDocum(long codTipDocum) {
		this.codTipDocum = codTipDocum;
	}
	public String getDesTipDocum() {
		return desTipDocum;
	}
	public void setDesTipDocum(String desTipDocum) {
		this.desTipDocum = desTipDocum;
	}
	public String getEstado() {
		return estado;
	}
	public void setEstado(String estado) {
		this.estado = estado;
	}
	public Date getFecDesdeLlam() {
		return fecDesdeLlam;
	}
	public void setFecDesdeLlam(Date fecDesdeLlam) {
		this.fecDesdeLlam = fecDesdeLlam;
	}
	public Date getFecEmision() {
		return fecEmision;
	}
	public void setFecEmision(Date fecEmision) {
		this.fecEmision = fecEmision;
	}
	public Date getFecHastaLlam() {
		return fecHastaLlam;
	}
	public void setFecHastaLlam(Date fecHastaLlam) {
		this.fecHastaLlam = fecHastaLlam;
	}
	public Date getFecVencimie() {
		return fecVencimie;
	}
	public void setFecVencimie(Date fecVencimie) {
		this.fecVencimie = fecVencimie;
	}
	public double getImpSaldoAnt() {
		return impSaldoAnt;
	}
	public void setImpSaldoAnt(double impSaldoAnt) {
		this.impSaldoAnt = impSaldoAnt;
	}
	public long getNumFolio() {
		return numFolio;
	}
	public void setNumFolio(long numFolio) {
		this.numFolio = numFolio;
	}
	public long getNumProceso() {
		return numProceso;
	}
	public void setNumProceso(long numProceso) {
		this.numProceso = numProceso;
	}
	public double getTotalFactura() {
		return totalFactura;
	}
	public void setTotalFactura(double totalFactura) {
		this.totalFactura = totalFactura;
	}
	public double getTotalPagar() {
		return totalPagar;
	}
	public void setTotalPagar(double totalPagar) {
		this.totalPagar = totalPagar;
	}
	public double getTotCargosMe() {
		return totCargosMe;
	}
	public void setTotCargosMe(double totCargosMe) {
		this.totCargosMe = totCargosMe;
	}
	public double getTotDescuento() {
		return totDescuento;
	}
	public void setTotDescuento(double totDescuento) {
		this.totDescuento = totDescuento;
	}
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}
	public String getUsuario() {
		return usuario;
	}
	public void setUsuario(String usuario) {
		this.usuario = usuario;
	}
	public long getCodCiclo() {
		return codCiclo;
	}
	public void setCodCiclo(long codCiclo) {
		this.codCiclo = codCiclo;
	}

}
