package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;
/**
* 
* @tmas.legacy.jdbc.storedprocedure id = "insertarAuditoria" package = "GE_INTEGRACION_PG" sp = "GE_INS_AUDITORIA_PR"
* jndiProperty = "IntegracionGteSclDs"
* servicioMetodo = "insertarAuditoria"
* servicioPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroEntrada = "AuditoriaDTO"
* servicioPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroSalida = "AuditoriaResponseDTO"
* comentario = "Inserta registros para auditoria"
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "insertarAuditoria"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "AuditoriaDTO" mappingProperty = "nombreUsuario" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "insertarAuditoria"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "AuditoriaDTO" mappingProperty = "codPuntoAcceso" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "insertarAuditoria"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "AuditoriaDTO" mappingProperty = "codAplicacion" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "insertarAuditoria"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "AuditoriaDTO" mappingProperty = "codServicio" parentProperty = ""
*  
* @tmas.legacy.jdbc.storedprocedure.parametro id = "insertarAuditoria" clase="salida" name="" tipo="NUMERIC"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "AuditoriaResponseDTO" mappingProperty = "codAuditoria" parentProperty = ""
*  
* @tmas.legacy.jdbc.storedprocedure.parametro id = "insertarAuditoria" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "codigoError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "insertarAuditoria" clase="salida" name="" tipo="VARCHAR" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "mensajeError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "insertarAuditoria" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "numeroEvento"
* 
* 
* @tmas.legacy.jdbc.storedprocedure id = "insertarServicios" package = "GE_INTEGRACION_PG" sp = "GE_INS_PARAM_SERV_PR"
* jndiProperty = "IntegracionGteSclDs"
* servicioMetodo = "insertarServicios"
* servicioPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroEntrada = "AuditoriaServicioDTO"
* servicioPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroSalida = "RespuestaDTO"
* comentario = "Inserta Parametros de Servicio para auditoria"
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "insertarServicios"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "AuditoriaServicioDTO" mappingProperty = "nombreUsuario" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "insertarServicios"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "AuditoriaServicioDTO" mappingProperty = "codAuditoria" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "insertarServicios"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "AuditoriaServicioDTO" mappingProperty = "nomParametro" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "insertarServicios"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "AuditoriaServicioDTO" mappingProperty = "valParametro" parentProperty = ""
*  
* @tmas.legacy.jdbc.storedprocedure.parametro id = "insertarServicios" clase="salida" name="" tipo="NUMERIC" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "codigoError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "insertarServicios" clase="salida" name="" tipo="VARCHAR" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "mensajeError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "insertarServicios" clase="salida" name="" tipo="NUMERIC" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "numeroEvento"
* 
* 
* @tmas.legacy.jdbc.storedprocedure id = "consultarPuntoAcceso" package = "GE_INTEGRACION_PG" sp = "ge_validar_pto_acceso_pr"
* jndiProperty = "IntegracionGteSclDs"
* servicioMetodo = "consultarPuntoAcceso"
* servicioPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroEntrada = "AuditoriaDTO"
* servicioPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroSalida = "PuntoAccesoResponseDTO"
* comentario = "Consulta Punto de acceso para auditoria"
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarPuntoAcceso"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "AuditoriaDTO" mappingProperty = "codPuntoAcceso" parentProperty = ""
* 
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarPuntoAcceso" clase="salida" name="" tipo="VARCHAR"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "PuntoAccesoResponseDTO" mappingProperty = "desPuntoAcceso" parentProperty = "" 
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarPuntoAcceso" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "codigoError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarPuntoAcceso" clase="salida" name="" tipo="VARCHAR" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "mensajeError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarPuntoAcceso" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "numeroEvento"
* 
* 
* @tmas.legacy.jdbc.storedprocedure id = "validarServicio" package = "GE_INTEGRACION_PG" sp = "ge_validar_servicio_pr"
* jndiProperty = "IntegracionGteSclDs"
* servicioMetodo = "validarServicio"
* servicioPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroEntrada = "AuditoriaDTO"
* servicioPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroSalida = "RespuestaDTO"
* comentario = "Valida si existe un Servicio para auditoria"
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "validarServicio"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "AuditoriaDTO" mappingProperty = "codServicio" parentProperty = ""
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "validarServicio" clase="salida" name="" tipo="NUMERIC" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "codigoError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "validarServicio" clase="salida" name="" tipo="VARCHAR" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "mensajeError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "validarServicio" clase="salida" name="" tipo="NUMERIC" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "numeroEvento"
*  
* @tmas.legacy.jdbc.storedprocedure id = "validarAplicacion" package = "GE_INTEGRACION_PG" sp = "ge_validar_aplicacion_pr"
* jndiProperty = "IntegracionGteSclDs"
* servicioMetodo = "validarAplicacion"
* servicioPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroEntrada = "AuditoriaDTO"
* servicioPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroSalida = "RespuestaDTO"
* comentario = "Valida si existe una Aplicación para auditoria"
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "validarAplicacion"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "AuditoriaDTO" mappingProperty = "codAplicacion" parentProperty = ""
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "validarAplicacion" clase="salida" name="" tipo="NUMERIC" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "codigoError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "validarAplicacion" clase="salida" name="" tipo="VARCHAR" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "mensajeError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "validarAplicacion" clase="salida" name="" tipo="NUMERIC" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "numeroEvento" 
* 
* @tmas.legacy.jdbc.storedprocedure id = "validarNombreUsuario" package = "GE_INTEGRACION_PG" sp = "ge_validar_usuario_pr"
* jndiProperty = "IntegracionGteSclDs"
* servicioMetodo = "validarNombreUsuario"
* servicioPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroEntrada = "AuditoriaDTO"
* servicioPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroSalida = "RespuestaDTO"
* comentario = "Valida si existe un Usuario para auditoria"
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "validarNombreUsuario"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "AuditoriaDTO" mappingProperty = "nombreUsuario" parentProperty = ""
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "validarNombreUsuario" clase="salida" name="" tipo="NUMERIC" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "codigoError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "validarNombreUsuario" clase="salida" name="" tipo="VARCHAR" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "mensajeError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "validarNombreUsuario" clase="salida" name="" tipo="NUMERIC" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "numeroEvento" 
* 
*/ 


public class AuditoriaDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	private String nombreUsuario;
	private String codPuntoAcceso;
	private String codAplicacion;
	private String codServicio;
	
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}
	public String getCodAplicacion() {
		return codAplicacion;
	}
	public void setCodAplicacion(String codAplicacion) {
		this.codAplicacion = codAplicacion;
	}
	public String getCodPuntoAcceso() {
		return codPuntoAcceso;
	}
	public void setCodPuntoAcceso(String codPuntoAcceso) {
		this.codPuntoAcceso = codPuntoAcceso;
	}
	public String getCodServicio() {
		return codServicio;
	}
	public void setCodServicio(String codServicio) {
		this.codServicio = codServicio;
	}
	public String getNombreUsuario() {
		return nombreUsuario;
	}
	public void setNombreUsuario(String nombreUsuario) {
		this.nombreUsuario = nombreUsuario;
	}

	
}
