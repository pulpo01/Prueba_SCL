package com.tmmas.scl.wsventaenlace.transport.vo;

import java.io.Serializable;
import java.sql.Timestamp;

public class CentralesVO implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private Long numMovimiento;
	private long numAbonado;
	private long codEstado;
	private String codActabo;
	private String codModulo;
	private long numIntentos;
	private Long codCentralNue;
	private String desRespuesta;
	private long codActuacion;
	private String nomUsuarOra;
	private Timestamp fecIngreso;
	private String tipTerminal;
	private Long codCentral;
	private Timestamp fecLectura;
	private int indBloqueo;
	private Timestamp fecEjecucion;
	private String tipTerminalNue;
	private Long numMovant;
	private Long numCelular;
	private Long numMovPos;
	private String numSerie;
	private String numPersonal;
	private Long numCelularNue;
	private String numSerieNue;
	private String numPersonalNue;
	private String numMsnb;
	private String numMsnbNue;
	private String codSusPreha;
	private String codServicios;
	private String numMin;
	private String numMinNue;
	private char Sta;
	private Long codMensaje;
	private String Param1Mens;
	private String Param2Mens;
	private String Param3Mens;
	private String plan;
	private Double carga;
	private Double valorPlan;
	private String pin;
	private Timestamp fecExpira;
	private String desMensaje;
	private String codPin;
	private String codIdioma;
	private Long CodEnrutamiento;
	private long tipEnrutamiento;
	private String desOrigenPin;
	private long numLotePin;
	private String tipTecnologia;
	private String Imsi;
	private String ImsiNue;
	private String Imei;
	private String ImeiNue;
	private String Icc;
	private String IccNue;
	private String numSeriePin;
	//Inicio Utilizados en enviaMovimientoCentrales
	private Long numError;
	private Long numOS;
	private String codOS;
	//Fin Utilizados en enviaMovimientoCentrales
	
	public CentralesVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @param carga Double the carga to set
	 */
	public void setCarga(Double carga) {
		this.carga = carga;
	}

	/**
	 * @param codActabo String the codActabo to set
	 */
	public void setCodActabo(String codActabo) {
		this.codActabo = codActabo;
	}

	/**
	 * @param codActuacion long the codActuacion to set
	 */
	public void setCodActuacion(long codActuacion) {
		this.codActuacion = codActuacion;
	}

	/**
	 * @param codCentral Long the codCentral to set
	 */
	public void setCodCentral(Long codCentral) {
		this.codCentral = codCentral;
	}

	/**
	 * @param codCentralNue long the codCentralNue to set
	 */
	public void setCodCentralNue(Long codCentralNue) {
		this.codCentralNue = codCentralNue;
	}

	/**
	 * @param codEnrutamiento long the codEnrutamiento to set
	 */
	public void setCodEnrutamiento(Long codEnrutamiento) {
		CodEnrutamiento = codEnrutamiento;
	}

	/**
	 * @param codEstado long the codEstado to set
	 */
	public void setCodEstado(long codEstado) {
		this.codEstado = codEstado;
	}

	/**
	 * @param codIdioma String the codIdioma to set
	 */
	public void setCodIdioma(String codIdioma) {
		this.codIdioma = codIdioma;
	}

	/**
	 * @param codMensaje long the codMensaje to set
	 */
	public void setCodMensaje(Long codMensaje) {
		this.codMensaje = codMensaje;
	}

	/**
	 * @param codModulo String the codModulo to set
	 */
	public void setCodModulo(String codModulo) {
		this.codModulo = codModulo;
	}

	/**
	 * @param codPin String the codPin to set
	 */
	public void setCodPin(String codPin) {
		this.codPin = codPin;
	}

	/**
	 * @param codServicios String the codServicios to set
	 */
	public void setCodServicios(String codServicios) {
		this.codServicios = codServicios;
	}

	/**
	 * @param codSusPreha String the codSusPreha to set
	 */
	public void setCodSusPreha(String codSusPreha) {
		this.codSusPreha = codSusPreha;
	}

	/**
	 * @param desMensaje String the desMensaje to set
	 */
	public void setDesMensaje(String desMensaje) {
		this.desMensaje = desMensaje;
	}

	/**
	 * @param desOrigenPin String the desOrigenPin to set
	 */
	public void setDesOrigenPin(String desOrigenPin) {
		this.desOrigenPin = desOrigenPin;
	}

	/**
	 * @param desRespuesta String the desRespuesta to set
	 */
	public void setDesRespuesta(String desRespuesta) {
		this.desRespuesta = desRespuesta;
	}

	/**
	 * @param fecEjecucion Timestamp the fecEjecucion to set
	 */
	public void setFecEjecucion(Timestamp fecEjecucion) {
		this.fecEjecucion = fecEjecucion;
	}

	/**
	 * @param fecExpira Timestamp the fecExpira to set
	 */
	public void setFecExpira(Timestamp fecExpira) {
		this.fecExpira = fecExpira;
	}

	/**
	 * @param fecIngreso Timestamp the fecIngreso to set
	 */
	public void setFecIngreso(Timestamp fecIngreso) {
		this.fecIngreso = fecIngreso;
	}

	/**
	 * @param fecLectura Timestamp the fecLectura to set
	 */
	public void setFecLectura(Timestamp fecLectura) {
		this.fecLectura = fecLectura;
	}

	/**
	 * @param icc String the icc to set
	 */
	public void setIcc(String icc) {
		Icc = icc;
	}

	/**
	 * @param iccNue String the iccNue to set
	 */
	public void setIccNue(String iccNue) {
		IccNue = iccNue;
	}

	/**
	 * @param imei String the imei to set
	 */
	public void setImei(String imei) {
		Imei = imei;
	}

	/**
	 * @param imeiNue String the imeiNue to set
	 */
	public void setImeiNue(String imeiNue) {
		ImeiNue = imeiNue;
	}

	/**
	 * @param imsi String the imsi to set
	 */
	public void setImsi(String imsi) {
		Imsi = imsi;
	}

	/**
	 * @param imsiNue String the imsiNue to set
	 */
	public void setImsiNue(String imsiNue) {
		ImsiNue = imsiNue;
	}

	/**
	 * @param indBloqueo int the indBloqueo to set
	 */
	public void setIndBloqueo(int indBloqueo) {
		this.indBloqueo = indBloqueo;
	}

	/**
	 * @param nomUsuarOra String the nomUsuarOra to set
	 */
	public void setNomUsuarOra(String nomUsuarOra) {
		this.nomUsuarOra = nomUsuarOra;
	}

	/**
	 * @param numAbonado long the numAbonado to set
	 */
	public void setNumAbonado(long numAbonado) {
		this.numAbonado = numAbonado;
	}

	/**
	 * @param numCelular Long the numCelular to set
	 */
	public void setNumCelular(Long numCelular) {
		this.numCelular = numCelular;
	}

	/**
	 * @param numCelularNue Long the numCelularNue to set
	 */
	public void setNumCelularNue(Long numCelularNue) {
		this.numCelularNue = numCelularNue;
	}

	/**
	 * @param numIntentos long the numIntentos to set
	 */
	public void setNumIntentos(long numIntentos) {
		this.numIntentos = numIntentos;
	}

	/**
	 * @param numLotePin long the numLotePin to set
	 */
	public void setNumLotePin(long numLotePin) {
		this.numLotePin = numLotePin;
	}

	/**
	 * @param numMin String the numMin to set
	 */
	public void setNumMin(String numMin) {
		this.numMin = numMin;
	}

	/**
	 * @param numMinNue String the numMinNue to set
	 */
	public void setNumMinNue(String numMinNue) {
		this.numMinNue = numMinNue;
	}

	/**
	 * @param numMovant Long the numMovant to set
	 */
	public void setNumMovant(Long numMovant) {
		this.numMovant = numMovant;
	}

	/**
	 * @param numMovimiento Long the numMovimiento to set
	 */
	public void setNumMovimiento(Long numMovimiento) {
		this.numMovimiento = numMovimiento;
	}

	/**
	 * @param numMovPos Long the numMovPos to set
	 */
	public void setNumMovPos(Long numMovPos) {
		this.numMovPos = numMovPos;
	}

	/**
	 * @param numMsnb String the numMsnb to set
	 */
	public void setNumMsnb(String numMsnb) {
		this.numMsnb = numMsnb;
	}

	/**
	 * @param numMsnbNue String the numMsnbNue to set
	 */
	public void setNumMsnbNue(String numMsnbNue) {
		this.numMsnbNue = numMsnbNue;
	}

	/**
	 * @param numPersonal String the numPersonal to set
	 */
	public void setNumPersonal(String numPersonal) {
		this.numPersonal = numPersonal;
	}

	/**
	 * @param numPersonalNue String the numPersonalNue to set
	 */
	public void setNumPersonalNue(String numPersonalNue) {
		this.numPersonalNue = numPersonalNue;
	}

	/**
	 * @param numSerie String the numSerie to set
	 */
	public void setNumSerie(String numSerie) {
		this.numSerie = numSerie;
	}

	/**
	 * @param numSerieNue String the numSerieNue to set
	 */
	public void setNumSerieNue(String numSerieNue) {
		this.numSerieNue = numSerieNue;
	}

	/**
	 * @param numSeriePin String the numSeriePin to set
	 */
	public void setNumSeriePin(String numSeriePin) {
		this.numSeriePin = numSeriePin;
	}

	/**
	 * @param param1Mens String the param1Mens to set
	 */
	public void setParam1Mens(String param1Mens) {
		Param1Mens = param1Mens;
	}

	/**
	 * @param param2Mens String the param2Mens to set
	 */
	public void setParam2Mens(String param2Mens) {
		Param2Mens = param2Mens;
	}

	/**
	 * @param param3Mens String the param3Mens to set
	 */
	public void setParam3Mens(String param3Mens) {
		Param3Mens = param3Mens;
	}

	/**
	 * @param pin String the pin to set
	 */
	public void setPin(String pin) {
		this.pin = pin;
	}

	/**
	 * @param plan String the plan to set
	 */
	public void setPlan(String plan) {
		this.plan = plan;
	}

	/**
	 * @param sta char the sta to set
	 */
	public void setSta(char sta) {
		Sta = sta;
	}

	/**
	 * @param tipEnrutamiento long the tipEnrutamiento to set
	 */
	public void setTipEnrutamiento(long tipEnrutamiento) {
		this.tipEnrutamiento = tipEnrutamiento;
	}

	/**
	 * @param tipTecnologia String the tipTecnologia to set
	 */
	public void setTipTecnologia(String tipTecnologia) {
		this.tipTecnologia = tipTecnologia;
	}

	/**
	 * @param tipTerminal String the tipTerminal to set
	 */
	public void setTipTerminal(String tipTerminal) {
		this.tipTerminal = tipTerminal;
	}

	/**
	 * @param tipTerminalNue String the tipTerminalNue to set
	 */
	public void setTipTerminalNue(String tipTerminalNue) {
		this.tipTerminalNue = tipTerminalNue;
	}

	/**
	 * @param valorPlan Double the valorPlan to set
	 */
	public void setValorPlan(Double valorPlan) {
		this.valorPlan = valorPlan;
	}

	/**
	 * @return Double the carga 
	 */
	public Double getCarga() {
		return carga;
	}

	/**
	 * @return String the codActabo 
	 */
	public String getCodActabo() {
		return codActabo;
	}

	/**
	 * @return long the codActuacion 
	 */
	public long getCodActuacion() {
		return codActuacion;
	}

	/**
	 * @return Long the codCentral 
	 */
	public Long getCodCentral() {
		return codCentral;
	}

	/**
	 * @return long the codCentralNue 
	 */
	public Long getCodCentralNue() {
		return codCentralNue;
	}

	/**
	 * @return long the codEnrutamiento 
	 */
	public Long getCodEnrutamiento() {
		return CodEnrutamiento;
	}

	/**
	 * @return long the codEstado 
	 */
	public long getCodEstado() {
		return codEstado;
	}

	/**
	 * @return String the codIdioma 
	 */
	public String getCodIdioma() {
		return codIdioma;
	}

	/**
	 * @return long the codMensaje 
	 */
	public Long getCodMensaje() {
		return codMensaje;
	}

	/**
	 * @return String the codModulo 
	 */
	public String getCodModulo() {
		return codModulo;
	}

	/**
	 * @return String the codPin 
	 */
	public String getCodPin() {
		return codPin;
	}

	/**
	 * @return String the codServicios 
	 */
	public String getCodServicios() {
		return codServicios;
	}

	/**
	 * @return String the codSusPreha 
	 */
	public String getCodSusPreha() {
		return codSusPreha;
	}

	/**
	 * @return String the desMensaje 
	 */
	public String getDesMensaje() {
		return desMensaje;
	}

	/**
	 * @return String the desOrigenPin 
	 */
	public String getDesOrigenPin() {
		return desOrigenPin;
	}

	/**
	 * @return String the desRespuesta 
	 */
	public String getDesRespuesta() {
		return desRespuesta;
	}

	/**
	 * @return Timestamp the fecEjecucion 
	 */
	public Timestamp getFecEjecucion() {
		return fecEjecucion;
	}

	/**
	 * @return Timestamp the fecExpira 
	 */
	public Timestamp getFecExpira() {
		return fecExpira;
	}

	/**
	 * @return Timestamp the fecIngreso 
	 */
	public Timestamp getFecIngreso() {
		return fecIngreso;
	}

	/**
	 * @return Timestamp the fecLectura 
	 */
	public Timestamp getFecLectura() {
		return fecLectura;
	}

	/**
	 * @return String the icc 
	 */
	public String getIcc() {
		return Icc;
	}

	/**
	 * @return String the iccNue 
	 */
	public String getIccNue() {
		return IccNue;
	}

	/**
	 * @return String the imei 
	 */
	public String getImei() {
		return Imei;
	}

	/**
	 * @return String the imeiNue 
	 */
	public String getImeiNue() {
		return ImeiNue;
	}

	/**
	 * @return String the imsi 
	 */
	public String getImsi() {
		return Imsi;
	}

	/**
	 * @return String the imsiNue 
	 */
	public String getImsiNue() {
		return ImsiNue;
	}

	/**
	 * @return int the indBloqueo 
	 */
	public int getIndBloqueo() {
		return indBloqueo;
	}

	/**
	 * @return String the nomUsuarOra 
	 */
	public String getNomUsuarOra() {
		return nomUsuarOra;
	}

	/**
	 * @return long the numAbonado 
	 */
	public long getNumAbonado() {
		return numAbonado;
	}

	/**
	 * @return Long the numCelular 
	 */
	public Long getNumCelular() {
		return numCelular;
	}

	/**
	 * @return Long the numCelularNue 
	 */
	public Long getNumCelularNue() {
		return numCelularNue;
	}

	/**
	 * @return long the numIntentos 
	 */
	public long getNumIntentos() {
		return numIntentos;
	}

	/**
	 * @return long the numLotePin 
	 */
	public long getNumLotePin() {
		return numLotePin;
	}

	/**
	 * @return String the numMin 
	 */
	public String getNumMin() {
		return numMin;
	}

	/**
	 * @return String the numMinNue 
	 */
	public String getNumMinNue() {
		return numMinNue;
	}

	/**
	 * @return Long the numMovant 
	 */
	public Long getNumMovant() {
		return numMovant;
	}

	/**
	 * @return Long the numMovimiento 
	 */
	public Long getNumMovimiento() {
		return numMovimiento;
	}

	/**
	 * @return Long the numMovPos 
	 */
	public Long getNumMovPos() {
		return numMovPos;
	}

	/**
	 * @return String the numMsnb 
	 */
	public String getNumMsnb() {
		return numMsnb;
	}

	/**
	 * @return String the numMsnbNue 
	 */
	public String getNumMsnbNue() {
		return numMsnbNue;
	}

	/**
	 * @return String the numPersonal 
	 */
	public String getNumPersonal() {
		return numPersonal;
	}

	/**
	 * @return String the numPersonalNue 
	 */
	public String getNumPersonalNue() {
		return numPersonalNue;
	}

	/**
	 * @return String the numSerie 
	 */
	public String getNumSerie() {
		return numSerie;
	}

	/**
	 * @return String the numSerieNue 
	 */
	public String getNumSerieNue() {
		return numSerieNue;
	}

	/**
	 * @return String the numSeriePin 
	 */
	public String getNumSeriePin() {
		return numSeriePin;
	}

	/**
	 * @return String the param1Mens 
	 */
	public String getParam1Mens() {
		return Param1Mens;
	}

	/**
	 * @return String the param2Mens 
	 */
	public String getParam2Mens() {
		return Param2Mens;
	}

	/**
	 * @return String the param3Mens 
	 */
	public String getParam3Mens() {
		return Param3Mens;
	}

	/**
	 * @return String the pin 
	 */
	public String getPin() {
		return pin;
	}

	/**
	 * @return String the plan 
	 */
	public String getPlan() {
		return plan;
	}

	/**
	 * @return char the sta 
	 */
	public char getSta() {
		return Sta;
	}

	/**
	 * @return long the tipEnrutamiento 
	 */
	public long getTipEnrutamiento() {
		return tipEnrutamiento;
	}

	/**
	 * @return String the tipTecnologia 
	 */
	public String getTipTecnologia() {
		return tipTecnologia;
	}

	/**
	 * @return String the tipTerminal 
	 */
	public String getTipTerminal() {
		return tipTerminal;
	}

	/**
	 * @return String the tipTerminalNue 
	 */
	public String getTipTerminalNue() {
		return tipTerminalNue;
	}

	/**
	 * @return Double the valorPlan 
	 */
	public Double getValorPlan() {
		return valorPlan;
	}

	public String getCodOS() {
		return codOS;
	}

	public void setCodOS(String codOS) {
		this.codOS = codOS;
	}

	public Long getNumError() {
		return numError;
	}

	public void setNumError(Long numError) {
		this.numError = numError;
	}

	public Long getNumOS() {
		return numOS;
	}

	public void setNumOS(Long numOS) {
		this.numOS = numOS;
	}
	
	
}
