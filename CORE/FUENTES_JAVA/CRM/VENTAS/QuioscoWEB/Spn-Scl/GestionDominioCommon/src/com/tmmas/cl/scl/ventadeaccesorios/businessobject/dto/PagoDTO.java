package com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto;

import java.io.Serializable;

public class PagoDTO implements Serializable{
	
	private static final long serialVersionUID = 1L;
	


	
	private String 	empRecaudadora;
	private String 	codCajaRecauda; 
	private String	servSolicitado;
	private String 	fecEfectividad;
	private String 	numTransaccion;
	private String 	nomUsuarOra;
	private String 	tipTransaccion;
	private String	subTipoTransaccion;
	private String	codServicio;
	private String	numEjercicio; 
	private String	codCliente;
	private String	numCelular;
	private String	importePago;
	private String	numFolioCtc;
	private String	numIdentificacion;
	private String	tipValor;
	private String	numDocumento;
	private String	codBanco;
	private String	ctaCorriente;
	private String	codAutoriza;
	private String	numTarjeta;
	private String	codOperacion;
	private String	numVenta;
	private String	numFolio;
	private String	codPlanSrv;
	
	private String 	resultado;
	private String 	descripcion;
	
	private String numTransaccionEmp;
	private String desAgencia;
	private String codTipTarjeta;
	
	public String getCodAutoriza() {
		return codAutoriza;
	}
	public void setCodAutoriza(String codAutoriza) {
		this.codAutoriza = codAutoriza;
	}
	public String getCodBanco() {
		return codBanco;
	}
	public void setCodBanco(String codBanco) {
		this.codBanco = codBanco;
	}
	public String getCodCajaRecauda() {
		return codCajaRecauda;
	}
	public void setCodCajaRecauda(String codCajaRecauda) {
		this.codCajaRecauda = codCajaRecauda;
	}
	public String getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(String codCliente) {
		this.codCliente = codCliente;
	}
	public String getCodOperacion() {
		return codOperacion;
	}
	public void setCodOperacion(String codOperacion) {
		this.codOperacion = codOperacion;
	}
	public String getCodPlanSrv() {
		return codPlanSrv;
	}
	public void setCodPlanSrv(String codPlanSrv) {
		this.codPlanSrv = codPlanSrv;
	}
	public String getCodServicio() {
		return codServicio;
	}
	public void setCodServicio(String codServicio) {
		this.codServicio = codServicio;
	}
	public String getCtaCorriente() {
		return ctaCorriente;
	}
	public void setCtaCorriente(String ctaCorriente) {
		this.ctaCorriente = ctaCorriente;
	}
	public String getEmpRecaudadora() {
		return empRecaudadora;
	}
	public void setEmpRecaudadora(String empRecaudadora) {
		this.empRecaudadora = empRecaudadora;
	}
	public String getFecEfectividad() {
		return fecEfectividad;
	}
	public void setFecEfectividad(String fecEfectividad) {
		this.fecEfectividad = fecEfectividad;
	}
	public String getImportePago() {
		return importePago;
	}
	public void setImportePago(String importePago) {
		this.importePago = importePago;
	}
	public String getNomUsuarOra() {
		return nomUsuarOra;
	}
	public void setNomUsuarOra(String nomUsuarOra) {
		this.nomUsuarOra = nomUsuarOra;
	}
	public String getNumCelular() {
		return numCelular;
	}
	public void setNumCelular(String numCelular) {
		this.numCelular = numCelular;
	}
	public String getNumDocumento() {
		return numDocumento;
	}
	public void setNumDocumento(String numDocumento) {
		this.numDocumento = numDocumento;
	}
	public String getNumEjercicio() {
		return numEjercicio;
	}
	public void setNumEjercicio(String numEjercicio) {
		this.numEjercicio = numEjercicio;
	}
	public String getNumFolio() {
		return numFolio;
	}
	public void setNumFolio(String numFolio) {
		this.numFolio = numFolio;
	}
	public String getNumFolioCtc() {
		return numFolioCtc;
	}
	public void setNumFolioCtc(String numFolioCtc) {
		this.numFolioCtc = numFolioCtc;
	}
	public String getNumIdentificacion() {
		return numIdentificacion;
	}
	public void setNumIdentificacion(String numIdentificacion) {
		this.numIdentificacion = numIdentificacion;
	}
	public String getNumTarjeta() {
		return numTarjeta;
	}
	public void setNumTarjeta(String numTarjeta) {
		this.numTarjeta = numTarjeta;
	}
	public String getNumTransaccion() {
		return numTransaccion;
	}
	public void setNumTransaccion(String numTransaccion) {
		this.numTransaccion = numTransaccion;
	}
	public String getNumVenta() {
		return numVenta;
	}
	public void setNumVenta(String numVenta) {
		this.numVenta = numVenta;
	}
	public String getServSolicitado() {
		return servSolicitado;
	}
	public void setServSolicitado(String servSolicitado) {
		this.servSolicitado = servSolicitado;
	}
	public String getSubTipoTransaccion() {
		return subTipoTransaccion;
	}
	public void setSubTipoTransaccion(String subTipoTransaccion) {
		this.subTipoTransaccion = subTipoTransaccion;
	}
	public String getTipTransaccion() {
		return tipTransaccion;
	}
	public void setTipTransaccion(String tipTransaccion) {
		this.tipTransaccion = tipTransaccion;
	}
	public String getTipValor() {
		return tipValor;
	}
	public void setTipValor(String tipValor) {
		this.tipValor = tipValor;
	}
	public String getDescripcion() {
		return descripcion;
	}
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
	public String getResultado() {
		return resultado;
	}
	public void setResultado(String resultado) {
		this.resultado = resultado;
	}
	public String getCodTipTarjeta() {
		return codTipTarjeta;
	}
	public void setCodTipTarjeta(String codTipTarjeta) {
		this.codTipTarjeta = codTipTarjeta;
	}
	public String getDesAgencia() {
		return desAgencia;
	}
	public void setDesAgencia(String desAgencia) {
		this.desAgencia = desAgencia;
	}
	public String getNumTransaccionEmp() {
		return numTransaccionEmp;
	}
	public void setNumTransaccionEmp(String numTransaccionEmp) {
		this.numTransaccionEmp = numTransaccionEmp;
	}
	
}
