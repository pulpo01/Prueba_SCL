package com.tmmas.scl.operations.frmkooss.web.dto;

public class TablaCargosDTO {
	private static final long serialVersionUID = 1L;
	private boolean autMan;
	private String autManDes;
	private String descripcion;
	private String cantidad;
	private String importeTotal;
	private String tipoDescuentoAut;
	private String descuentoUnitarioAut;
	private String descuentoUnitarioMan;
	private String saldo;
	private String moneda;
	private String valorCheck;
	private String tipoDescuentoManual;
	private String codConceptoDescuento;
	private String codConcepto;
	private String importeCargo;
	private String importeTotalOriginal;
	private String tipoDescuentoOriginal;

	
	public String getTipoDescuentoOriginal() {
		return tipoDescuentoOriginal;
	}
	public void setTipoDescuentoOriginal(String tipoDescuentoOriginal) {
		this.tipoDescuentoOriginal = tipoDescuentoOriginal;
	}
	public String getImporteTotalOriginal() {
		return importeTotalOriginal;
	}
	public void setImporteTotalOriginal(String importeTotalOriginal) {
		this.importeTotalOriginal = importeTotalOriginal;
	}
	public String getCodConcepto() {
		return codConcepto;
	}
	public void setCodConcepto(String codConcepto) {
		this.codConcepto = codConcepto;
	}
	public String getCodConceptoDescuento() {
		return codConceptoDescuento;
	}
	public void setCodConceptoDescuento(String codConceptoDescuento) {
		this.codConceptoDescuento = codConceptoDescuento;
	}
	public String getImporteCargo() {
		return importeCargo;
	}
	public void setImporteCargo(String importeCargo) {
		this.importeCargo = importeCargo;
	}
	public String getTipoDescuentoManual() {
		return tipoDescuentoManual;
	}
	public void setTipoDescuentoManual(String tipoDescuentoManual) {
		this.tipoDescuentoManual = tipoDescuentoManual;
	}
	public String getValorCheck() {
		return valorCheck;
	}
	public void setValorCheck(String valorCheck) {
		this.valorCheck = valorCheck;
	}
	public boolean isAutMan() {
		return autMan;
	}
	public void setAutMan(boolean autMan) {
		this.autMan = autMan;
	}
	public String getAutManDes() {
		return autManDes;
	}
	public void setAutManDes(String autManDes) {
		this.autManDes = autManDes;
	}
	public String getCantidad() {
		return cantidad;
	}
	public void setCantidad(String cantidad) {
		this.cantidad = cantidad;
	}
	public String getDescripcion() {
		return descripcion;
	}
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
	public String getDescuentoUnitarioAut() {
		return descuentoUnitarioAut;
	}
	public void setDescuentoUnitarioAut(String descuentoUnitarioAut) {
		this.descuentoUnitarioAut = descuentoUnitarioAut;
	}
	public String getDescuentoUnitarioMan() {
		return descuentoUnitarioMan;
	}
	public void setDescuentoUnitarioMan(String descuentoUnitarioMan) {
		this.descuentoUnitarioMan = descuentoUnitarioMan;
	}
	public String getImporteTotal() {
		return importeTotal;
	}
	public void setImporteTotal(String importeTotal) {
		this.importeTotal = importeTotal;
	}
	public String getMoneda() {
		return moneda;
	}
	public void setMoneda(String moneda) {
		this.moneda = moneda;
	}
	public String getSaldo() {
		return saldo;
	}
	public void setSaldo(String saldo) {
		this.saldo = saldo;
	}
	public String getTipoDescuentoAut() {
		return tipoDescuentoAut;
	}
	public void setTipoDescuentoAut(String tipoDescuentoAut) {
		this.tipoDescuentoAut = tipoDescuentoAut;
	}
}
