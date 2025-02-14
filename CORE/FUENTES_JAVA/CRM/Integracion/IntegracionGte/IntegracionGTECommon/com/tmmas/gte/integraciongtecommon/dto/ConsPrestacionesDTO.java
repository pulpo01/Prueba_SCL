package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;

/**
* 
* @tmas.legacy.jdbc.storedprocedure id = "consultarCodigosPrestacion" package = "VE_parametros_comerciales_PG" sp = "VE_Obtiene_TipoPrest_PR"
* jndiProperty = "IntegracionGteSclDs"
* servicioMetodo = "consultarCodigosPrestacion"
* servicioPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroEntrada = "ConsPrestacionesInDTO"
* servicioPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroSalida = "ConsPrestacionesResponseDTO"
* comentario = "Retorna todas las Prestaciones existentes para clientes Prepago ó clientes Pospago e Híbrido"
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarCodigosPrestacion"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"  mappingParametroEntrada = "ConsPrestacionesDTO"  mappingProperty = "grpPrestacion" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarCodigosPrestacion"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"  mappingParametroEntrada = "ConsPrestacionesDTO"  mappingProperty = "idTipoPrestacion" parentProperty = ""
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarCodigosPrestacion"   clase="salida" name="CURSOROUT" tipo="CURSOR"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "ConsPrestacionesDTO" mappingProperty = "" parentProperty = "listPrestaciones"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarCodigosPrestacion" name="CURSOROUT" mappingProperty = "codPrestacion" mappingField = "COD_PRESTACION"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarCodigosPrestacion" name="CURSOROUT" mappingProperty = "desPrestacion" mappingField = "DES_PRESTACION" 	
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarCodigosPrestacion" name="CURSOROUT" mappingProperty = "tipVenta" mappingField = "TIP_VENTA"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarCodigosPrestacion" name="CURSOROUT" mappingProperty = "indNumero" mappingField = "IND_NUMERO"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarCodigosPrestacion" name="CURSOROUT" mappingProperty = "indDirInstalacion" mappingField = "IND_DIR_INSTALACION"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarCodigosPrestacion" name="CURSOROUT" mappingProperty = "indInventarioFijo" mappingField = "IND_INVENTARIO_FIJO" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarCodigosPrestacion" name="CURSOROUT" mappingProperty = "codPlanTarifDefecto" mappingField = "COD_PLANTARIF_DEFECTO" 	
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarCodigosPrestacion" name="CURSOROUT" mappingProperty = "codCentralDefecto" mappingField = "COD_CENTRAL_DEFECTO"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarCodigosPrestacion" name="CURSOROUT" mappingProperty = "codCeldaDefecto" mappingField = "COD_CELDA_DEFECTO"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarCodigosPrestacion" name="CURSOROUT" mappingProperty = "indssIntranet" mappingField = "IND_SS_INTERNET"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarCodigosPrestacion" name="CURSOROUT" mappingProperty = "tipRed" mappingField = "TIP_RED"  
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarCodigosPrestacion" name="CURSOROUT" mappingProperty = "grpPrestacion" mappingField = "GRP_PRESTACION"
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarCodigosPrestacion" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "codigoError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarCodigosPrestacion" clase="salida" name="" tipo="VARCHAR" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "mensajeError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarCodigosPrestacion" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "numeroEvento"
* 
*/ 

public class ConsPrestacionesDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	private String codPrestacion;
	private String desPrestacion;
	private int tipVenta;
	private int indNumero;
	private int indDirInstalacion;
	private int indInventarioFijo;
	private String codPlanTarifDefecto;
	private int codCentralDefecto;
	private String codCeldaDefecto;
	private int indSsIntranet;
	private String tipRed;
	private String grpPrestacion;

	

	public String getCodCeldaDefecto() {
		return codCeldaDefecto;
	}
	public void setCodCeldaDefecto(String codCeldaDefecto) {
		this.codCeldaDefecto = codCeldaDefecto;
	}
	public int getCodCentralDefecto() {
		return codCentralDefecto;
	}
	public void setCodCentralDefecto(int codCentralDefecto) {
		this.codCentralDefecto = codCentralDefecto;
	}
	public String getCodPlanTarifDefecto() {
		return codPlanTarifDefecto;
	}
	public void setCodPlanTarifDefecto(String codPlanTarifDefecto) {
		this.codPlanTarifDefecto = codPlanTarifDefecto;
	}
	public String getCodPrestacion() {
		return codPrestacion;
	}
	public void setCodPrestacion(String codPrestacion) {
		this.codPrestacion = codPrestacion;
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
	public int getIndDirInstalacion() {
		return indDirInstalacion;
	}
	public void setIndDirInstalacion(int indDirInstalacion) {
		this.indDirInstalacion = indDirInstalacion;
	}
	public int getIndInventarioFijo() {
		return indInventarioFijo;
	}
	public void setIndInventarioFijo(int indInventarioFijo) {
		this.indInventarioFijo = indInventarioFijo;
	}
	public int getIndNumero() {
		return indNumero;
	}
	public void setIndNumero(int indNumero) {
		this.indNumero = indNumero;
	}
	public int getIndssIntranet() {
		return indSsIntranet;
	}
	public void setIndssIntranet(int indssIntranet) {
		this.indSsIntranet = indssIntranet;
	}
	public String getTipRed() {
		return tipRed;
	}
	public void setTipRed(String tipRed) {
		this.tipRed = tipRed;
	}
	public int getTipVenta() {
		return tipVenta;
	}
	public void setTipVenta(int tipVenta) {
		this.tipVenta = tipVenta;
	}

	
}
