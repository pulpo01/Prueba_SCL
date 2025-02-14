package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;


public class ParametrosValidacionVentasDTO extends ParametrosValidacionDTO{
	private static final long serialVersionUID = 1L;
	
	private String tipoCliente;
	private String indicadorEventoEvalRiesgo;
	private String tipoSolicitudEvalRiesgo;
	private String estadoEvaluacionRiesgo;
	private String numeroTransaccionVenta;
	private String codigoCelda;
	private String codigoCentral;
	private String codigoSubAlm;
	private int numeroLinea;
	private int numeroOrden;
	private String codigoTipoContrato;
	private String usuarioConectado;
	private String esPlanNoFijoPrimeraLinea;
	
	public String getEsPlanNoFijoPrimeraLinea() {
		return esPlanNoFijoPrimeraLinea;
	}

	public void setEsPlanNoFijoPrimeraLinea(String esPlanNoFijoPrimeraLinea) {
		this.esPlanNoFijoPrimeraLinea = esPlanNoFijoPrimeraLinea;
	}

	public String getUsuarioConectado() {
		return usuarioConectado;
	}

	public void setUsuarioConectado(String usuarioConectado) {
		this.usuarioConectado = usuarioConectado;
	}

	public String getCodigoTipoContrato() {
		return codigoTipoContrato;
	}

	public void setCodigoTipoContrato(String codigoTipoContrato) {
		this.codigoTipoContrato = codigoTipoContrato;
	}

	public int getNumeroLinea() {
		return numeroLinea;
	}

	public void setNumeroLinea(int numeroLinea) {
		this.numeroLinea = numeroLinea;
	}

	public int getNumeroOrden() {
		return numeroOrden;
	}

	public void setNumeroOrden(int numeroOrden) {
		this.numeroOrden = numeroOrden;
	}

	public String getCodigoCelda() {
		return codigoCelda;
	}

	public void setCodigoCelda(String codigoCelda) {
		this.codigoCelda = codigoCelda;
	}

	public String getCodigoCentral() {
		return codigoCentral;
	}

	public void setCodigoCentral(String codigoCentral) {
		this.codigoCentral = codigoCentral;
	}
	public ParametrosValidacionVentasDTO(){
		
	}
	
	public ParametrosValidacionVentasDTO(ParametrosValidacionDTO parametrosValidacion){
		this.setCodigoBodega(parametrosValidacion.getCodigoBodega());
		this.setCodigoCliente(parametrosValidacion.getCodigoCliente());
		this.setCodigoModalidadVenta(parametrosValidacion.getCodigoModalidadVenta());
		this.setCodigoPlanTarifario(parametrosValidacion.getCodigoPlanTarifario());
		this.setCodigoProducto(parametrosValidacion.getCodigoProducto());
		this.setCodigoTecnologia(parametrosValidacion.getCodigoTecnologia());
		this.setCodigoVendedor(parametrosValidacion.getCodigoVendedor());
		this.setNumeroCelular(parametrosValidacion.getNumeroCelular());
		this.setNumeroIdentificador(parametrosValidacion.getNumeroIdentificador());
		this.setNumeroSerie(parametrosValidacion.getNumeroSerie());
		this.setNumeroSerieTerminal(parametrosValidacion.getNumeroSerieTerminal());
		this.setNumeroSerieKit(parametrosValidacion.getNumeroSerieKit());
		this.setTipoIdentificador(parametrosValidacion.getTipoIdentificador());
		this.setTipoCliente(parametrosValidacion.getTipoCliente());
		this.setNombreUsuario(parametrosValidacion.getNombreUsuario());
		this.setApellidoUsuario(parametrosValidacion.getApellidoUsuario());
		this.setTotalRegistros(parametrosValidacion.getTotalRegistros());
		this.setUsuarioConectado(parametrosValidacion.getUsuarioConectado());
		this.setEsPlanNoFijoPrimeraLinea(parametrosValidacion.getEsPlanNoFijoPrimeraLinea());
		
	}
	
	public String getEstadoEvaluacionRiesgo() {
		return estadoEvaluacionRiesgo;
	}
	public void setEstadoEvaluacionRiesgo(String estadoEvaluacionRiesgo) {
		this.estadoEvaluacionRiesgo = estadoEvaluacionRiesgo;
	}
	public String getIndicadorEventoEvalRiesgo() {
		return indicadorEventoEvalRiesgo;
	}
	public void setIndicadorEventoEvalRiesgo(String indicadorEventoEvalRiesgo) {
		this.indicadorEventoEvalRiesgo = indicadorEventoEvalRiesgo;
	}
	public String getTipoCliente() {
		return tipoCliente;
	}
	public void setTipoCliente(String tipoCliente) {
		this.tipoCliente = tipoCliente;
	}
	public String getTipoSolicitudEvalRiesgo() {
		return tipoSolicitudEvalRiesgo;
	}
	public void setTipoSolicitudEvalRiesgo(String tipoSolicitudEvalRiesgo) {
		this.tipoSolicitudEvalRiesgo = tipoSolicitudEvalRiesgo;
	}

	public String getNumeroTransaccionVenta() {
		return numeroTransaccionVenta;
	}

	public void setNumeroTransaccionVenta(String numeroTransaccionVenta) {
		this.numeroTransaccionVenta = numeroTransaccionVenta;
	}

	public String getCodigoSubAlm() {
		return codigoSubAlm;
	}

	public void setCodigoSubAlm(String codigoSubAlm) {
		this.codigoSubAlm = codigoSubAlm;
	}
	
}//fin EntradaValidacionVentasDTO
