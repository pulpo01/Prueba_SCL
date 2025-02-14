package com.tmmas.cl.scl.portalventas.web.form;

import java.util.ArrayList;

import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.ConceptosRecaudacionComDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.DominioScoringDTO;

public class SolicitudScoringForm extends ScoringForm {

	private static final long serialVersionUID = -2443807852821831183L;

	private ConceptosRecaudacionComDTO[] bancos;

	private ArrayList rangoMeses;

	private ArrayList rangoAnios;
	
	private ConceptosRecaudacionComDTO[] tiposTarjetaSCL; //Aqui van las marcas de las tarjeta (Ej. Master, Visa)

	private DominioScoringDTO[] arrayDominioEstadoCivil;

	private DominioScoringDTO[] arrayDominioNacionalidad;

	private DominioScoringDTO[] arrayDominioNivelAcademico;

	private DominioScoringDTO[] arrayDominioTipoDocumento;

	private DominioScoringDTO[] arrayDominioTipoEmpresa;

	private DominioScoringDTO[] arrayDominioTipoTarjeta;

	private Long numSolScoringEnProceso;

	private String ingresoCedulaMandatorio;

	private String ingresoPasaporteMandatorio;

	protected String mensajeError;

	protected long codClienteSolScoringgEnProceso;

	public long getCodClienteSolScoringgEnProceso() {
		return codClienteSolScoringgEnProceso;
	}

	public void setCodClienteSolScoringEnProceso(long codClienteSolScoringgEnProceso) {
		this.codClienteSolScoringgEnProceso = codClienteSolScoringgEnProceso;
	}

	public ArrayList getRangoAnios() {
		return rangoAnios;
	}

	public final DominioScoringDTO[] getArrayDominioEstadoCivil() {
		return arrayDominioEstadoCivil;
	}

	public final DominioScoringDTO[] getArrayDominioNacionalidad() {
		return arrayDominioNacionalidad;
	}

	public final DominioScoringDTO[] getArrayDominioNivelAcademico() {
		return arrayDominioNivelAcademico;
	}

	public DominioScoringDTO[] getArrayDominioTipoDocumento() {
		return arrayDominioTipoDocumento;
	}

	public final DominioScoringDTO[] getArrayDominioTipoEmpresa() {
		return arrayDominioTipoEmpresa;
	}

	public DominioScoringDTO[] getArrayDominioTipoTarjeta() {
		return arrayDominioTipoTarjeta;
	}

	public ConceptosRecaudacionComDTO[] getBancos() {
		return bancos;
	}

	public ArrayList getRangoMeses() {
		return rangoMeses;
	}

	public String getIngresoCedulaMandatorio() {
		return ingresoCedulaMandatorio;
	}

	public String getIngresoPasaporteMandatorio() {
		return ingresoPasaporteMandatorio;
	}

	public String getMensajeError() {
		return mensajeError;
	}

	public Long getNumSolScoringEnProceso() {
		return numSolScoringEnProceso;
	}

	public void setRangoAnios(ArrayList arrayAnio) {
		this.rangoAnios = arrayAnio;
	}

	public final void setArrayDominioEstadoCivil(DominioScoringDTO[] arrayDominioEstadoCivil) {
		this.arrayDominioEstadoCivil = arrayDominioEstadoCivil;
	}

	public final void setArrayDominioNacionalidad(DominioScoringDTO[] arrayDominioNacionalidad) {
		this.arrayDominioNacionalidad = arrayDominioNacionalidad;
	}

	public final void setArrayDominioNivelAcademico(DominioScoringDTO[] arrayDominioNivelAcademico) {
		this.arrayDominioNivelAcademico = arrayDominioNivelAcademico;
	}

	public void setArrayDominioTipoDocumento(DominioScoringDTO[] arrayDominioTipoDocumento) {
		this.arrayDominioTipoDocumento = arrayDominioTipoDocumento;
	}

	public final void setArrayDominioTipoEmpresa(DominioScoringDTO[] arrayDominioTipoEmpresa) {
		this.arrayDominioTipoEmpresa = arrayDominioTipoEmpresa;
	}

	public void setArrayDominioTipoTarjeta(DominioScoringDTO[] arrayDominioTipoTarjeta) {
		this.arrayDominioTipoTarjeta = arrayDominioTipoTarjeta;
	}

	public void setBancos(ConceptosRecaudacionComDTO[] arrayBancos) {
		this.bancos = arrayBancos;
	}

	public void setRangoMeses(ArrayList arrayMes) {
		this.rangoMeses = arrayMes;
	}

	public void setNumSolScoringEnProceso(Long numSolScoringEnProceso) {
		this.numSolScoringEnProceso = numSolScoringEnProceso;
	}

	public void setIngresoCedulaMandatorio(String ingresoCedulaMandatorio) {
		this.ingresoCedulaMandatorio = ingresoCedulaMandatorio;
	}

	public void setIngresoPasaporteMandatorio(String ingresoPasaporteMandatorio) {
		this.ingresoPasaporteMandatorio = ingresoPasaporteMandatorio;
	}

	public void setMensajeError(String mensajeError) {
		this.mensajeError = mensajeError;
	}

	public ConceptosRecaudacionComDTO[] getTiposTarjetaSCL() {
		return tiposTarjetaSCL;
	}

	public void setTiposTarjetaSCL(ConceptosRecaudacionComDTO[] marcasTarjeta) {
		this.tiposTarjetaSCL = marcasTarjeta;
	}

}
