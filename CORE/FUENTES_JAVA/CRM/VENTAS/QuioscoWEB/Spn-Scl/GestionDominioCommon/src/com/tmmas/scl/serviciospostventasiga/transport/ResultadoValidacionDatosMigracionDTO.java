package com.tmmas.scl.serviciospostventasiga.transport;

import java.io.Serializable;

public class ResultadoValidacionDatosMigracionDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;;
	private String mensajeValidacion;
	private  String codigoError;
	private  int numeroEvento;
	
	private  long estadoPlanVigente;
	private  boolean resultadoNumeroCelular;
	private  boolean resultadoPlanTarifario;
	private  boolean resultadoCodCliente;
	private  boolean resultadoIMEI = true;
	private  boolean resultadoVendedor;
	private  boolean resultadoCodLimConsumo;
	private  boolean resultadoCodCentral;
	private  boolean resultadoVariablesExistentes;
	private String codPlanComverse;
	
	private int resultadoBase;
	
	public String getMensajeError() {
		return mensajeValidacion;
	}
	public void setMensajeError(String mensajeValidacion) {
		this.mensajeValidacion = mensajeValidacion;
	}
	public String getCodigoError() {
		return codigoError;
	}
	public void setCodigoError(String codigoError) {
		this.codigoError = codigoError;
	}
	
	public int getNumeroEvento(){
		return numeroEvento;
	}
	public void setNumeroEvento(int numeroEvento){
		this.numeroEvento = numeroEvento;
	}

	public void setResultadoBase(int resultadoBase) {
		this.resultadoBase = resultadoBase;
	}
	
	public int getResultadoBase() {
		return resultadoBase;
	}
	
	public boolean isResultadoPlanTarifario() {
		return resultadoPlanTarifario;
	}
	public void setResultadoPlanTarifario(boolean resultado) {
		this.resultadoPlanTarifario = resultado;
	}
	
	
	public boolean isResultadoCodCliente() {
		return resultadoCodCliente;
	}
	public void setResultadoCodCliente(boolean resultado) {
		this.resultadoCodCliente = resultado;
	}
	
	public boolean isResultadoNumeroCelular() {
		return resultadoNumeroCelular;
	}
	public void setResultadoNumeroCelular(boolean resultado) {
		this.resultadoNumeroCelular = resultado;
	}
	
	public boolean isResultadoIMEI() {
		return resultadoIMEI;
	}
	public void setResultadoIMEI(boolean resultado) {
		this.resultadoIMEI = resultado;
	}
	
	public boolean isResultadoVendedor() {
		return resultadoVendedor;
	}
	public void setResultadoVendedor(boolean resultado) {
		this.resultadoVendedor = resultado;
	}
	
	public void setEstadoPlanVigente(long sv_estadoPlanVigente){
		this.estadoPlanVigente = sv_estadoPlanVigente;
	}
	
	public long getEstadoPlanVigente(){
		return estadoPlanVigente;
	}
	
	public boolean isResultadoCodLimConsumo(){
		return resultadoCodLimConsumo;
	}
	
	public void setResultadoCodLimConsumo(boolean resultado){
		this.resultadoCodLimConsumo = resultado;
	}
	
	public boolean isResultadoCodCentral(){
		return resultadoCodCentral; 
	}
	
	public void setResultadoCodCentral(boolean resultado){
		this.resultadoCodCentral = resultado;
	}
	
	public boolean isResultadoVariablesExistentes(){
		return resultadoVariablesExistentes;
	}
	
	public void setResultadoVariablesExistentes(boolean resultado){
		this.resultadoVariablesExistentes = resultado;		
	}
	public String getCodPlanComverse() {
		return this.codPlanComverse;
	}
	public void setCodPlanComverse(String codPlanComverse) {
		this.codPlanComverse = codPlanComverse;
	}
}
