/**
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 18/05/2007	     	Elizabeth Vera        				Versión Inicial
 */
package com.tmmas.scl.framework.serviceDomain.dataTransferObject;

import java.io.Serializable;
import java.util.Date;

public class BajaAtlantidaDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	private long idMovimiento;
	private long numAbonado;
	private int codEstado;
	private String codActAbo;
	private String codModulo;
	private int cantidadIntentos;
	private int codCentralDestino;
	private String descripcionRespuesta;
	private String codActuacion;
	private String usuarioOracle;
	private Date fechaIngreso;
	private String codTipoTerminal;
	private int codCentral;
	private Date fechaLectura;
	private long indBloqueo;
	private Date fechaEjecucion;
	private String codTipoTerminalDestino;
	private long idMovimientoAnterior;
	private long numCelular;
	private long idMovimientoPosterior;
	private String numSerie;
	private String numPersonal;
	private long numCelularDestino;
	private String numSerieDestino;
	private String numPersonalDestino;
	private String codMSNB;
	private String codMSNBDestino;
	private String codSupreha;
	private String codServicios;
	private String codMIN;
	private String codMINDestino;
	private String sta;
	private int codMensaje;
	private String mensaje1;
	private String mensaje2;
	private String mensaje3;
	private String codPlanTarifOrigen;
	private float carga;
	private float valorPlan;
	private String pin;
	private Date fechaExpiracion;
	private String descripcionMensaje;
	private String codPIN;
	private String codIdioma;
	private int codEnrutamiento;
	private int codTipoEnrutamiento;
	private String desOrigenPIN;
	private long numLotePIN;
	private String numSeriePIN;
	private String codTipoTecnologia;
	private String imsi;
	private String imsiDestino;
	private String imei;
	private String imeiDestino;
	private String icc;
	private String iccDestino;
	
	public int getCantidadIntentos() {
		return cantidadIntentos;
	}
	public void setCantidadIntentos(int cantidadIntentos) {
		this.cantidadIntentos = cantidadIntentos;
	}

	public String getCodActAbo() {
		return codActAbo;
	}
	public void setCodActAbo(String codActAbo) {
		this.codActAbo = codActAbo;
	}
	public String getCodActuacion() {
		return codActuacion;
	}
	public void setCodActuacion(String codActuacion) {
		this.codActuacion = codActuacion;
	}
	public int getCodCentral() {
		return codCentral;
	}
	public void setCodCentral(int codCentral) {
		this.codCentral = codCentral;
	}
	public int getCodCentralDestino() {
		return codCentralDestino;
	}
	public void setCodCentralDestino(int codCentralDestino) {
		this.codCentralDestino = codCentralDestino;
	}
	public int getCodEnrutamiento() {
		return codEnrutamiento;
	}
	public void setCodEnrutamiento(int codEnrutamiento) {
		this.codEnrutamiento = codEnrutamiento;
	}
	public int getCodEstado() {
		return codEstado;
	}
	public void setCodEstado(int codEstado) {
		this.codEstado = codEstado;
	}
	public String getCodIdioma() {
		return codIdioma;
	}
	public void setCodIdioma(String codIdioma) {
		this.codIdioma = codIdioma;
	}
	public int getCodMensaje() {
		return codMensaje;
	}
	public void setCodMensaje(int codMensaje) {
		this.codMensaje = codMensaje;
	}
	public String getCodMIN() {
		return codMIN;
	}
	public void setCodMIN(String codMIN) {
		this.codMIN = codMIN;
	}
	public String getCodMINDestino() {
		return codMINDestino;
	}
	public void setCodMINDestino(String codMINDestino) {
		this.codMINDestino = codMINDestino;
	}
	public String getCodModulo() {
		return codModulo;
	}
	public void setCodModulo(String codModulo) {
		this.codModulo = codModulo;
	}
	public String getCodMSNB() {
		return codMSNB;
	}
	public void setCodMSNB(String codMSNB) {
		this.codMSNB = codMSNB;
	}
	public String getCodMSNBDestino() {
		return codMSNBDestino;
	}
	public void setCodMSNBDestino(String codMSNBDestino) {
		this.codMSNBDestino = codMSNBDestino;
	}

	public String getNumPersonal() {
		return numPersonal;
	}
	public void setNumPersonal(String numPersonal) {
		this.numPersonal = numPersonal;
	}
	
	public String getNumPersonalDestino() {
		return numPersonalDestino;
	}
	public void setNumPersonalDestino(String numPersonalDestino) {
		this.numPersonalDestino = numPersonalDestino;
	}
	public String getCodPIN() {
		return codPIN;
	}
	public void setCodPIN(String codPIN) {
		this.codPIN = codPIN;
	}
	public String getCodPlanTarifOrigen() {
		return codPlanTarifOrigen;
	}
	public void setCodPlanTarifOrigen(String codPlanTarifOrigen) {
		this.codPlanTarifOrigen = codPlanTarifOrigen;
	}
	public String getCodServicios() {
		return codServicios;
	}
	public void setCodServicios(String codServicios) {
		this.codServicios = codServicios;
	}
	public String getCodSupreha() {
		return codSupreha;
	}
	public void setCodSupreha(String codSupreha) {
		this.codSupreha = codSupreha;
	}
	public int getCodTipoEnrutamiento() {
		return codTipoEnrutamiento;
	}
	public void setCodTipoEnrutamiento(int codTipoEnrutamiento) {
		this.codTipoEnrutamiento = codTipoEnrutamiento;
	}
	public String getCodTipoTecnologia() {
		return codTipoTecnologia;
	}
	public void setCodTipoTecnologia(String codTipoTecnologia) {
		this.codTipoTecnologia = codTipoTecnologia;
	}
	public String getCodTipoTerminal() {
		return codTipoTerminal;
	}
	public void setCodTipoTerminal(String codTipoTerminal) {
		this.codTipoTerminal = codTipoTerminal;
	}
	public String getCodTipoTerminalDestino() {
		return codTipoTerminalDestino;
	}
	public void setCodTipoTerminalDestino(String codTipoTerminalDestino) {
		this.codTipoTerminalDestino = codTipoTerminalDestino;
	}
	public String getDescripcionMensaje() {
		return descripcionMensaje;
	}
	public void setDescripcionMensaje(String descripcionMensaje) {
		this.descripcionMensaje = descripcionMensaje;
	}
	public String getDescripcionRespuesta() {
		return descripcionRespuesta;
	}
	public void setDescripcionRespuesta(String descripcionRespuesta) {
		this.descripcionRespuesta = descripcionRespuesta;
	}
	public String getDesOrigenPIN() {
		return desOrigenPIN;
	}
	public void setDesOrigenPIN(String desOrigenPIN) {
		this.desOrigenPIN = desOrigenPIN;
	}
	public Date getFechaEjecucion() {
		return fechaEjecucion;
	}
	public void setFechaEjecucion(Date fechaEjecucion) {
		this.fechaEjecucion = fechaEjecucion;
	}
	public Date getFechaExpiracion() {
		return fechaExpiracion;
	}
	public void setFechaExpiracion(Date fechaExpiracion) {
		this.fechaExpiracion = fechaExpiracion;
	}
	public Date getFechaIngreso() {
		return fechaIngreso;
	}
	public void setFechaIngreso(Date fechaIngreso) {
		this.fechaIngreso = fechaIngreso;
	}
	public Date getFechaLectura() {
		return fechaLectura;
	}
	public void setFechaLectura(Date fechaLectura) {
		this.fechaLectura = fechaLectura;
	}
	public String getIcc() {
		return icc;
	}
	public void setIcc(String icc) {
		this.icc = icc;
	}
	public String getIccDestino() {
		return iccDestino;
	}
	public void setIccDestino(String iccDestino) {
		this.iccDestino = iccDestino;
	}
	public long getIdMovimiento() {
		return idMovimiento;
	}
	public void setIdMovimiento(long idMovimiento) {
		this.idMovimiento = idMovimiento;
	}
	public long getIdMovimientoAnterior() {
		return idMovimientoAnterior;
	}
	public void setIdMovimientoAnterior(long idMovimientoAnterior) {
		this.idMovimientoAnterior = idMovimientoAnterior;
	}
	public long getIdMovimientoPosterior() {
		return idMovimientoPosterior;
	}
	public void setIdMovimientoPosterior(long idMovimientoPosterior) {
		this.idMovimientoPosterior = idMovimientoPosterior;
	}
	public String getImei() {
		return imei;
	}
	public void setImei(String imei) {
		this.imei = imei;
	}
	public String getImeiDestino() {
		return imeiDestino;
	}
	public void setImeiDestino(String imeiDestino) {
		this.imeiDestino = imeiDestino;
	}
	public String getImsi() {
		return imsi;
	}
	public void setImsi(String imsi) {
		this.imsi = imsi;
	}
	public String getImsiDestino() {
		return imsiDestino;
	}
	public void setImsiDestino(String imsiDestino) {
		this.imsiDestino = imsiDestino;
	}
	public long getIndBloqueo() {
		return indBloqueo;
	}
	public void setIndBloqueo(long indBloqueo) {
		this.indBloqueo = indBloqueo;
	}
	public String getMensaje1() {
		return mensaje1;
	}
	public void setMensaje1(String mensaje1) {
		this.mensaje1 = mensaje1;
	}
	public String getMensaje2() {
		return mensaje2;
	}
	public void setMensaje2(String mensaje2) {
		this.mensaje2 = mensaje2;
	}
	public String getMensaje3() {
		return mensaje3;
	}
	public void setMensaje3(String mensaje3) {
		this.mensaje3 = mensaje3;
	}
	public long getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(long numAbonado) {
		this.numAbonado = numAbonado;
	}
	public long getNumCelular() {
		return numCelular;
	}
	public void setNumCelular(long numCelular) {
		this.numCelular = numCelular;
	}
	public long getNumCelularDestino() {
		return numCelularDestino;
	}
	public void setNumCelularDestino(long numCelularDestino) {
		this.numCelularDestino = numCelularDestino;
	}
	public long getNumLotePIN() {
		return numLotePIN;
	}
	public void setNumLotePIN(long numLotePIN) {
		this.numLotePIN = numLotePIN;
	}
	public String getNumSerie() {
		return numSerie;
	}
	public void setNumSerie(String numSerie) {
		this.numSerie = numSerie;
	}
	public String getNumSerieDestino() {
		return numSerieDestino;
	}
	public void setNumSerieDestino(String numSerieDestino) {
		this.numSerieDestino = numSerieDestino;
	}
	public String getNumSeriePIN() {
		return numSeriePIN;
	}
	public void setNumSeriePIN(String numSeriePIN) {
		this.numSeriePIN = numSeriePIN;
	}
	public String getPin() {
		return pin;
	}
	public void setPin(String pin) {
		this.pin = pin;
	}
	public String getSta() {
		return sta;
	}
	public void setSta(String sta) {
		this.sta = sta;
	}
	public String getUsuarioOracle() {
		return usuarioOracle;
	}
	public void setUsuarioOracle(String usuarioOracle) {
		this.usuarioOracle = usuarioOracle;
	}
	public float getCarga() {
		return carga;
	}
	public void setCarga(float carga) {
		this.carga = carga;
	}
	public float getValorPlan() {
		return valorPlan;
	}
	public void setValorPlan(float valorPlan) {
		this.valorPlan = valorPlan;
	}

	

}
