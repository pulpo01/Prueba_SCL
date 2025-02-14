package com.tmmas.gte.pagoonlinecommon.dto;
/**
* 
* @tmas.legacy.jdbc.storedprocedure id = "saldo" package = "CO_PAGOSONLINE_PG" sp = "CO_SALDO_PR"
* jndiProperty = "scl.pagos.online"
* servicioMetodo = "obtenerSaldo"
* servicioPaqueteEntrada = "com.tmmas.gte.pagoonlinecommon.dto"
* servicioParametroEntrada = "ClientePagoDTO"
* servicioPaqueteSalida = "com.tmmas.gte.pagoonlinecommon.dto"
* servicioParametroSalida = "ClientePagoDTO"
* comentario = "Obtiene Saldo Vencido y Saldo por Vencer de un Cliente"
* @tmas.legacy.jdbc.storedprocedure.parametro id = "saldo" clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.pagoonlinecommon.dto" mappingParametroEntrada = "ClientePagoDTO" mappingProperty = "codCliente" parentProperty = ""
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "saldo" clase="salida" name="" tipo="NUMERIC" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.pagoonlinecommon.dto" mappingParametroSalida = "ClientePagoDTO" mappingProperty = "saldoVencido" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "saldo" clase="salida" name="" tipo="NUMERIC" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.pagoonlinecommon.dto" mappingParametroSalida = "ClientePagoDTO" mappingProperty = "saldoPorVencer" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "saldo" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.pagoonlinecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "codigoError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "saldo" clase="salida" name="" tipo="VARCHAR" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.pagoonlinecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "mensajeError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "saldo" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.pagoonlinecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "numeroEvento"
* 
* 
* 
* 
* 
* 
* @tmas.legacy.jdbc.storedprocedure id = "saldoLimite" package = "CO_PAGOSONLINE_PG" sp = "CO_SALDO_LIMITE_PR"
* jndiProperty = "scl.pagos.online"
* servicioMetodo = "obtenerSaldoLimite"
* servicioPaqueteEntrada = "com.tmmas.gte.pagoonlinecommon.dto"
* servicioParametroEntrada = "ClientePagoDTO"
* servicioPaqueteSalida = "com.tmmas.gte.pagoonlinecommon.dto"
* servicioParametroSalida = "ClientePagoDTO"
* comentario = "Obtiene Saldo Limite Consumo por Plan Tarifario y Saldo por Plan Adicional"
* @tmas.legacy.jdbc.storedprocedure.parametro id = "saldoLimite" clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.pagoonlinecommon.dto" mappingParametroEntrada = "ClientePagoDTO" mappingProperty = "codCliente" parentProperty = ""
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "saldoLimite" clase="salida" name="" tipo="NUMERIC" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.pagoonlinecommon.dto" mappingParametroSalida = "ClientePagoDTO" mappingProperty = "saldoLimiteConsumoPlanTarifario" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "saldoLimite" clase="salida" name="" tipo="NUMERIC" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.pagoonlinecommon.dto" mappingParametroSalida = "ClientePagoDTO" mappingProperty = "saldoLimiteConsumoPlanAdicional" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "saldoLimite" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.pagoonlinecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "codigoError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "saldoLimite" clase="salida" name="" tipo="VARCHAR" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.pagoonlinecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "mensajeError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "saldoLimite" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.pagoonlinecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "numeroEvento"
* 
* 
* 
* 
* 
* 
* @tmas.legacy.jdbc.storedprocedure id = "cliente" package = "CO_PAGOSONLINE_PG" sp = "CO_OBTIENECLIENTE_PR"
* jndiProperty = "scl.pagos.online"
* servicioMetodo = "obtenerCodCliente"
* servicioPaqueteEntrada = "com.tmmas.gte.pagoonlinecommon.dto"
* servicioParametroEntrada = "ClientePagoDTO"
* servicioPaqueteSalida = "com.tmmas.gte.pagoonlinecommon.dto"
* servicioParametroSalida = "ClientePagoDTO"
* comentario = "Obtiene Cliente asociado a un Numero de Celular"
* @tmas.legacy.jdbc.storedprocedure.parametro id = "cliente" clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.pagoonlinecommon.dto" mappingParametroEntrada = "ClientePagoDTO" mappingProperty = "numCelular" parentProperty = ""
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "cliente" clase="salida" name="" tipo="NUMERIC" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.pagoonlinecommon.dto" mappingParametroSalida = "ClientePagoDTO" mappingProperty = "codCliente" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "cliente" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.pagoonlinecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "codigoError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "cliente" clase="salida" name="" tipo="VARCHAR" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.pagoonlinecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "mensajeError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "cliente" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.pagoonlinecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "numeroEvento"
* 
* 
* 
* 
* 
* 
* @tmas.legacy.jdbc.storedprocedure id = "nombrecliente" package = "CO_PAGOSONLINE_PG" sp = "CO_NOMBRECLIENTE_PR"
* jndiProperty = "scl.pagos.online"
* servicioMetodo = "obtenerNombreCliente"
* servicioPaqueteEntrada = "com.tmmas.gte.pagoonlinecommon.dto"
* servicioParametroEntrada = "ClientePagoDTO"
* servicioPaqueteSalida = "com.tmmas.gte.pagoonlinecommon.dto"
* servicioParametroSalida = "ClientePagoDTO"
* comentario = "Obtiene Nombre completo de un cliente"
* @tmas.legacy.jdbc.storedprocedure.parametro id = "nombrecliente" clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.pagoonlinecommon.dto" mappingParametroEntrada = "ClientePagoDTO" mappingProperty = "codCliente" parentProperty = ""
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "nombrecliente" clase="salida" name="" tipo="VARCHAR" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.pagoonlinecommon.dto" mappingParametroSalida = "ClientePagoDTO" mappingProperty = "nombre" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "nombrecliente" clase="salida" name="" tipo="VARCHAR" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.pagoonlinecommon.dto" mappingParametroSalida = "ClientePagoDTO" mappingProperty = "apellido" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "nombrecliente" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.pagoonlinecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "codigoError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "nombrecliente" clase="salida" name="" tipo="VARCHAR" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.pagoonlinecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "mensajeError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "nombrecliente" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.pagoonlinecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "numeroEvento"
* 
* 
* 
* 
* 
* 
*
*/

public class ClientePagoDTO implements java.io.Serializable{
	private static final long serialVersionUID = 1L;
	private long codCliente;
	private String nombre;
	private String apellido;
	private double saldoVencido;
	private double saldoPorVencer;
	private double saldoLimiteConsumoPlanTarifario;
	private double saldoLimiteConsumoPlanAdicional;
	private String numCelular;
	private RespuestaDTO respuesta;
	
	public String getApellido() {
		return apellido;
	}
	public void setApellido(String apellido) {
		this.apellido = apellido;
	}
	public long getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(long codCliente) {
		this.codCliente = codCliente;
	}
	public String getNombre() {
		return nombre;
	}
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	public String getNumCelular() {
		return numCelular;
	}
	public void setNumCelular(String numCelular) {
		this.numCelular = numCelular;
	}
	public RespuestaDTO getRespuesta() {
		return respuesta;
	}
	public void setRespuesta(RespuestaDTO respuesta) {
		this.respuesta = respuesta;
	}
	public double getSaldoLimiteConsumoPlanAdicional() {
		return saldoLimiteConsumoPlanAdicional;
	}
	public void setSaldoLimiteConsumoPlanAdicional(
			double saldoLimiteConsumoPlanAdicional) {
		this.saldoLimiteConsumoPlanAdicional = saldoLimiteConsumoPlanAdicional;
	}
	public double getSaldoLimiteConsumoPlanTarifario() {
		return saldoLimiteConsumoPlanTarifario;
	}
	public void setSaldoLimiteConsumoPlanTarifario(
			double saldoLimiteConsumoPlanTarifario) {
		this.saldoLimiteConsumoPlanTarifario = saldoLimiteConsumoPlanTarifario;
	}
	public double getSaldoPorVencer() {
		return saldoPorVencer;
	}
	public void setSaldoPorVencer(double saldoPorVencer) {
		this.saldoPorVencer = saldoPorVencer;
	}
	public double getSaldoVencido() {
		return saldoVencido;
	}
	public void setSaldoVencido(double saldoVencido) {
		this.saldoVencido = saldoVencido;
	}


}