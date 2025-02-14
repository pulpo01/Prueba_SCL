package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;

/**
* 
* @tmas.legacy.jdbc.storedprocedure id = "consultarDireccionXCodCliente" package = "GE_INTEGRACION_PG" sp = "GE_CONSULTARDIRECCLIENTE_PR"
* jndiProperty = "IntegracionGteSclDs"
* servicioMetodo = "consultarDireccionXCodCliente"
* servicioPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroEntrada = "ConsDirecDTO"
* servicioPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroSalida = "DireccionRespondeDTO"
* comentario = "Entrega el tipo de dirección, el código de dirección y las descripción"
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarDireccionXCodCliente"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "ConsDirecDTO" mappingProperty = "codCliente" parentProperty = ""
*  
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarDireccionXCodCliente"   clase="salida" name="CURSOROUT" tipo="CURSOR"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "DireccionDTO" mappingProperty = "" parentProperty = "listadoDireciones"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarAbonadoCliTel" name="CURSOROUT" mappingProperty = "codTipDireccion" mappingField = "cod_tipdireccion"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarAbonadoCliTel" name="CURSOROUT" mappingProperty = "codDireccion"  mappingField = "cod_direccion" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarAbonadoCliTel" name="CURSOROUT" mappingProperty = "desTipDireccion"  mappingField = "des_tipdireccion" 
*    
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarDireccionXCodCliente" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "codigoError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarDireccionXCodCliente" clase="salida" name="" tipo="VARCHAR" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "mensajeError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarDireccionXCodCliente" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "numeroEvento"
*
* 
* 
* 
* @tmas.legacy.jdbc.storedprocedure id = "consultarDireccionXCodClienteTipo" package = "GE_INTEGRACION_PG" sp = "GE_CONSULTARDIRECCLIENTE_PR"
* jndiProperty = "IntegracionGteSclDs"
* servicioMetodo = "consultarDireccionXCodClienteTipo"
* servicioPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroEntrada = "ConsDirecTipoDTO"
* servicioPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroSalida = "DireccionDTO"
* comentario = "Entrega el tipo de dirección y el código de dirección"
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarDireccionXCodClienteTipo"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "ConsDirecTipoDTO" mappingProperty = "codCliente" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarDireccionXCodClienteTipo"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "ConsDirecTipoDTO" mappingProperty = "tipDireccion" parentProperty = ""
*
*
** @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarDireccionXCodClienteTipo"   clase="salida" name="" tipo="VARCHAR"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "DireccionDTO" mappingProperty = "codTipDireccion" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarDireccionXCodClienteTipo"   clase="salida" name="" tipo="VARCHAR"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "DireccionDTO" mappingProperty = "codDireccion" parentProperty = ""
*    
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarDireccionXCodClienteTipo" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "codigoError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarDireccionXCodClienteTipo" clase="salida" name="" tipo="VARCHAR" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "mensajeError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarDireccionXCodClienteTipo" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "numeroEvento"
*
* 
* 
* 
* @tmas.legacy.jdbc.storedprocedure id = "consultarDireccion" package = "GE_DIRECCION_SB_PG" sp = "GE_consultarDireccion_PR"
* jndiProperty = "IntegracionGteSclDs"
* servicioMetodo = "consultarDireccion"
* servicioPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroEntrada = "DireccionInDTO"
* servicioPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroSalida = "DireccionDTO"
* comentario = "Entrega un DireccionResponseDTO con los datos"
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarDireccion"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "DireccionInDTO" mappingProperty = "codDireccion" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarDireccion"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "DireccionInDTO" mappingProperty = "codTipDireccion" parentProperty = ""
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarDireccion"   clase="salida" name="" tipo="VARCHAR"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "DireccionDTO" mappingProperty = "codTipoCalle" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarDireccion"   clase="salida" name="" tipo="VARCHAR"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "DireccionDTO" mappingProperty = "codTipDireccion" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarDireccion"   clase="salida" name="" tipo="VARCHAR"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "DireccionDTO" mappingProperty = "desTipDireccion" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarDireccion"   clase="salida" name="" tipo="VARCHAR"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "DireccionDTO" mappingProperty = "codDireccion" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarDireccion"   clase="salida" name="" tipo="VARCHAR"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "DireccionDTO" mappingProperty = "codProvincia" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarDireccion"   clase="salida" name="" tipo="VARCHAR"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "DireccionDTO" mappingProperty = "desProvincia" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarDireccion"   clase="salida" name="" tipo="VARCHAR"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "DireccionDTO" mappingProperty = "codRegion" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarDireccion"   clase="salida" name="" tipo="VARCHAR"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "DireccionDTO" mappingProperty = "desRegion" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarDireccion"   clase="salida" name="" tipo="VARCHAR"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "DireccionDTO" mappingProperty = "codCiudad" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarDireccion"   clase="salida" name="" tipo="VARCHAR"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "DireccionDTO" mappingProperty = "desCuidad" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarDireccion"   clase="salida" name="" tipo="VARCHAR"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "DireccionDTO" mappingProperty = "codComuna" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarDireccion"   clase="salida" name="" tipo="VARCHAR"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "DireccionDTO" mappingProperty = "desComuna" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarDireccion"   clase="salida" name="" tipo="VARCHAR"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "DireccionDTO" mappingProperty = "nomCalle" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarDireccion"   clase="salida" name="" tipo="VARCHAR"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "DireccionDTO" mappingProperty = "numCalle" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarDireccion"   clase="salida" name="" tipo="VARCHAR"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "DireccionDTO" mappingProperty = "numCasilla" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarDireccion"   clase="salida" name="" tipo="VARCHAR"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "DireccionDTO" mappingProperty = "obsDirecc" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarDireccion"   clase="salida" name="" tipo="VARCHAR"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "DireccionDTO" mappingProperty = "zip" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarDireccion"   clase="salida" name="" tipo="VARCHAR"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "DireccionDTO" mappingProperty = "desDirec1" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarDireccion"   clase="salida" name="" tipo="VARCHAR"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "DireccionDTO" mappingProperty = "desDirec2" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarDireccion"   clase="salida" name="" tipo="VARCHAR"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "DireccionDTO" mappingProperty = "codPueblo" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarDireccion"   clase="salida" name="" tipo="VARCHAR"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "DireccionDTO" mappingProperty = "codEstado" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarDireccion"   clase="salida" name="" tipo="VARCHAR"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "DireccionDTO" mappingProperty = "numPiso" parentProperty = ""
*
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarDireccion" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "codigoError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarDireccion" clase="salida" name="" tipo="VARCHAR" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "mensajeError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarDireccion" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "numeroEvento"
* 
*
*/ 

public class DireccionDTO  implements Serializable {
	
	/*
	 * Autor: Juan Daniel Muñoz Queupul
	 * */

	private static final long serialVersionUID = 1L;
    private String codTipoCalle;   
    private String codTipDireccion;
    private String desTipDireccion;
    private String codDireccion;   
    private String codProvincia;   
    private String desProvincia;   
    private String codRegion;      
    private String desRegion;      
    private String codCiudad;      
    private String desCuidad;      
    private String codComuna;      
    private String desComuna;      
    private String nomCalle;       
    private String numCalle;       
    private String numCasilla;     
    private String obsDirecc;      
    private String zip;            
    private String desDirec1;      
    private String desDirec2;      
    private String codPueblo;      
    private String codEstado;      
    private String numPiso;
    private RespuestaDTO respuesta;

    
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}
	public String getCodCiudad() {
		return codCiudad;
	}
	public void setCodCiudad(String codCiudad) {
		this.codCiudad = codCiudad;
	}
	public String getCodComuna() {
		return codComuna;
	}
	public void setCodComuna(String codComuna) {
		this.codComuna = codComuna;
	}

	public String getCodEstado() {
		return codEstado;
	}
	public void setCodEstado(String codEstado) {
		this.codEstado = codEstado;
	}
	public String getCodProvincia() {
		return codProvincia;
	}
	public void setCodProvincia(String codProvincia) {
		this.codProvincia = codProvincia;
	}
	public String getCodPueblo() {
		return codPueblo;
	}
	public void setCodPueblo(String codPueblo) {
		this.codPueblo = codPueblo;
	}
	public String getCodRegion() {
		return codRegion;
	}
	public void setCodRegion(String codRegion) {
		this.codRegion = codRegion;
	}
	public String getCodTipDireccion() {
		return codTipDireccion;
	}
	public void setCodTipDireccion(String codTipDireccion) {
		this.codTipDireccion = codTipDireccion;
	}
	public String getCodTipoCalle() {
		return codTipoCalle;
	}
	public void setCodTipoCalle(String codTipoCalle) {
		this.codTipoCalle = codTipoCalle;
	}
	public String getDesComuna() {
		return desComuna;
	}
	public void setDesComuna(String desComuna) {
		this.desComuna = desComuna;
	}
	public String getDesCuidad() {
		return desCuidad;
	}
	public void setDesCuidad(String desCuidad) {
		this.desCuidad = desCuidad;
	}
	public String getDesDirec1() {
		return desDirec1;
	}
	public void setDesDirec1(String desDirec1) {
		this.desDirec1 = desDirec1;
	}
	public String getDesDirec2() {
		return desDirec2;
	}
	public void setDesDirec2(String desDirec2) {
		this.desDirec2 = desDirec2;
	}
	public String getDesProvincia() {
		return desProvincia;
	}
	public void setDesProvincia(String desProvincia) {
		this.desProvincia = desProvincia;
	}
	public String getDesRegion() {
		return desRegion;
	}
	public void setDesRegion(String desRegion) {
		this.desRegion = desRegion;
	}
	public String getDesTipDireccion() {
		return desTipDireccion;
	}
	public void setDesTipDireccion(String desTipDireccion) {
		this.desTipDireccion = desTipDireccion;
	}
	public String getNomCalle() {
		return nomCalle;
	}
	public void setNomCalle(String nomCalle) {
		this.nomCalle = nomCalle;
	}
	public String getNumCalle() {
		return numCalle;
	}
	public void setNumCalle(String numCalle) {
		this.numCalle = numCalle;
	}
	public String getNumCasilla() {
		return numCasilla;
	}
	public void setNumCasilla(String numCasilla) {
		this.numCasilla = numCasilla;
	}
	public String getNumPiso() {
		return numPiso;
	}
	public void setNumPiso(String numPiso) {
		this.numPiso = numPiso;
	}
	public String getObsDirecc() {
		return obsDirecc;
	}
	public void setObsDirecc(String obsDirecc) {
		this.obsDirecc = obsDirecc;
	}
	public String getZip() {
		return zip;
	}
	public void setZip(String zip) {
		this.zip = zip;
	}
	public String getCodDireccion() {
		return codDireccion;
	}
	public void setCodDireccion(String codDireccion) {
		this.codDireccion = codDireccion;
	}
	public RespuestaDTO getRespuesta() {
		return respuesta;
	}
	public void setRespuesta(RespuestaDTO respuesta) {
		this.respuesta = respuesta;
	}        
   
	
	
	
		

	

}