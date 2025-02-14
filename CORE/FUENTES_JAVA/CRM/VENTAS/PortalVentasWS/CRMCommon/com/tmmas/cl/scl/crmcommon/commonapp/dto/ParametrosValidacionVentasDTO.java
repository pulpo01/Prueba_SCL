package com.tmmas.cl.scl.crmcommon.commonapp.dto;

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
	private String codigoCalificacion;
	private String codigoActuacion;
	
	//-- MAYORISTAS
	private String canalVendedor;
	private String numeroSerie;
	private int modalidadVenta;
	
	private int codigoUsoLinea;
	private boolean esMayoristaSimcard;
	private boolean esMayoristaTerminal;
	
	private int indRenovacion;
	
	public int getIndRenovacion() {
		return indRenovacion;
	}

	public void setIndRenovacion(int indRenovacion) {
		this.indRenovacion = indRenovacion;
	}

	public int getModalidadVenta() {
		return modalidadVenta;
	}

	public void setModalidadVenta(int modalidadVenta) {
		this.modalidadVenta = modalidadVenta;
	}

	public String getCanalVendedor() {
		return canalVendedor;
	}

	public void setCanalVendedor(String canalVendedor) {
		this.canalVendedor = canalVendedor;
	}

	public String getNumeroSerie() {
		return numeroSerie;
	}

	public void setNumeroSerie(String numeroSerie) {
		this.numeroSerie = numeroSerie;
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
	
	public ParametrosValidacionVentasDTO(ParametrosValidacionDTO inicia){
		this.setCodigoBodega(inicia.getCodigoBodega());
		this.setCodigoCliente(inicia.getCodigoCliente());
		this.setCodigoModalidadVenta(inicia.getCodigoModalidadVenta());
		this.setCodigoPlanTarifario(inicia.getCodigoPlanTarifario());
		this.setCodigoProducto(inicia.getCodigoProducto());
		this.setCodigoTecnologia(inicia.getCodigoTecnologia());
		this.setCodigoVendedor(inicia.getCodigoVendedor());
		this.setNumeroCelular(inicia.getNumeroCelular());
		this.setNumeroIdentificador(inicia.getNumeroIdentificador());
		this.setNumeroSerie(inicia.getNumeroSerie());
		this.setNumeroSerieTerminal(inicia.getNumeroSerieTerminal());
		this.setTipoIdentificador(inicia.getTipoIdentificador());
		this.setTipoCliente(inicia.getTipoCliente());
		this.setNumeroSerieSimcard(inicia.getNumeroSerieSimcard());
		this.setNumeroSerieTerminal(inicia.getNumeroSerieTerminal());
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

	
	public boolean isEsMayoristaSimcard() {
		return esMayoristaSimcard;
	}

	public void setEsMayoristaSimcard(boolean esMayoristaSimcard) {
		this.esMayoristaSimcard = esMayoristaSimcard;
	}

	public boolean isEsMayoristaTerminal() {
		return esMayoristaTerminal;
	}

	public void setEsMayoristaTerminal(boolean esMayoristaTerminal) {
		this.esMayoristaTerminal = esMayoristaTerminal;
	}

	public int getCodigoUsoLinea() {
		return codigoUsoLinea;
	}

	public void setCodigoUsoLinea(int codigoUsoLinea) {
		this.codigoUsoLinea = codigoUsoLinea;
	}

	public String getCodigoCalificacion() {
		return codigoCalificacion;
	}

	public void setCodigoCalificacion(String codigoCalificacion) {
		this.codigoCalificacion = codigoCalificacion;
	}

	public String getCodigoActuacion() {
		return codigoActuacion;
	}

	public void setCodigoActuacion(String codigoActuacion) {
		this.codigoActuacion = codigoActuacion;
	}
	
}//fin EntradaValidacionVentasDTO
