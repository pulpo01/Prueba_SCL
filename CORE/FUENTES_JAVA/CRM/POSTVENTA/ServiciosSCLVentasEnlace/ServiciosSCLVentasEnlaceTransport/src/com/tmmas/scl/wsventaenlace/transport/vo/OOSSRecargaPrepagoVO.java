/**
 * 
 */
package com.tmmas.scl.wsventaenlace.transport.vo;

import java.io.Serializable;

public class OOSSRecargaPrepagoVO implements Serializable {
	
	private String grupoTecGSM;
	private String grupoTecDMA;
	private Long chkAjusteVisible;
	private String tipoHibrido;
	private String tipoPrepago;
	private Long numAbonado;
	private String nombreTabla;	
	private String nomCliente; 
	private String nomApeClien1;
	private String nomApeClien2;
	private String nombreCompletoCliente;
	private String codTipPlan;
	private TipoRecargaVO []arrayTipoRecargaVO;	
	private OrigenRecargaVO []arrayOrigenRecargaVO;	
	private TipoMonederoVO []arrayTipoMonederoVO;
	private String desTipPlanTarif;
	private String sMaxRecargaPrepago;
	private boolean indConsaldo;
	private String codPlanServ;
	private String codActAbo;
	private Double montoTarifa;
	private String paramTRXPendiente;
	private String codTipModi;
	private String numSerie;
	private String imsi;
	
	private Long secuencia; 
	private String	codRecarga;
	private Long numMovimiento;
	private String	codTipMonedero;
	
	private Long numOS; 
	private String comentario;
	private String nomUsuarioSCL;
	private String codOOSS;
	private Integer codEstado;
	
	private Long codCliente;
	private Integer codCicloFact;
	private int codRetorno;
	
	/**
	 * 
	 */
	public OOSSRecargaPrepagoVO() {

	}

	/**
	 * @return the grupoTecGSM
	 */
	public String getGrupoTecGSM() {
		return grupoTecGSM;
	}

	/**
	 * @param grupoTecGSM the grupoTecGSM to set
	 */
	public void setGrupoTecGSM(String grupoTecGSM) {
		this.grupoTecGSM = grupoTecGSM;
	}

	/**
	 * @return the grupoTecDMA
	 */
	public String getGrupoTecDMA() {
		return grupoTecDMA;
	}

	/**
	 * @param grupoTecDMA the grupoTecDMA to set
	 */
	public void setGrupoTecDMA(String grupoTecDMA) {
		this.grupoTecDMA = grupoTecDMA;
	}

	/**
	 * @return the chkAjusteVisible
	 */
	public Long getChkAjusteVisible() {
		return chkAjusteVisible;
	}

	/**
	 * @param chkAjusteVisible the chkAjusteVisible to set
	 */
	public void setChkAjusteVisible(Long chkAjusteVisible) {
		this.chkAjusteVisible = chkAjusteVisible;
	}

	/**
	 * @return the tipoHibrido
	 */
	public String getTipoHibrido() {
		return tipoHibrido;
	}

	/**
	 * @param tipoHibrido the tipoHibrido to set
	 */
	public void setTipoHibrido(String tipoHibrido) {
		this.tipoHibrido = tipoHibrido;
	}

	/**
	 * @return the tipoPrepago
	 */
	public String getTipoPrepago() {
		return tipoPrepago;
	}

	/**
	 * @param tipoPrepago the tipoPrepago to set
	 */
	public void setTipoPrepago(String tipoPrepago) {
		this.tipoPrepago = tipoPrepago;
	}

	/**
	 * @return the numAbonado
	 */
	public Long getNumAbonado() {
		return numAbonado;
	}

	/**
	 * @param numAbonado the numAbonado to set
	 */
	public void setNumAbonado(Long numAbonado) {
		this.numAbonado = numAbonado;
	}

	/**
	 * @return the nombreTabla
	 */
	public String getNombreTabla() {
		return nombreTabla;
	}

	/**
	 * @param nombreTabla the nombreTabla to set
	 */
	public void setNombreTabla(String nombreTabla) {
		this.nombreTabla = nombreTabla;
	}

	/**
	 * @return the nomCliente
	 */
	public String getNomCliente() {
		return nomCliente;
	}

	/**
	 * @param nomCliente the nomCliente to set
	 */
	public void setNomCliente(String nomCliente) {
		this.nomCliente = nomCliente;
	}

	/**
	 * @return the nomApeClien1
	 */
	public String getNomApeClien1() {
		return nomApeClien1;
	}

	/**
	 * @param nomApeClien1 the nomApeClien1 to set
	 */
	public void setNomApeClien1(String nomApeClien1) {
		this.nomApeClien1 = nomApeClien1;
	}

	/**
	 * @return the nomApeClien2
	 */
	public String getNomApeClien2() {
		return nomApeClien2;
	}

	/**
	 * @param nomApeClien2 the nomApeClien2 to set
	 */
	public void setNomApeClien2(String nomApeClien2) {
		this.nomApeClien2 = nomApeClien2;
	}

	/**
	 * @return the nombreCompletoCliente
	 */
	public String getNombreCompletoCliente() {
		return nombreCompletoCliente;
	}

	/**
	 * @param nombreCompletoCliente the nombreCompletoCliente to set
	 */
	public void setNombreCompletoCliente(String nombreCompletoCliente) {
		this.nombreCompletoCliente = nombreCompletoCliente;
	}

	/**
	 * @return the codTipPlan
	 */
	public String getCodTipPlan() {
		return codTipPlan;
	}

	/**
	 * @param codTipPlan the codTipPlan to set
	 */
	public void setCodTipPlan(String codTipPlan) {
		this.codTipPlan = codTipPlan;
	}

	/**
	 * @return the arrayTipoRecargaVO
	 */
	public TipoRecargaVO[] getArrayTipoRecargaVO() {
		return arrayTipoRecargaVO;
	}

	/**
	 * @param arrayTipoRecargaVO the arrayTipoRecargaVO to set
	 */
	public void setArrayTipoRecargaVO(TipoRecargaVO[] arrayTipoRecargaVO) {
		this.arrayTipoRecargaVO = arrayTipoRecargaVO;
	}

	/**
	 * @return the arrayOrigenRecargaVO
	 */
	public OrigenRecargaVO[] getArrayOrigenRecargaVO() {
		return arrayOrigenRecargaVO;
	}

	/**
	 * @param arrayOrigenRecargaVO the arrayOrigenRecargaVO to set
	 */
	public void setArrayOrigenRecargaVO(OrigenRecargaVO[] arrayOrigenRecargaVO) {
		this.arrayOrigenRecargaVO = arrayOrigenRecargaVO;
	}

	/**
	 * @return the arrayTipoMonederoVO
	 */
	public TipoMonederoVO[] getArrayTipoMonederoVO() {
		return arrayTipoMonederoVO;
	}

	/**
	 * @param arrayTipoMonederoVO the arrayTipoMonederoVO to set
	 */
	public void setArrayTipoMonederoVO(TipoMonederoVO[] arrayTipoMonederoVO) {
		this.arrayTipoMonederoVO = arrayTipoMonederoVO;
	}

	/**
	 * @return the desTipPlanTarif
	 */
	public String getDesTipPlanTarif() {
		return desTipPlanTarif;
	}

	/**
	 * @param desTipPlanTarif the desTipPlanTarif to set
	 */
	public void setDesTipPlanTarif(String desTipPlanTarif) {
		this.desTipPlanTarif = desTipPlanTarif;
	}

	/**
	 * @return the sMaxRecargaPrepago
	 */
	public String getSMaxRecargaPrepago() {
		return sMaxRecargaPrepago;
	}

	/**
	 * @param maxRecargaPrepago the sMaxRecargaPrepago to set
	 */
	public void setSMaxRecargaPrepago(String maxRecargaPrepago) {
		sMaxRecargaPrepago = maxRecargaPrepago;
	}

	/**
	 * @return the indConsaldo
	 */
	public boolean isIndConsaldo() {
		return indConsaldo;
	}

	/**
	 * @param indConsaldo the indConsaldo to set
	 */
	public void setIndConsaldo(boolean indConsaldo) {
		this.indConsaldo = indConsaldo;
	}

	/**
	 * @return the codPlanServ
	 */
	public String getCodPlanServ() {
		return codPlanServ;
	}

	/**
	 * @param codPlanServ the codPlanServ to set
	 */
	public void setCodPlanServ(String codPlanServ) {
		this.codPlanServ = codPlanServ;
	}

	/**
	 * @return the codActAbo
	 */
	public String getCodActAbo() {
		return codActAbo;
	}

	/**
	 * @param codActAbo the codActAbo to set
	 */
	public void setCodActAbo(String codActAbo) {
		this.codActAbo = codActAbo;
	}

	/**
	 * @return the montoTarifa
	 */
	public Double getMontoTarifa() {
		return montoTarifa;
	}

	/**
	 * @param montoTarifa the montoTarifa to set
	 */
	public void setMontoTarifa(Double montoTarifa) {
		this.montoTarifa = montoTarifa;
	}

	/**
	 * @return the paramTRXPendiente
	 */
	public String getParamTRXPendiente() {
		return paramTRXPendiente;
	}

	/**
	 * @param paramTRXPendiente the paramTRXPendiente to set
	 */
	public void setParamTRXPendiente(String paramTRXPendiente) {
		this.paramTRXPendiente = paramTRXPendiente;
	}

	/**
	 * @return the codTipModi
	 */
	public String getCodTipModi() {
		return codTipModi;
	}

	/**
	 * @param codTipModi the codTipModi to set
	 */
	public void setCodTipModi(String codTipModi) {
		this.codTipModi = codTipModi;
	}

	/**
	 * @return the numSerie
	 */
	public String getNumSerie() {
		return numSerie;
	}

	/**
	 * @param numSerie the numSerie to set
	 */
	public void setNumSerie(String numSerie) {
		this.numSerie = numSerie;
	}

	/**
	 * @return the imsi
	 */
	public String getImsi() {
		return imsi;
	}

	/**
	 * @param imsi the imsi to set
	 */
	public void setImsi(String imsi) {
		this.imsi = imsi;
	}

	/**
	 * @return the secuencia
	 */
	public Long getSecuencia() {
		return secuencia;
	}

	/**
	 * @param secuencia the secuencia to set
	 */
	public void setSecuencia(Long secuencia) {
		this.secuencia = secuencia;
	}

	/**
	 * @return the codRecarga
	 */
	public String getCodRecarga() {
		return codRecarga;
	}

	/**
	 * @param codRecarga the codRecarga to set
	 */
	public void setCodRecarga(String codRecarga) {
		this.codRecarga = codRecarga;
	}

	/**
	 * @return the numMovimiento
	 */
	public Long getNumMovimiento() {
		return numMovimiento;
	}

	/**
	 * @param numMovimiento the numMovimiento to set
	 */
	public void setNumMovimiento(Long numMovimiento) {
		this.numMovimiento = numMovimiento;
	}

	/**
	 * @return the codTipMonedero
	 */
	public String getCodTipMonedero() {
		return codTipMonedero;
	}

	/**
	 * @param codTipMonedero the codTipMonedero to set
	 */
	public void setCodTipMonedero(String codTipMonedero) {
		this.codTipMonedero = codTipMonedero;
	}

	/**
	 * @return the numOS
	 */
	public Long getNumOS() {
		return numOS;
	}

	/**
	 * @param numOS the numOS to set
	 */
	public void setNumOS(Long numOS) {
		this.numOS = numOS;
	}

	/**
	 * @return the comentario
	 */
	public String getComentario() {
		return comentario;
	}

	/**
	 * @param comentario the comentario to set
	 */
	public void setComentario(String comentario) {
		this.comentario = comentario;
	}

	/**
	 * @return the nomUsuarioSCL
	 */
	public String getNomUsuarioSCL() {
		return nomUsuarioSCL;
	}

	/**
	 * @param nomUsuarioSCL the nomUsuarioSCL to set
	 */
	public void setNomUsuarioSCL(String nomUsuarioSCL) {
		this.nomUsuarioSCL = nomUsuarioSCL;
	}

	/**
	 * @return the codOOSS
	 */
	public String getCodOOSS() {
		return codOOSS;
	}

	/**
	 * @param codOOSS the codOOSS to set
	 */
	public void setCodOOSS(String codOOSS) {
		this.codOOSS = codOOSS;
	}

	/**
	 * @return the codEstado
	 */
	public Integer getCodEstado() {
		return codEstado;
	}

	/**
	 * @param codEstado the codEstado to set
	 */
	public void setCodEstado(Integer codEstado) {
		this.codEstado = codEstado;
	}

	/**
	 * @return the codCliente
	 */
	public Long getCodCliente() {
		return codCliente;
	}

	/**
	 * @param codCliente the codCliente to set
	 */
	public void setCodCliente(Long codCliente) {
		this.codCliente = codCliente;
	}

	/**
	 * @return the codRetorno
	 */
	public int getCodRetorno() {
		return codRetorno;
	}

	/**
	 * @param codRetorno the codRetorno to set
	 */
	public void setCodRetorno(int codRetorno) {
		this.codRetorno = codRetorno;
	}

	/**
	 * @return the codCicloFact
	 */
	public Integer getCodCicloFact() {
		return codCicloFact;
	}

	/**
	 * @param codCicloFact the codCicloFact to set
	 */
	public void setCodCicloFact(Integer codCicloFact) {
		this.codCicloFact = codCicloFact;
	}
}
