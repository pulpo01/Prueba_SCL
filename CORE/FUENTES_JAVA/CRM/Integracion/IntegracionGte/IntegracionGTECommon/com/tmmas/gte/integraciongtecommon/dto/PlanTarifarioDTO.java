package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;
/**

* 
* @tmas.legacy.jdbc.storedprocedure id = "consultarPlanTarifario" package = "GE_INTEGRACION_PG" sp = "GE_CONS_PLANTARIF_PR"
* jndiProperty = "IntegracionGteSclDs"
* servicioMetodo = "consultarPlanTarifario"
* servicioPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroEntrada = "ConPlanDTO"
* servicioPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroSalida = "PlanTarifarioResponseDTO"
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarPlanTarifario"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"  mappingParametroEntrada = "ConPlanDTO"  mappingProperty = "numeroTelefono" parentProperty = ""
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarPlanTarifario"   clase="salida" name="" tipo="VARCHAR" parentProperty = "listPlanTarifario"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "PlanTarifarioDTO" mappingProperty = "codPlanTarifario" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarPlanTarifario"   clase="salida" name="" tipo="VARCHAR" parentProperty = "listPlanTarifario"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "PlanTarifarioDTO" mappingProperty = "desPlanTarifario" 
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarPlanTarifario" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "codigoError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarPlanTarifario" clase="salida" name="" tipo="VARCHAR" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "mensajeError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarPlanTarifario" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "numeroEvento"
* 
* 
* 
* 
* @tmas.legacy.jdbc.storedprocedure id = "consultarPlanesDisponibles" package = "GE_INTEGRACION_PG" sp = "ge_cons_planes_disponibles_pr"
* jndiProperty = "IntegracionGteSclDs"
* servicioMetodo = "consultarPlanesDisponibles"
* servicioPaqueteEntrada = ""
* servicioParametroEntrada = ""
* servicioPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroSalida = "PlanTarifarioResponseDTO"
* comentario = "Retorna todos los planes tarifarios vigentes"
*
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarPlanesDisponibles"   clase="salida" name="CURSOROUT" tipo="CURSOR"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "PlanTarifarioDTO" mappingProperty = "" parentProperty = "listPlanTarifario"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarPlanesDisponibles" name="CURSOROUT" mappingProperty = "codPlanTarifario" mappingField = "cod_plantarif"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarPlanesDisponibles" name="CURSOROUT" mappingProperty = "desPlanTarifario" mappingField = "des_plantarif" 	
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarPlanesDisponibles" name="CURSOROUT" mappingProperty = "grpPrestacion" mappingField = "grp_prestacion"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarPlanesDisponibles" name="CURSOROUT" mappingProperty = "desGrupoPrestacion" mappingField = "des_grupo_prestacion"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarPlanesDisponibles" name="CURSOROUT" mappingProperty = "codPrestacion" mappingField = "cod_prestacion"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarPlanesDisponibles" name="CURSOROUT" mappingProperty = "desPrestacion" mappingField = "des_prestacion"
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarPlanesDisponibles" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "codigoError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarPlanesDisponibles" clase="salida" name="" tipo="VARCHAR" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "mensajeError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarPlanesDisponibles" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "numeroEvento"
* 
* 
* 
* 
* @tmas.legacy.jdbc.storedprocedure id = "consultarPlanesDisponibles" package = "GE_INTEGRACION_PG" sp = "ge_cons_planes_disponibles_pr"
* jndiProperty = "IntegracionGteSclDs"
* servicioMetodo = "consultarPlanesDisponibles"
* servicioPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroEntrada = "PlanTarifarioDTO"
* servicioPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroSalida = "PlanTarifarioResponseDTO"
* comentario = "Retorna todos los planes tarifarios vigentes filtrando por grpPrestacion"
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarPlanesDisponibles"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"  mappingParametroEntrada = "PlanTarifarioDTO"  mappingProperty = "grpPrestacion" parentProperty = ""
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarPlanesDisponibles"   clase="salida" name="CURSOROUT" tipo="CURSOR"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "PlanTarifarioDTO" mappingProperty = "" parentProperty = "listPlanTarifario"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarPlanesDisponibles" name="CURSOROUT" mappingProperty = "codPlanTarifario" mappingField = "cod_plantarif"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarPlanesDisponibles" name="CURSOROUT" mappingProperty = "desPlanTarifario" mappingField = "des_plantarif" 	
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarPlanesDisponibles" name="CURSOROUT" mappingProperty = "grpPrestacion" mappingField = "grp_prestacion"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarPlanesDisponibles" name="CURSOROUT" mappingProperty = "desGrupoPrestacion" mappingField = "des_grupo_prestacion"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarPlanesDisponibles" name="CURSOROUT" mappingProperty = "codPrestacion" mappingField = "cod_prestacion"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarPlanesDisponibles" name="CURSOROUT" mappingProperty = "desPrestacion" mappingField = "des_prestacion" 
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarPlanesDisponibles" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "codigoError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarPlanesDisponibles" clase="salida" name="" tipo="VARCHAR" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "mensajeError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarPlanesDisponibles" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "numeroEvento"
* 
* 
* 
* 
* @tmas.legacy.jdbc.storedprocedure id = "consultarPlanesDisponibles" package = "GE_INTEGRACION_PG" sp = "ge_cons_planes_disponibles_pr"
* jndiProperty = "IntegracionGteSclDs"
* servicioMetodo = "consultarPlanesDisponibles"
* servicioPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroEntrada = "PlanTarifarioDTO"
* servicioPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroSalida = "PlanTarifarioResponseDTO"
* comentario = "Retorna todos los planes tarifarios vigentes filtrando por grpPrestacion y codPrestacion"
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarPlanesDisponibles"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"  mappingParametroEntrada = "PlanTarifarioDTO"  mappingProperty = "grpPrestacion" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarPlanesDisponibles"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"  mappingParametroEntrada = "PlanTarifarioDTO"  mappingProperty = "codPrestacion" parentProperty = ""
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarPlanesDisponibles"   clase="salida" name="CURSOROUT" tipo="CURSOR"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "PlanTarifarioDTO" mappingProperty = "" parentProperty = "listPlanTarifario"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarPlanesDisponibles" name="CURSOROUT" mappingProperty = "codPlanTarifario" mappingField = "cod_plantarif"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarPlanesDisponibles" name="CURSOROUT" mappingProperty = "desPlanTarifario" mappingField = "des_plantarif" 	
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarPlanesDisponibles" name="CURSOROUT" mappingProperty = "grpPrestacion" mappingField = "grp_prestacion"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarPlanesDisponibles" name="CURSOROUT" mappingProperty = "desGrupoPrestacion" mappingField = "des_grupo_prestacion"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarPlanesDisponibles" name="CURSOROUT" mappingProperty = "codPrestacion" mappingField = "cod_prestacion"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarPlanesDisponibles" name="CURSOROUT" mappingProperty = "desPrestacion" mappingField = "des_prestacion" 
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarPlanesDisponibles" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "codigoError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarPlanesDisponibles" clase="salida" name="" tipo="VARCHAR" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "mensajeError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarPlanesDisponibles" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "numeroEvento"
* 
* 
*/ 



public class PlanTarifarioDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	private String codPlanTarifario;
	private String desPlanTarifario;
	private String grpPrestacion;
	private String desGrupoPrestacion;
	private String codPrestacion;
	private String desPrestacion;
	
	public String getCodPrestacion() {
		return codPrestacion;
	}
	public void setCodPrestacion(String codPrestacion) {
		this.codPrestacion = codPrestacion;
	}
	public String getDesGrupoPrestacion() {
		return desGrupoPrestacion;
	}
	public void setDesGrupoPrestacion(String desGrupoPrestacion) {
		this.desGrupoPrestacion = desGrupoPrestacion;
	}
	public String getDesPrestacion() {
		return desPrestacion;
	}
	public void setDesPrestacion(String desPrestacion) {
		this.desPrestacion = desPrestacion;
	}
	public String getGrpPrestacion() {
		return grpPrestacion;
	}
	public void setGrpPrestacion(String grpPrestacion) {
		this.grpPrestacion = grpPrestacion;
	}
	public String getCodPlanTarifario() {
		return codPlanTarifario;
	}
	public void setCodPlanTarifario(String codPlanTarifario) {
		this.codPlanTarifario = codPlanTarifario;
	}
	public String getDesPlanTarifario() {
		return desPlanTarifario;
	}
	public void setDesPlanTarifario(String desPlanTarifario) {
		this.desPlanTarifario = desPlanTarifario;
	}

}
