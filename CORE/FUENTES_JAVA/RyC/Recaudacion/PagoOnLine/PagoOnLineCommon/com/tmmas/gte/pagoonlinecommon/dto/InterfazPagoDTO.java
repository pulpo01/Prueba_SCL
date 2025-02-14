package com.tmmas.gte.pagoonlinecommon.dto;

/**
* 
* @tmas.legacy.jdbc.storedprocedure id = "interfazPago" package = "CO_PAGOSONLINE_PG" sp = "CE_APLICA_PAGO_PR"
* jndiProperty = "scl.pagos.online"
* servicioMetodo = "ingresaPagoInterfaz"
* servicioPaqueteEntrada = "com.tmmas.gte.pagoonlinecommon.dto"
* servicioParametroEntrada = "InterfazPagoDTO"
* servicioPaqueteSalida = "com.tmmas.gte.pagoonlinecommon.dto"
* servicioParametroSalida = "RespuestaDTO"
* comentario = "Ingresa registro de Pago en la interfaz de Pagos (CO_INTERFAZ_PAGOS)"
* @tmas.legacy.jdbc.storedprocedure.parametro id = "interfazPago" clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.pagoonlinecommon.dto" mappingParametroEntrada = "InterfazPagoDTO" mappingProperty = "codBanco" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "interfazPago" clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.pagoonlinecommon.dto" mappingParametroEntrada = "InterfazPagoDTO" mappingProperty = "codCaja" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "interfazPago" clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.pagoonlinecommon.dto" mappingParametroEntrada = "InterfazPagoDTO" mappingProperty = "servicioSolicitado" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "interfazPago" clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.pagoonlinecommon.dto" mappingParametroEntrada = "InterfazPagoDTO" mappingProperty = "fecEfectividad" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "interfazPago" clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.pagoonlinecommon.dto" mappingParametroEntrada = "InterfazPagoDTO" mappingProperty = "numTransaccion" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "interfazPago" clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.pagoonlinecommon.dto" mappingParametroEntrada = "InterfazPagoDTO" mappingProperty = "operador" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "interfazPago" clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.pagoonlinecommon.dto" mappingParametroEntrada = "InterfazPagoDTO" mappingProperty = "tipTransaccion" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "interfazPago" clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.pagoonlinecommon.dto" mappingParametroEntrada = "InterfazPagoDTO" mappingProperty = "subTipo" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "interfazPago" clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.pagoonlinecommon.dto" mappingParametroEntrada = "InterfazPagoDTO" mappingProperty = "codServicio" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "interfazPago" clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.pagoonlinecommon.dto" mappingParametroEntrada = "InterfazPagoDTO" mappingProperty = "numEjercicio" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "interfazPago" clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.pagoonlinecommon.dto" mappingParametroEntrada = "InterfazPagoDTO" mappingProperty = "codCliente" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "interfazPago" clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.pagoonlinecommon.dto" mappingParametroEntrada = "InterfazPagoDTO" mappingProperty = "numCelular" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "interfazPago" clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.pagoonlinecommon.dto" mappingParametroEntrada = "InterfazPagoDTO" mappingProperty = "mtoPago" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "interfazPago" clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.pagoonlinecommon.dto" mappingParametroEntrada = "InterfazPagoDTO" mappingProperty = "numFolioCTC" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "interfazPago" clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.pagoonlinecommon.dto" mappingParametroEntrada = "InterfazPagoDTO" mappingProperty = "tipValor" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "interfazPago" clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.pagoonlinecommon.dto" mappingParametroEntrada = "InterfazPagoDTO" mappingProperty = "numCheque" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "interfazPago" clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.pagoonlinecommon.dto" mappingParametroEntrada = "InterfazPagoDTO" mappingProperty = "bancoCheque" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "interfazPago" clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.pagoonlinecommon.dto" mappingParametroEntrada = "InterfazPagoDTO" mappingProperty = "ctaCte" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "interfazPago" clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.pagoonlinecommon.dto" mappingParametroEntrada = "InterfazPagoDTO" mappingProperty = "numAutorizacion" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "interfazPago" clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.pagoonlinecommon.dto" mappingParametroEntrada = "InterfazPagoDTO" mappingProperty = "numTarjeta" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "interfazPago" clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.pagoonlinecommon.dto" mappingParametroEntrada = "InterfazPagoDTO" mappingProperty = "agencia" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "interfazPago" clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.pagoonlinecommon.dto" mappingParametroEntrada = "InterfazPagoDTO" mappingProperty = "codOperacion" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "interfazPago" clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.pagoonlinecommon.dto" mappingParametroEntrada = "InterfazPagoDTO" mappingProperty = "numTransaccionEmp" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "interfazPago" clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.pagoonlinecommon.dto" mappingParametroEntrada = "InterfazPagoDTO" mappingProperty = "tipTarjeta" parentProperty = ""
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "interfazPago" clase="salida" name="" tipo="NUMERIC" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.pagoonlinecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "codigoError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "interfazPago" clase="salida" name="" tipo="VARCHAR" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.pagoonlinecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "mensajeError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "interfazPago" clase="salida" name="" tipo="NUMERIC" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.pagoonlinecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "numeroEvento"
*
*
* 
* 
* 
* 
* 
*
*/

public class InterfazPagoDTO implements java.io.Serializable{
	private static final long serialVersionUID = 1L;
	private String codBanco;
	private int codCaja;
	private String servicioSolicitado;
	private String fecEfectividad;
	private int numTransaccion;
	private String operador;
	private String tipTransaccion;
	private String subTipo;
	private int codServicio;
	private String numEjercicio;
	private long codCliente;
	private long numCelular;
	private double mtoPago;
	private String numFolioCTC;
	private int tipValor;
	private int numCheque;
	private String bancoCheque;
	private String ctaCte;
	private String numAutorizacion;
	private String numTarjeta;
	private String agencia;
	private int codOperacion;
	private int numTransaccionEmp;
	private String tipTarjeta;
	
	public String getAgencia() {
		return agencia;
	}
	public void setAgencia(String agencia) {
		this.agencia = agencia;
	}
	public String getBancoCheque() {
		return bancoCheque;
	}
	public void setBancoCheque(String bancoCheque) {
		this.bancoCheque = bancoCheque;
	}
	public String getCodBanco() {
		return codBanco;
	}
	public void setCodBanco(String codBanco) {
		this.codBanco = codBanco;
	}
	public int getCodCaja() {
		return codCaja;
	}
	public void setCodCaja(int codCaja) {
		this.codCaja = codCaja;
	}
	public long getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(long codCliente) {
		this.codCliente = codCliente;
	}
	public int getCodOperacion() {
		return codOperacion;
	}
	public void setCodOperacion(int codOperacion) {
		this.codOperacion = codOperacion;
	}
	public String getServicioSolicitado() {
		return servicioSolicitado;
	}
	public void setServicioSolicitado(String servicioSolicitado) {
		this.servicioSolicitado = servicioSolicitado;
	}
	public int getCodServicio() {
		return codServicio;
	}
	public void setCodServicio(int codServicio) {
		this.codServicio = codServicio;
	}
	public String getCtaCte() {
		return ctaCte;
	}
	public void setCtaCte(String ctaCte) {
		this.ctaCte = ctaCte;
	}
	public String getFecEfectividad() {
		return fecEfectividad;
	}
	public void setFecEfectividad(String fecEfectividad) {
		this.fecEfectividad = fecEfectividad;
	}
	public double getMtoPago() {
		return mtoPago;
	}
	public void setMtoPago(double mtoPago) {
		this.mtoPago = mtoPago;
	}
	public String getNumAutorizacion() {
		return numAutorizacion;
	}
	public void setNumAutorizacion(String numAutorizacion) {
		this.numAutorizacion = numAutorizacion;
	}
	public long getNumCelular() {
		return numCelular;
	}
	public void setNumCelular(long numCelular) {
		this.numCelular = numCelular;
	}
	public int getNumCheque() {
		return numCheque;
	}
	public void setNumCheque(int numCheque) {
		this.numCheque = numCheque;
	}
	public String getNumEjercicio() {
		return numEjercicio;
	}
	public void setNumEjercicio(String numEjercicio) {
		this.numEjercicio = numEjercicio;
	}
	public String getNumFolioCTC() {
		return numFolioCTC;
	}
	public void setNumFolioCTC(String numFolioCTC) {
		this.numFolioCTC = numFolioCTC;
	}
	public String getNumTarjeta() {
		return numTarjeta;
	}
	public void setNumTarjeta(String numTarjeta) {
		this.numTarjeta = numTarjeta;
	}
	public int getNumTransaccion() {
		return numTransaccion;
	}
	public void setNumTransaccion(int numTransaccion) {
		this.numTransaccion = numTransaccion;
	}
	public String getOperador() {
		return operador;
	}
	public void setOperador(String operador) {
		this.operador = operador;
	}
	public String getSubTipo() {
		return subTipo;
	}
	public void setSubTipo(String subTipo) {
		this.subTipo = subTipo;
	}
	public String getTipTransaccion() {
		return tipTransaccion;
	}
	public void setTipTransaccion(String tipTransaccion) {
		this.tipTransaccion = tipTransaccion;
	}
	public int getTipValor() {
		return tipValor;
	}
	public void setTipValor(int tipValor) {
		this.tipValor = tipValor;
	}
	public int getNumTransaccionEmp() {
		return numTransaccionEmp;
	}
	public void setNumTransaccionEmp(int numTransaccionEmp) {
		this.numTransaccionEmp = numTransaccionEmp;
	}
	public String getTipTarjeta() {
		return tipTarjeta;
	}
	public void setTipTarjeta(String tipTarjeta) {
		this.tipTarjeta = tipTarjeta;
	}


}