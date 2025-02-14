package com.tmmas.cl.scl.portalventas.web.form;

import org.apache.struts.action.ActionForm;

public class ReporteScoringForm extends ActionForm {

	private static final long serialVersionUID = 1L;

	private int cantidadLineas;

	private int cantidadPlanes;
	
	private String desPlanes;

	private int cantidadServSup;

	private String clasificacionCliente;

	private String codEstado;

	private String codModuloOrigen;

	private String codModuloOrigenScoring;

	private long codVendedor;

	private String desEstado;

	private String desEstado2;

	private String desTipoDocumento;

	private String documento;

	private String fechaEvaluacion;

	private String mensajeError;

	private String nit;

	private String nombreVendedor;

	private long numSolScoring;

	private String primerApellido;

	private String primerNombre;

	//private ResultadoScoreClienteDTO resultadoScoreClienteDTO;

	private String resultadoScoring;

	private String segundoApellido;

	private String segundoNombre;
	
	private String clasificacion;
	
	private String mensaje;
	
	private String punteo;
	
	private String referencia;
	
	

	public int getCantidadLineas() {
		return cantidadLineas;
	}

	public int getCantidadPlanes() {
		return cantidadPlanes;
	}

	public int getCantidadServSup() {
		return cantidadServSup;
	}


	public String getClasificacionCliente() {
		return clasificacionCliente;
	}

	public String getCodEstado() {
		return codEstado;
	}

	public String getCodModuloOrigen() {
		return codModuloOrigen;
	}

	public String getCodModuloOrigenScoring() {
		return codModuloOrigenScoring;
	}

	public long getCodVendedor() {
		return codVendedor;
	}

	public String getDesEstado() {
		return desEstado;
	}

	public String getDesEstado2() {
		return desEstado2;
	}

	public String getDesTipoDocumento() {
		return desTipoDocumento;
	}

	public String getDocumento() {
		return documento;
	}

	public String getFechaEvaluacion() {
		return fechaEvaluacion;
	}


	public String getMensajeError() {
		return mensajeError;
	}

	public String getNit() {
		return nit;
	}

	public String getNombreVendedor() {
		return nombreVendedor;
	}

	public long getNumSolScoring() {
		return numSolScoring;
	}

	public String getPrimerApellido() {
		return primerApellido;
	}

	public String getPrimerNombre() {
		return primerNombre;
	}



	public String getResultadoScoring() {
		return resultadoScoring;
	}

	public String getSegundoApellido() {
		return segundoApellido;
	}

	public String getSegundoNombre() {
		return segundoNombre;
	}

	public void setCantidadLineas(int cantidadLineas) {
		this.cantidadLineas = cantidadLineas;
	}

	public void setCantidadPlanes(int cantidadPlanes) {
		this.cantidadPlanes = cantidadPlanes;
	}

	public void setCantidadServSup(int cantidadServSup) {
		this.cantidadServSup = cantidadServSup;
	}

	public void setClasificacionCliente(String clasificacionCliente) {
		this.clasificacionCliente = clasificacionCliente;
	}

	public void setCodEstado(String codEstado) {
		this.codEstado = codEstado;
	}

	public void setCodModuloOrigen(String codModuloOrigen) {
		this.codModuloOrigen = codModuloOrigen;
	}

	public void setCodModuloOrigenScoring(String codModuloOrigenScoring) {
		this.codModuloOrigenScoring = codModuloOrigenScoring;
	}

	public void setCodVendedor(long codVendedor) {
		this.codVendedor = codVendedor;
	}

	public void setDesEstado(String desEstado) {
		this.desEstado = desEstado;
	}

	public void setDesEstado2(String desEstado2) {
		this.desEstado2 = desEstado2;
	}

	public void setDesTipoDocumento(String desTipoDocumento) {
		this.desTipoDocumento = desTipoDocumento;
	}

	public void setDocumento(String documento) {
		this.documento = documento;
	}

	public void setFechaEvaluacion(String fechaEvaluacion) {
		this.fechaEvaluacion = fechaEvaluacion;
	}

	public void setMensajeError(String mensajeError) {
		this.mensajeError = mensajeError;
	}

	public void setNit(String nit) {
		this.nit = nit;
	}

	public void setNombreVendedor(String nombreVendedor) {
		this.nombreVendedor = nombreVendedor;
	}

	public void setNumSolScoring(long numSolScoring) {
		this.numSolScoring = numSolScoring;
	}

	public void setPrimerApellido(String primerApellido) {
		this.primerApellido = primerApellido;
	}

	public void setPrimerNombre(String primerNombre) {
		this.primerNombre = primerNombre;
	}

	public void setResultadoScoring(String resultadoScoring) {
		this.resultadoScoring = resultadoScoring;
	}

	public void setSegundoApellido(String segundoApellido) {
		this.segundoApellido = segundoApellido;
	}

	public void setSegundoNombre(String segundoNombre) {
		this.segundoNombre = segundoNombre;
	}

	public String getClasificacion() {
		return clasificacion;
	}

	public void setClasificacion(String clasificacion) {
		this.clasificacion = clasificacion;
	}

	public String getMensaje() {
		return mensaje;
	}

	public void setMensaje(String mensaje) {
		this.mensaje = mensaje;
	}

	public String getPunteo() {
		return punteo;
	}

	public void setPunteo(String punteo) {
		this.punteo = punteo;
	}

	public String getReferencia() {
		return referencia;
	}

	public void setReferencia(String referencia) {
		this.referencia = referencia;
	}

	public String getDesPlanes() {
		return desPlanes;
	}

	public void setDesPlanes(String desPlanes) {
		this.desPlanes = desPlanes;
	}

}
