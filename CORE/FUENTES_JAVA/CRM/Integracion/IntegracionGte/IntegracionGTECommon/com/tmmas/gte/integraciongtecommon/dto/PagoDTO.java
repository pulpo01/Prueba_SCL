package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;
import java.util.Date;
/**
*  
* @tmas.legacy.jdbc.storedprocedure id = "consultaPagosRealizados" package = "GE_INTEGRACION_PG" sp = "GE_CONS_PAGOS_REALIZADO_PR"
* jndiProperty = "IntegracionGteSclDs"
* servicioMetodo = "consultaPagosRealizados"
* servicioPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroEntrada = "PagoInDTO"
* servicioPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroSalida = "PagoResponseDTO"
* comentario = "Ingresa como parametros un objeto de tipo PagoInDTO y despues devuelve un cursor con datos de los pagos, este se setean los datos en PagoResponseDTO"
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultaPagosRealizados"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "PagoInDTO" mappingProperty = "codCliente" parentProperty = ""
*  
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultaPagosRealizados"   clase="salida" name="CURSOROUT" tipo="CURSOR"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "PagoDTO" mappingProperty = "" parentProperty = "lstListadoPagos"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultaPagosRealizados" name="CURSOROUT" mappingProperty = "numSecuenci" mappingField = "num_secuenci"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultaPagosRealizados" name="CURSOROUT" mappingProperty = "codTipdocum"  mappingField = "cod_tipdocum" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultaPagosRealizados" name="CURSOROUT" mappingProperty = "codCliente"  mappingField = "cod_cliente" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultaPagosRealizados" name="CURSOROUT" mappingProperty = "impPago"  mappingField = "imp_pago" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultaPagosRealizados" name="CURSOROUT" mappingProperty = "codOripago"  mappingField = "cod_oripago" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultaPagosRealizados" name="CURSOROUT" mappingProperty = "codCaja"  mappingField = "cod_caja" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultaPagosRealizados" name="CURSOROUT" mappingProperty = "fecEfectividad"  mappingField = "fec_efectividad" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultaPagosRealizados" name="CURSOROUT" mappingProperty = "importeTotDoc"  mappingField = "importe_tot_doc" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultaPagosRealizados" name="CURSOROUT" mappingProperty = "numFolio"  mappingField = "num_folio" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultaPagosRealizados" name="CURSOROUT" mappingProperty = "codTipdocrel"  mappingField = "cod_tipdocrel" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultaPagosRealizados" name="CURSOROUT" mappingProperty = "prefPlaza"  mappingField = "pref_plaza" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultaPagosRealizados" name="CURSOROUT" mappingProperty = "numCompago"  mappingField = "num_compago" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultaPagosRealizados" name="CURSOROUT" mappingProperty = "codBanco"  mappingField = "cod_banco" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultaPagosRealizados" name="CURSOROUT" mappingProperty = "totFactura"  mappingField = "tot_factura" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultaPagosRealizados" name="CURSOROUT" mappingProperty = "totPagar"  mappingField = "tot_pagar" 
*    
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultaPagosRealizados" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "codigoError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultaPagosRealizados" clase="salida" name="" tipo="VARCHAR" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "mensajeError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultaPagosRealizados" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "numeroEvento"
*
*
* 
* 
* @tmas.legacy.jdbc.storedprocedure id = "consultarRecaudadora" package = "GE_INTEGRACION_PG" sp = "GE_CONS_RECAUDADORA_PAGO_PR"
* jndiProperty = "IntegracionGteSclDs"
* servicioMetodo = "consultarRecaudadora"
* servicioPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroEntrada = "PagoDTO"
* servicioPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroSalida = "PagoRecaudadoraOutDTO"
* comentario = "Ingresa como parametros un objeto de tipo PagoDTO y despues devuelve un objeto PagoRecaudadoraOutDTO, devuelve la recuadadora y la descripcion del la empresa"
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarRecaudadora"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"  mappingParametroEntrada = "PagoDTO"  mappingProperty = "prefPlaza" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarRecaudadora"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"  mappingParametroEntrada = "PagoDTO"  mappingProperty = "codCliente" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarRecaudadora"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"  mappingParametroEntrada = "PagoDTO"  mappingProperty = "numCompago" parentProperty = ""

* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarRecaudadora"   clase="salida" name="" tipo="VARCHAR" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "PagoRecaudadoraOutDTO" mappingProperty = "recaudadora" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarRecaudadora"   clase="salida" name="" tipo="VARCHAR" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "PagoRecaudadoraOutDTO" mappingProperty = "descripcionEmpresa" 
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarRecaudadora" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "codigoError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarRecaudadora" clase="salida" name="" tipo="VARCHAR" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "mensajeError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarRecaudadora" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "numeroEvento"
* 
* 
*/ 



public class PagoDTO implements Serializable {
	private static final long serialVersionUID = 1L;
    private long   numSecuenci;    
    private long   codTipdocum;    
    private long   codCliente;     
    private double   impPago;        
    private long   codOripago;     
    private String codCaja;        
    private Date   fecEfectividad; 
    private double   importeTotDoc; 
    private long   numFolio;       
    private long   codTipdocrel;   
    private String prefPlaza;      
    private long   numCompago;     
    private String codBanco; 
    private String desBanco;
    private double  totFactura;
    private double   totPagar;
    private Date fechaHora;
    private PagoRecaudadoraOutDTO recuadacion;
    private OficinaDTO oficina;
	private RespuestaDTO respuesta;
	
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}

	public String getCodBanco() {
		return codBanco;
	}

	public void setCodBanco(String codBanco) {
		this.codBanco = codBanco;
	}

	public String getCodCaja() {
		return codCaja;
	}

	public void setCodCaja(String codCaja) {
		this.codCaja = codCaja;
	}

	public long getCodCliente() {
		return codCliente;
	}

	public void setCodCliente(long codCliente) {
		this.codCliente = codCliente;
	}

	public long getCodOripago() {
		return codOripago;
	}

	public void setCodOripago(long codOripago) {
		this.codOripago = codOripago;
	}

	public long getCodTipdocrel() {
		return codTipdocrel;
	}

	public void setCodTipdocrel(long codTipdocrel) {
		this.codTipdocrel = codTipdocrel;
	}

	public long getCodTipdocum() {
		return codTipdocum;
	}

	public void setCodTipdocum(long codTipdocum) {
		this.codTipdocum = codTipdocum;
	}

	public Date getFecEfectividad() {
		return fecEfectividad;
	}

	public void setFecEfectividad(Date fecEfectividad) {
		this.fecEfectividad = fecEfectividad;
	}


	public long getNumCompago() {
		return numCompago;
	}

	public void setNumCompago(long numCompago) {
		this.numCompago = numCompago;
	}

	public long getNumFolio() {
		return numFolio;
	}

	public void setNumFolio(long numFolio) {
		this.numFolio = numFolio;
	}

	public long getNumSecuenci() {
		return numSecuenci;
	}

	public void setNumSecuenci(long numSecuenci) {
		this.numSecuenci = numSecuenci;
	}

	public String getPrefPlaza() {
		return prefPlaza;
	}

	public void setPrefPlaza(String prefPlaza) {
		this.prefPlaza = prefPlaza;
	}

	public RespuestaDTO getRespuesta() {
		return respuesta;
	}

	public void setRespuesta(RespuestaDTO respuesta) {
		this.respuesta = respuesta;
	}


	public PagoRecaudadoraOutDTO getRecuadacion() {
		return recuadacion;
	}

	public void setRecuadacion(PagoRecaudadoraOutDTO recuadacion) {
		this.recuadacion = recuadacion;
	}

	public String getDesBanco() {
		return desBanco;
	}

	public void setDesBanco(String desBanco) {
		this.desBanco = desBanco;
	}

	public OficinaDTO getOficina() {
		return oficina;
	}

	public void setOficina(OficinaDTO oficina) {
		this.oficina = oficina;
	}

	public Date getFechaHora() {
		return fechaHora;
	}

	public void setFechaHora(Date fechaHora) {
		this.fechaHora = fechaHora;
	}

	public double getImpPago() {
		return impPago;
	}

	public void setImpPago(double impPago) {
		this.impPago = impPago;
	}

	public double getTotFactura() {
		return totFactura;
	}

	public void setTotFactura(double totFactura) {
		this.totFactura = totFactura;
	}

	public double getTotPagar() {
		return totPagar;
	}

	public void setTotPagar(double totPagar) {
		this.totPagar = totPagar;
	}

	public double getImporteTotDoc() {
		return importeTotDoc;
	}

	public void setImporteTotDoc(double importeTotDoc) {
		this.importeTotDoc = importeTotDoc;
	}



}
