/**
 * Copyright © 2007 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 04/04/2007     Héctor Hermosilla      					Versión Inicial
 */
package com.tmmas.cl.scl.crmcommon.commonapp.dto;

import java.io.Serializable;

public class CargoSolicitudDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private long numCargo;
	private long codCliente;
	private long codConcepto;
	private String desConcepto;
	private double impCargo;
	private String codMoneda;
	private String desMoneda;
	private long numUnidades;
	private long numVenta;
	private long numTransaccionVenta;
	private int codTipoDocumento;
	private String codOficina;
	private int codModalidadVenta;
	private String codTipoContrato;
	private long codVendedor;
	private String codCuota;
	private String codTipoCliente;
	private String nombreUsuario;	
	private String indOfiter;
	
	//Valores descuento automatico
	private long codConceptoDcto;	
	private double valDcto;
	private double valDctoSinImpuesto;
	private int tipDcto;
	private long cantidad;
	
	//Datos para descuentos manuales
	private long codConceptoDctoManual;	
	private double valDctoManual;
	private int tipDctoManual;
	private long cantidadManual;
	
	private double montoTotalDescuento;
	
	private long numAbonado;
	private long codProductoContratado;
	private long codCargoContratado;
	
	
	public long getCodCargoContratado() {
		return codCargoContratado;
	}
	public void setCodCargoContratado(long codCargoContratado) {
		this.codCargoContratado = codCargoContratado;
	}
	public long getCodProductoContratado() {
		return codProductoContratado;
	}
	public void setCodProductoContratado(long codProductoContratado) {
		this.codProductoContratado = codProductoContratado;
	}
	public long getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(long numAbonado) {
		this.numAbonado = numAbonado;
	}
	public double getMontoTotalDescuento() {
		return montoTotalDescuento;
	}
	public void setMontoTotalDescuento(double montoTotalDescuento) {
		this.montoTotalDescuento = montoTotalDescuento;
	}
	public long getCantidad() {
		return cantidad;
	}
	public void setCantidad(long cantidad) {
		this.cantidad = cantidad;
	}
	public String getCodOficina() {
		return codOficina;
	}
	public void setCodOficina(String codOficina) {
		this.codOficina = codOficina;
	}
	public long getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(long codCliente) {
		this.codCliente = codCliente;
	}
	public long getCodConcepto() {
		return codConcepto;
	}
	public void setCodConcepto(long codConcepto) {
		this.codConcepto = codConcepto;
	}
	public long getCodConceptoDcto() {
		return codConceptoDcto;
	}
	public void setCodConceptoDcto(long codConceptoDcto) {
		this.codConceptoDcto = codConceptoDcto;
	}
	public String getCodMoneda() {
		return codMoneda;
	}
	public void setCodMoneda(String codMoneda) {
		this.codMoneda = codMoneda;
	}
	public String getDesConcepto() {
		return desConcepto;
	}
	public void setDesConcepto(String desConcepto) {
		this.desConcepto = desConcepto;
	}
	public String getDesMoneda() {
		return desMoneda;
	}
	public void setDesMoneda(String desMoneda) {
		this.desMoneda = desMoneda;
	}
	public double getImpCargo() {
		return impCargo;
	}
	public void setImpCargo(double impCargo) {
		this.impCargo = impCargo;
	}
	public long getNumCargo() {
		return numCargo;
	}
	public void setNumCargo(long numCargo) {
		this.numCargo = numCargo;
	}
	public long getNumUnidades() {
		return numUnidades;
	}
	public void setNumUnidades(long numUnidades) {
		this.numUnidades = numUnidades;
	}
	public long getNumVenta() {
		return numVenta;
	}
	public void setNumVenta(long numVenta) {
		this.numVenta = numVenta;
	}
	public int getTipDcto() {
		return tipDcto;
	}
	public void setTipDcto(int tipDcto) {
		this.tipDcto = tipDcto;
	}
	public double getValDcto() {
		return valDcto;
	}
	public void setValDcto(double valDcto) {
		this.valDcto = valDcto;
	}
	public long getCodConceptoDctoManual() {
		return codConceptoDctoManual;
	}
	public void setCodConceptoDctoManual(long codConceptoDctoManual) {
		this.codConceptoDctoManual = codConceptoDctoManual;
	}
	public int getTipDctoManual() {
		return tipDctoManual;
	}
	public void setTipDctoManual(int tipDctoManual) {
		this.tipDctoManual = tipDctoManual;
	}
	public double getValDctoManual() {
		return valDctoManual;
	}
	public void setValDctoManual(double valDctoManual) {
		this.valDctoManual = valDctoManual;
	}
	public long getCantidadManual() {
		return cantidadManual;
	}
	public void setCantidadManual(long cantidadManual) {
		this.cantidadManual = cantidadManual;
	}
	public long getNumTransaccionVenta() {
		return numTransaccionVenta;
	}
	public void setNumTransaccionVenta(long numTransaccionVenta) {
		this.numTransaccionVenta = numTransaccionVenta;
	}
	public int getCodModalidadVenta() {
		return codModalidadVenta;
	}
	public void setCodModalidadVenta(int codModalidadVenta) {
		this.codModalidadVenta = codModalidadVenta;
	}
	public int getCodTipoDocumento() {
		return codTipoDocumento;
	}
	public void setCodTipoDocumento(int codTipoDocumento) {
		this.codTipoDocumento = codTipoDocumento;
	}
	public String getCodCuota() {
		return codCuota;
	}
	public void setCodCuota(String codCuota) {
		this.codCuota = codCuota;
	}
	public String getCodTipoContrato() {
		return codTipoContrato;
	}
	public void setCodTipoContrato(String codTipoContrato) {
		this.codTipoContrato = codTipoContrato;
	}
	public long getCodVendedor() {
		return codVendedor;
	}
	public void setCodVendedor(long codVendedor) {
		this.codVendedor = codVendedor;
	}
	public String getCodTipoCliente() {
		return codTipoCliente;
	}
	public void setCodTipoCliente(String codTipoCliente) {
		this.codTipoCliente = codTipoCliente;
	}
	public String getNombreUsuario() {
		return nombreUsuario;
	}
	public void setNombreUsuario(String nombreUsuario) {
		this.nombreUsuario = nombreUsuario;
	}
	public String getIndOfiter() {
		return indOfiter;
	}
	public void setIndOfiter(String indOfiter) {
		this.indOfiter = indOfiter;
	}
	public double getValDctoSinImpuesto() {
		return valDctoSinImpuesto;
	}
	public void setValDctoSinImpuesto(double valDctoSinImpuesto) {
		this.valDctoSinImpuesto = valDctoSinImpuesto;
	}
	
	
}
