/**
 * Copyright © 2006 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 11/07/2007     			 Cristian Toledo              		Versión Inicial
 */
package com.tmmas.scl.framework.productDomain.dataTransferObject;

import java.io.Serializable;

public class RegistroServiciosDTO implements Serializable {
	 private static final long serialVersionUID = 1L;
	 private long numMovimiento;
	 private String codActAbo;
	 private String indFactur;
	 private String desServ;
	 private int numUnidades;
	 private int codConcepto;
	 private float impCargo;
	 private int codArticulo;
	 private int codBodega;
	 private String numSerie;
	 private String indEquipo;
	 private long codCliente;
	 private long numAbonado;
	 private String tipDto;
	 private float valDto;
	 private int codConceptoDTO;
	 private long numCelular;
	 private int codPlanCom;
	 private String claseServiciosAct;
	 private String claseServiciosDes;
	 private String param1_mens;
	 private String param2_mens;
	 private String param3_mens;
	 private String claseServicios;
	 private String desMoneda;
	 private String codMoneda;
	 private int codCiclo;
	 private int facCont;
	 private float valMin;
	 private float valMax;
	 private int pDesc;
	 private int codError;
	 private String desError;
	 
	public String getClaseServicios() {
		return claseServicios;
	}
	public void setClaseServicios(String claseServicios) {
		this.claseServicios = claseServicios;
	}
	public String getClaseServiciosAct() {
		return claseServiciosAct;
	}
	public void setClaseServiciosAct(String claseServiciosAct) {
		this.claseServiciosAct = claseServiciosAct;
	}
	public String getClaseServiciosDes() {
		return claseServiciosDes;
	}
	public void setClaseServiciosDes(String claseServiciosDes) {
		this.claseServiciosDes = claseServiciosDes;
	}
	public String getCodActAbo() {
		return codActAbo;
	}
	public void setCodActAbo(String codActAbo) {
		this.codActAbo = codActAbo;
	}
	public int getCodArticulo() {
		return codArticulo;
	}
	public void setCodArticulo(int codArticulo) {
		this.codArticulo = codArticulo;
	}
	public int getCodBodega() {
		return codBodega;
	}
	public void setCodBodega(int codBodega) {
		this.codBodega = codBodega;
	}
	public int getCodCiclo() {
		return codCiclo;
	}
	public void setCodCiclo(int codCiclo) {
		this.codCiclo = codCiclo;
	}
	public long getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(long codCliente) {
		this.codCliente = codCliente;
	}
	public int getCodConcepto() {
		return codConcepto;
	}
	public void setCodConcepto(int codConcepto) {
		this.codConcepto = codConcepto;
	}
	public int getCodConceptoDTO() {
		return codConceptoDTO;
	}
	public void setCodConceptoDTO(int codConceptoDTO) {
		this.codConceptoDTO = codConceptoDTO;
	}
	public int getCodError() {
		return codError;
	}
	public void setCodError(int codError) {
		this.codError = codError;
	}
	public String getCodMoneda() {
		return codMoneda;
	}
	public void setCodMoneda(String codMoneda) {
		this.codMoneda = codMoneda;
	}
	public int getCodPlanCom() {
		return codPlanCom;
	}
	public void setCodPlanCom(int codPlanCom) {
		this.codPlanCom = codPlanCom;
	}
	public String getDesError() {
		return desError;
	}
	public void setDesError(String desError) {
		this.desError = desError;
	}
	public String getDesMoneda() {
		return desMoneda;
	}
	public void setDesMoneda(String desMoneda) {
		this.desMoneda = desMoneda;
	}
	public String getDesServ() {
		return desServ;
	}
	public void setDesServ(String desServ) {
		this.desServ = desServ;
	}
	public int getFacCont() {
		return facCont;
	}
	public void setFacCont(int facCont) {
		this.facCont = facCont;
	}
	public float getImpCargo() {
		return impCargo;
	}
	public void setImpCargo(float impCargo) {
		this.impCargo = impCargo;
	}
	public String getIndEquipo() {
		return indEquipo;
	}
	public void setIndEquipo(String indEquipo) {
		this.indEquipo = indEquipo;
	}
	public String getIndFactur() {
		return indFactur;
	}
	public void setIndFactur(String indFactur) {
		this.indFactur = indFactur;
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
	public long getNumMovimiento() {
		return numMovimiento;
	}
	public void setNumMovimiento(long numMovimiento) {
		this.numMovimiento = numMovimiento;
	}
	public String getNumSerie() {
		return numSerie;
	}
	public void setNumSerie(String numSerie) {
		this.numSerie = numSerie;
	}
	public int getNumUnidades() {
		return numUnidades;
	}
	public void setNumUnidades(int numUnidades) {
		this.numUnidades = numUnidades;
	}
	public String getParam1_mens() {
		return param1_mens;
	}
	public void setParam1_mens(String param1_mens) {
		this.param1_mens = param1_mens;
	}
	public String getParam2_mens() {
		return param2_mens;
	}
	public void setParam2_mens(String param2_mens) {
		this.param2_mens = param2_mens;
	}
	public String getParam3_mens() {
		return param3_mens;
	}
	public void setParam3_mens(String param3_mens) {
		this.param3_mens = param3_mens;
	}
	public int getPDesc() {
		return pDesc;
	}
	public void setPDesc(int desc) {
		pDesc = desc;
	}
	public String getTipDto() {
		return tipDto;
	}
	public void setTipDto(String tipDto) {
		this.tipDto = tipDto;
	}
	public float getValDto() {
		return valDto;
	}
	public void setValDto(float valDto) {
		this.valDto = valDto;
	}
	public float getValMax() {
		return valMax;
	}
	public void setValMax(float valMax) {
		this.valMax = valMax;
	}
	public float getValMin() {
		return valMin;
	}
	public void setValMin(float valMin) {
		this.valMin = valMin;
	}
	 
	 
}
