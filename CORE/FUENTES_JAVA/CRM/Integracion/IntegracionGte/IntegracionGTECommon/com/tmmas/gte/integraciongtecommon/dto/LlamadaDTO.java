package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;
/**
* 
* @tmas.legacy.jdbc.storedprocedure id = "lstLlamadasNoFacturadas" package = "TOL_CONSULTA_TRAFICO_PG" sp = "TOL_DETALLETRAF_CLIENTE_PR"
* jndiProperty = "IntegracionGteTolDs"
* servicioMetodo = "lstLlamadasNoFacturadas"
* servicioPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroEntrada = "LlamadaInDTO"
* servicioPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroSalida = "LlamadoResponseDTO"
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
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "LlamadaDTO" mappingProperty = "" parentProperty = "lstListadoLlamados"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "lstLlamadasNoFacturadas" name="CURSOROUT" mappingProperty = "fechaLlamada" mappingField = "Fecha_llamada"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "lstLlamadasNoFacturadas" name="CURSOROUT" mappingProperty = "horaLlamada"  mappingField = "hora_llamada" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "lstLlamadasNoFacturadas" name="CURSOROUT" mappingProperty = "numeroDestino"  mappingField = "numero_destino" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "lstLlamadasNoFacturadas" name="CURSOROUT" mappingProperty = "mtoLlamSinImp"  mappingField = "mto_fact_sin_impuesto" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "lstLlamadasNoFacturadas" name="CURSOROUT" mappingProperty = "mtoLlamConImp"  mappingField = "mto_fact_con_impuesto" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "lstLlamadasNoFacturadas" name="CURSOROUT" mappingProperty = "tipoLlamada"  mappingField = "tipo_llamada" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "lstLlamadasNoFacturadas" name="CURSOROUT" mappingProperty = "duración"  mappingField = "duracion" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "lstLlamadasNoFacturadas" name="CURSOROUT" mappingProperty = "unidad"  mappingField = "unidad" 
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
*/ 



public class LlamadaDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	private String fechaLlamada;  
	private String horaLlamada;   
	private String numeroDestino; 
	private long mtoLlamSinImp;   
	private long mtoLlamConImp;   
	private String tipoLlamada;   
	private long duración;        
	private String unidad;        
	private RespuestaDTO respuesta;
	
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}
	public long getDuración() {
		return duración;
	}
	public void setDuración(long duración) {
		this.duración = duración;
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
	public long getMtoLlamConImp() {
		return mtoLlamConImp;
	}
	public void setMtoLlamConImp(long mtoLlamConImp) {
		this.mtoLlamConImp = mtoLlamConImp;
	}
	public long getMtoLlamSinImp() {
		return mtoLlamSinImp;
	}
	public void setMtoLlamSinImp(long mtoLlamSinImp) {
		this.mtoLlamSinImp = mtoLlamSinImp;
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
	
	

     

	
	


}
