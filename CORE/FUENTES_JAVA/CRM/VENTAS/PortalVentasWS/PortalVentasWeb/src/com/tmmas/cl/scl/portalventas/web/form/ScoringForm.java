package com.tmmas.cl.scl.portalventas.web.form;

import java.util.Date;

import org.apache.struts.action.ActionForm;

import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.DatosGeneralesScoringDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.ScoreClienteDTO;

public abstract class ScoringForm extends ActionForm {

	private ScoreClienteDTO scoreClienteDTO = new ScoreClienteDTO();

	private DatosGeneralesScoringDTO datosGeneralesScoringDTO = scoreClienteDTO.getDatosGeneralesScoringDTO();

	public String getAnioVencimientoTarjeta() {
		return scoreClienteDTO.getAnioVencimientoTarjeta();
	}

	public String getAntiguedad_laboral() {
		return scoreClienteDTO.getAntiguedad_laboral();
	}

	public String getAplicaTarjeta() {
		return scoreClienteDTO.getAplicaTarjeta();
	}

	public String getCapacidad_pago() {
		return scoreClienteDTO.getCapacidad_pago();
	}

	public Long getCodAgente() {
		return datosGeneralesScoringDTO.getCodAgente();
	}

	public long getCodCliente() {
		return scoreClienteDTO.getCodCliente();
	}

	public String getCodCuota() {
		return datosGeneralesScoringDTO.getCodCuota();
	}

	public String getCodEstadoCivil() {
		return scoreClienteDTO.getCodEstadoCivil();
	}

	public String getCodBancoTarjeta() {
		return scoreClienteDTO.getCodBancoTarjeta();
	}

	public Integer getCodModVenta() {
		return datosGeneralesScoringDTO.getCodModVenta();
	}

	public String getCodNacionalidad() {
		return scoreClienteDTO.getCodNacionalidad();
	}

	public String getCodNivelAcademico() {
		return scoreClienteDTO.getCodNivelAcademico();
	}

	public String getCodOficina() {
		return datosGeneralesScoringDTO.getCodOficina();
	}

	public String getCodPeriodo() {
		return datosGeneralesScoringDTO.getCodPeriodo().toString();
	}

	public String getCodTipComis() {
		return datosGeneralesScoringDTO.getCodTipComis();
	}

	public String getCodTipContrato() {
		return datosGeneralesScoringDTO.getCodTipContrato();
	}

	public int getCodTipoCliente() {
		return scoreClienteDTO.getCodTipoCliente();
	}

	public String getCodTipoDocumento() {
		return scoreClienteDTO.getCodTipoDocumento();
	}

	public String getCodTipoEmpresa() {
		return scoreClienteDTO.getCodTipoEmpresa();
	}

	public String getCodTipoTarjeta() {
		return scoreClienteDTO.getCodTipoTarjeta();
	}

	public long getCodVendedor() {
		return datosGeneralesScoringDTO.getCodVendedor();
	}

	public Long getCodVendedorDealer() {
		return datosGeneralesScoringDTO.getCodVendedorDealer();
	}

	public String getDesEstadoCivil() {
		return scoreClienteDTO.getDesEstadoCivil();
	}

	public String getDesNacionalidad() {
		return scoreClienteDTO.getDesNacionalidad();
	}

	public String getDesNivelAcademico() {
		return scoreClienteDTO.getDesNivelAcademico();
	}

	public String getDesTipoDocumento() {
		return scoreClienteDTO.getDesTipoDocumento();
	}

	public String getDesTipoEmpresa() {
		return scoreClienteDTO.getDesTipoEmpresa();
	}

	public String getDesTipoTarjeta() {
		return scoreClienteDTO.getDesTipoTarjeta();
	}

	public String getDocumento() {
		return scoreClienteDTO.getDocumento();
	}

	public String getFacturaTercero() {
		return datosGeneralesScoringDTO.getFacturaTercero();
	}

	public Date getFecha_creacion() {
		return scoreClienteDTO.getFecha_creacion();
	}

	public Date getFecha_nacimiento() {
		return scoreClienteDTO.getFecha_nacimiento();
	}

	public String getIndVtaExterna() {
		return datosGeneralesScoringDTO.getIndVtaExterna();
	}

	public double getIngresosMensuales() {
		return scoreClienteDTO.getIngresosMensuales();
	}

	public String getMesVencimientoTarjeta() {
		return scoreClienteDTO.getMesVencimientoTarjeta();
	}

	public Double getMontoPreautorizado() {
		return datosGeneralesScoringDTO.getMontoPreautorizado();
	}

	public String getNit() {
		return scoreClienteDTO.getNit();
	}

	public String getNombreCompleto() {
		return scoreClienteDTO.getNombreCompleto();
	}

	public String getNomUsuarioOra() {
		return scoreClienteDTO.getNomUsuarioOra();
	}

	public long getNumSolScoring() {
		return scoreClienteDTO.getNumSolScoring();
	}

	public String getNumTarjeta() {
		return scoreClienteDTO.getNumTarjeta();
	}

	public String getPrimer_apellido() {
		return scoreClienteDTO.getPrimer_apellido();
	}

	public String getPrimer_nombre() {
		return scoreClienteDTO.getPrimer_nombre();
	}

	public final ScoreClienteDTO getScoreClienteDTO() {
		return scoreClienteDTO;
	}

	public String getSegundo_apellido() {
		return scoreClienteDTO.getSegundo_apellido();
	}

	public String getSegundo_nombre() {
		return scoreClienteDTO.getSegundo_nombre();
	}

	public String getTip_producto() {
		return scoreClienteDTO.getTip_producto();
	}

	public void setAnioVencimientoTarjeta(String anioVencimientoTarjeta) {
		scoreClienteDTO.setAnioVencimientoTarjeta(anioVencimientoTarjeta);
	}

	public void setAntiguedad_laboral(String antiguedad_laboral) {
		scoreClienteDTO.setAntiguedad_laboral(antiguedad_laboral);
	}

	public void setAplicaTarjeta(String aplicaTarjeta) {
		scoreClienteDTO.setAplicaTarjeta(aplicaTarjeta);
	}

	public void setCapacidad_pago(String capacidad_pago) {
		scoreClienteDTO.setCapacidad_pago(capacidad_pago);
	}

	public void setCodAgente(Long codAgente) {
		datosGeneralesScoringDTO.setCodAgente(codAgente);
	}

	public void setCodCliente(long codCliente) {
		scoreClienteDTO.setCodCliente(codCliente);
	}

	public void setCodCuota(String codCuota) {
		datosGeneralesScoringDTO.setCodCuota(codCuota);
	}

	public void setCodEstadoCivil(String codEstadoCivil) {
		scoreClienteDTO.setCodEstadoCivil(codEstadoCivil);
	}

	public void setCodBancoTarjeta(String emisorTarjeta) {
		scoreClienteDTO.setCodBancoTarjeta(emisorTarjeta);
	}

	public void setCodModVenta(Integer codModVenta) {
		datosGeneralesScoringDTO.setCodModVenta(codModVenta);
	}

	public void setCodNacionalidad(String codNacionalidad) {
		scoreClienteDTO.setCodNacionalidad(codNacionalidad);
	}

	public void setCodNivelAcademico(String codNivelAcademico) {
		scoreClienteDTO.setCodNivelAcademico(codNivelAcademico);
	}

	public void setCodOficina(String codOficina) {
		datosGeneralesScoringDTO.setCodOficina(codOficina);
	}

	public void setCodPeriodo(String codPeriodo) {
		datosGeneralesScoringDTO.setCodPeriodo(new Long(codPeriodo));
	}

	public void setCodTipComis(String codTipComis) {
		datosGeneralesScoringDTO.setCodTipComis(codTipComis);
	}

	public void setCodTipContrato(String codTipContrato) {
		datosGeneralesScoringDTO.setCodTipContrato(codTipContrato);
	}

	public void setCodTipoCliente(int codTipoCliente) {
		scoreClienteDTO.setCodTipoCliente(codTipoCliente);
	}

	public void setCodTipoDocumento(String codTipoDocumento) {
		scoreClienteDTO.setCodTipoDocumento(codTipoDocumento);
	}

	public void setCodTipoEmpresa(String codTipoEmpresa) {
		scoreClienteDTO.setCodTipoEmpresa(codTipoEmpresa);
	}

	public void setCodTipoTarjeta(String codTipoTarjeta) {
		scoreClienteDTO.setCodTipoTarjeta(codTipoTarjeta);
	}

	public void setCodVendedor(long codVendedor) {
		datosGeneralesScoringDTO.setCodVendedor(codVendedor);
	}

	public void setCodVendedorDealer(Long codVendedorDealer) {
		datosGeneralesScoringDTO.setCodVendedorDealer(codVendedorDealer);
	}

	public void setDesEstadoCivil(String desEstadoCivil) {
		scoreClienteDTO.setDesEstadoCivil(desEstadoCivil);
	}

	public void setDesNacionalidad(String desNacionalidad) {
		scoreClienteDTO.setDesNacionalidad(desNacionalidad);
	}

	public void setDesNivelAcademico(String desNivelAcademico) {
		scoreClienteDTO.setDesNivelAcademico(desNivelAcademico);
	}

	public void setDesTipoDocumento(String desTipoDocumento) {
		scoreClienteDTO.setDesTipoDocumento(desTipoDocumento);
	}

	public void setDesTipoEmpresa(String desTipoEmpresa) {
		scoreClienteDTO.setDesTipoEmpresa(desTipoEmpresa);
	}

	public void setDesTipoTarjeta(String desTipoTarjeta) {
		scoreClienteDTO.setDesTipoTarjeta(desTipoTarjeta);
	}

	public void setDocumento(String documento) {
		scoreClienteDTO.setDocumento(documento);
	}

	public void setFacturaTercero(String facturaTercero) {
		datosGeneralesScoringDTO.setFacturaTercero(facturaTercero);
	}

	public void setFecha_creacion(Date fecha_creacion) {
		scoreClienteDTO.setFecha_creacion(fecha_creacion);
	}

	public void setFecha_nacimiento(Date fechaNacimiento) {
		scoreClienteDTO.setFecha_nacimiento(fechaNacimiento);
	}

	public void setIndVtaExterna(String indVtaExterna) {
		datosGeneralesScoringDTO.setIndVtaExterna(indVtaExterna);
	}

	public void setIngresosMensuales(double ingresosMensuales) {
		scoreClienteDTO.setIngresosMensuales(ingresosMensuales);
	}

	public void setMesVencimientoTarjeta(String mesVencimientoTarjeta) {
		scoreClienteDTO.setMesVencimientoTarjeta(mesVencimientoTarjeta);
	}

	public void setMontoPreautorizado(Double facturaTercero) {
		datosGeneralesScoringDTO.setMontoPreautorizado(facturaTercero);
	}

	public void setNit(String nit) {
		scoreClienteDTO.setNit(nit);
	}

	public void setNomUsuarioOra(String nomUsuarioOra) {
		scoreClienteDTO.setNomUsuarioOra(nomUsuarioOra);
	}

	public void setNumSolScoring(long numSolScoring) {
		scoreClienteDTO.setNumSolScoring(numSolScoring);
	}

	public void setNumTarjeta(String numTarjeta) {
		scoreClienteDTO.setNumTarjeta(numTarjeta);
	}

	public void setPrimer_apellido(String primer_apellido) {
		scoreClienteDTO.setPrimer_apellido(primer_apellido);
	}

	public void setPrimer_nombre(String primer_nombre) {
		scoreClienteDTO.setPrimer_nombre(primer_nombre);
	}

	public final void setScoreClienteDTO(ScoreClienteDTO scoreClienteDTO) {
		this.scoreClienteDTO = scoreClienteDTO;
		this.datosGeneralesScoringDTO = scoreClienteDTO.getDatosGeneralesScoringDTO();
	}

	public void setSegundo_apellido(String segundo_apellido) {
		scoreClienteDTO.setSegundo_apellido(segundo_apellido);
	}

	public void setSegundo_nombre(String segundo_nombre) {
		scoreClienteDTO.setSegundo_nombre(segundo_nombre);
	}

	public void setTip_producto(String tip_producto) {
		scoreClienteDTO.setTip_producto(tip_producto);
	}

	public String getCodTipoTarjetaSCL() {
		return scoreClienteDTO.getCodTipoTarjetaSCL();
	}

	public void setCodTipoTarjetaSCL(String codTipoTarjetaSCL) {
		scoreClienteDTO.setCodTipoTarjetaSCL(codTipoTarjetaSCL);
	}

}
