package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;


/**
* 
* @tmas.legacy.jdbc.storedprocedure id = "consultaServicioSuplem" package = "GE_INTEGRACION_PG" sp = "GE_REC_SERV_SUPL_ABONADO_PR"
* jndiProperty = "IntegracionGteSclDs"
* servicioMetodo = "consultaServicioSuplem"
* servicioPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroEntrada = "ConServSupleDTO"
* servicioPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroSalida = "ServicioSupleRespondeDTO"
* comentario = "Entrega Datos de los servicios suplementario"
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultaServicioSuplem"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "ConServSupleDTO" mappingProperty = "numeroAbonado" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultaServicioSuplem"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "ConServSupleDTO" mappingProperty = "tipo" parentProperty = ""
*  
* 
*  
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultaServicioSuplem"   clase="salida" name="CURSOROUT" tipo="CURSOR"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "ServicioSuplementarioDTO" mappingProperty = "" parentProperty = "listaServiciosDefectoalPlan"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultaServicioSuplem" name="CURSOROUT" mappingProperty = "codServicio" mappingField = "cod_servicio"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultaServicioSuplem" name="CURSOROUT" mappingProperty = "desServicio" mappingField = "des_servicio" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultaServicioSuplem" name="CURSOROUT" mappingProperty = "codServsupl" mappingField = "cod_servsupl"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultaServicioSuplem" name="CURSOROUT" mappingProperty = "codNivel" mappingField = "cod_nivel"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultaServicioSuplem" name="CURSOROUT" mappingProperty = "impTarifaSs" mappingField = "imp_tarifa_ss"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultaServicioSuplem" name="CURSOROUT" mappingProperty = "desMonedaSs" mappingField = "des_moneda_ss"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultaServicioSuplem" name="CURSOROUT" mappingProperty = "codConceptoSs" mappingField = "cod_concepto_ss"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultaServicioSuplem" name="CURSOROUT" mappingProperty = "impTarifaFa" mappingField = "imp_tarifa_fa"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultaServicioSuplem" name="CURSOROUT" mappingProperty = "desMonedaFa" mappingField = "des_moneda_fa"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultaServicioSuplem" name="CURSOROUT" mappingProperty = "codConceptoFa" mappingField = "cod_concepto_ss"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultaServicioSuplem" name="CURSOROUT" mappingProperty = "letra" mappingField = "letra"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultaServicioSuplem" name="CURSOROUT" mappingProperty = "indTuxedo" mappingField = "ind_tuxedo"
*    
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultaServicioSuplem" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "codigoError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultaServicioSuplem" clase="salida" name="" tipo="VARCHAR" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "mensajeError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultaServicioSuplem" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "numeroEvento"
* 
* 
* * @tmas.legacy.jdbc.storedprocedure id = "actDesServicioSuplem" package = "Pv_Serv_Suplementario_Sb_Pg" sp = "pv_act_desact_ss_pr"
* jndiProperty = "IntegracionGteSclDs"
* servicioMetodo = "actDesServicioSuplem"
* servicioPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroEntrada = "ActDesSSDto"
* servicioPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroSalida = "RespuestaDTO"
* comentario = "Activa o desactiva Servicios Suplementarios"
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "actDesServicioSuplem"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "ActDesSSDto" mappingProperty = "numAbonado" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "actDesServicioSuplem"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "ActDesSSDto" mappingProperty = "numTelefono" parentProperty = ""
* * @tmas.legacy.jdbc.storedprocedure.parametro id = "actDesServicioSuplem"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "ActDesSSDto" mappingProperty = "listaSSAct" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "actDesServicioSuplem"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "ActDesSSDto" mappingProperty = "listaSSDes" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "actDesServicioSuplem"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "ActDesSSDto" mappingProperty = "numSecuencia" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "actDesServicioSuplem"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "ActDesSSDto" mappingProperty = "codOOSS" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "actDesServicioSuplem"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "ActDesSSDto" mappingProperty = "imporTotal" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "actDesServicioSuplem"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "ActDesSSDto" mappingProperty = "usuario" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "actDesServicioSuplem"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "ActDesSSDto" mappingProperty = "Comentario" parentProperty = ""

*    
* @tmas.legacy.jdbc.storedprocedure.parametro id = "actDesServicioSuplem" clase="salida" name="" tipo="NUMERIC" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "codigoError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "actDesServicioSuplem" clase="salida" name="" tipo="VARCHAR" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "mensajeError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "actDesServicioSuplem" clase="salida" name="" tipo="NUMERIC" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "numeroEvento"
* 
* 
* @tmas.legacy.jdbc.storedprocedure id = "consultarSSActivos" package = "GE_INTEGRACION_PG" sp = "ge_consultar_ss_vigentes_pr"
* jndiProperty = "IntegracionGteSclDs"
* servicioMetodo = "consultarSSActivos"
* servicioPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroEntrada = "AbonadoDTO"
* servicioPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroSalida = "LstComponentesDTO"
* comentario = "Entrega lista de Servicio Suplementario Activos de un Abonado"
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarSSActivos"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "AbonadoDTO" mappingProperty = "numAbonado" parentProperty = ""
*
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarSSActivos"   clase="salida" name="CURSOROUT" tipo="CURSOR"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "ComponentesDTO" mappingProperty = "" parentProperty = "SerciviosSuplementarios"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarSSActivos" name="CURSOROUT" mappingProperty = "codServicio" mappingField = "cod_servicio"  
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarSSActivos" name="CURSOROUT" mappingProperty = "codServsupl" mappingField = "cod_servsupl" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarSSActivos" name="CURSOROUT" mappingProperty = "codNivel" mappingField = "cod_nivel"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarSSActivos" name="CURSOROUT" mappingProperty = "desServicio" mappingField = "des_servicio"
* 
*   
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarSSActivos" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "codigoError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarSSActivos" clase="salida" name="" tipo="VARCHAR" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "mensajeError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarSSActivos" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "numeroEvento"
* 
* @tmas.legacy.jdbc.storedprocedure id = "consultarSSInactivos" package = "GE_INTEGRACION_PG" sp = "ge_consultar_ss_inactivos_pr"
* jndiProperty = "IntegracionGteSclDs"
* servicioMetodo = "consultarSSInactivos"
* servicioPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroEntrada = "AbonadoDTO"
* servicioPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroSalida = "LstComponentesDTO"
* comentario = "Entrega lista de Servicio Suplementario Inactivos de un Abonado"
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarSSInactivos"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "AbonadoDTO" mappingProperty = "numAbonado" parentProperty = ""
*
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarSSInactivos"   clase="salida" name="CURSOROUT" tipo="CURSOR"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "ComponentesDTO" mappingProperty = "" parentProperty = "SerciviosSuplementarios"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarSSInactivos" name="CURSOROUT" mappingProperty = "codServicio" mappingField = "cod_servicio"  
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarSSInactivos" name="CURSOROUT" mappingProperty = "codServsupl" mappingField = "cod_servsupl" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarSSInactivos" name="CURSOROUT" mappingProperty = "codNivel" mappingField = "cod_nivel"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarSSInactivos" name="CURSOROUT" mappingProperty = "desServicio" mappingField = "des_servicio"
* 
*   
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarSSInactivos" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "codigoError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarSSInactivos" clase="salida" name="" tipo="VARCHAR" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "mensajeError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarSSInactivos" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "numeroEvento"
* 
* 
* 
* 
* 
*/

public class ServicioSuplementarioDTO implements Serializable{
	/*
	 * Autor : Juan D. Muñoz Queupul
	 * */
	private static final long serialVersionUID = 1L;
	private  String    codServicio;      																								 
	private	 String    desServicio;      																								 
	private	 long      codServsupl;      																								 
	private	 long      codNivel;         																								 
	private	 double    impTarifaSs;     																								 
	private	 String    desMonedaSs;     																								 
	private	 long      codConceptoSs;   																								 
	private	 double    impTarifaFa;     																								 
	private	 String    desMonedaFa;     																								 
	private	 long      codConceptoFa;   																								 
	private	 String    letra;             																								 
	private	 int       indTuxedo;
	
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}

	public long getCodConceptoSs() {
		return codConceptoSs;
	}

	public void setCodConceptoSs(long codConceptoSs) {
		this.codConceptoSs = codConceptoSs;
	}

	public long getCodNivel() {
		return codNivel;
	}

	public void setCodNivel(long codNivel) {
		this.codNivel = codNivel;
	}

	public String getCodServicio() {
		return codServicio;
	}

	public void setCodServicio(String codServicio) {
		this.codServicio = codServicio;
	}

	public long getCodServsupl() {
		return codServsupl;
	}

	public void setCodServsupl(long codServsupl) {
		this.codServsupl = codServsupl;
	}

	public String getDesMonedaFa() {
		return desMonedaFa;
	}

	public void setDesMonedaFa(String desMonedaFa) {
		this.desMonedaFa = desMonedaFa;
	}

	public String getDesMonedaSs() {
		return desMonedaSs;
	}

	public void setDesMonedaSs(String desMonedaSs) {
		this.desMonedaSs = desMonedaSs;
	}

	public String getDesServicio() {
		return desServicio;
	}

	public void setDesServicio(String desServicio) {
		this.desServicio = desServicio;
	}


	public int getIndTuxedo() {
		return indTuxedo;
	}

	public void setIndTuxedo(int indTuxedo) {
		this.indTuxedo = indTuxedo;
	}

	public String getLetra() {
		return letra;
	}

	public void setLetra(String letra) {
		this.letra = letra;
	}

	public long getCodConceptoFa() {
		return codConceptoFa;
	}

	public void setCodConceptoFa(long codConceptoFa) {
		this.codConceptoFa = codConceptoFa;
	}

	public double getImpTarifaSs() {
		return impTarifaSs;
	}

	public void setImpTarifaSs(double impTarifaSs) {
		this.impTarifaSs = impTarifaSs;
	}

	public double getImpTarifaFa() {
		return impTarifaFa;
	}

	public void setImpTarifaFa(double impTarifaFa) {
		this.impTarifaFa = impTarifaFa;
	}


	

	
}
