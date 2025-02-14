/**
 * Generated from schema type t=ObtencionCargosDTO@java:com.tmmas.scl.framework.customerDomain.dataTransferObject
 */
package com.tmmas.scl.framework.customerdomain.datatransferobject;

public class ObtencionCargosDTO implements java.io.Serializable {

  private com.tmmas.scl.framework.customerdomain.datatransferobject.CargosDTO[] cargos;

  public com.tmmas.scl.framework.customerdomain.datatransferobject.CargosDTO[] getCargos() {
    return this.cargos;
  }

  public void setCargos(com.tmmas.scl.framework.customerdomain.datatransferobject.CargosDTO[] cargos) {
    this.cargos = cargos;
  }

  private java.lang.String codigoConcepto;

  public java.lang.String getCodigoConcepto() {
    return this.codigoConcepto;
  }

  public void setCodigoConcepto(java.lang.String codigoConcepto) {
    this.codigoConcepto = codigoConcepto;
  }

  private java.lang.String descripcionConcepto;

  public java.lang.String getDescripcionConcepto() {
    return this.descripcionConcepto;
  }

  public void setDescripcionConcepto(java.lang.String descripcionConcepto) {
    this.descripcionConcepto = descripcionConcepto;
  }

  private float maxDescuento;

  public float getMaxDescuento() {
    return this.maxDescuento;
  }

  public void setMaxDescuento(float maxDescuento) {
    this.maxDescuento = maxDescuento;
  }

  private float minDescuento;

  public float getMinDescuento() {
    return this.minDescuento;
  }

  public void setMinDescuento(float minDescuento) {
    this.minDescuento = minDescuento;
  }

  private float monto;

  public float getMonto() {
    return this.monto;
  }

  public void setMonto(float monto) {
    this.monto = monto;
  }

  private java.lang.String numAbonado;

  public java.lang.String getNumAbonado() {
    return this.numAbonado;
  }

  public void setNumAbonado(java.lang.String numAbonado) {
    this.numAbonado = numAbonado;
  }

  private float porcentajeDesctoInferior;

  public float getPorcentajeDesctoInferior() {
    return this.porcentajeDesctoInferior;
  }

  public void setPorcentajeDesctoInferior(float porcentajeDesctoInferior) {
    this.porcentajeDesctoInferior = porcentajeDesctoInferior;
  }

  private float porcentajeDesctoSuperior;

  public float getPorcentajeDesctoSuperior() {
    return this.porcentajeDesctoSuperior;
  }

  public void setPorcentajeDesctoSuperior(float porcentajeDesctoSuperior) {
    this.porcentajeDesctoSuperior = porcentajeDesctoSuperior;
  }

  private float puntoDesctoInferior;

  public float getPuntoDesctoInferior() {
    return this.puntoDesctoInferior;
  }

  public void setPuntoDesctoInferior(float puntoDesctoInferior) {
    this.puntoDesctoInferior = puntoDesctoInferior;
  }

  private float puntoDesctoSuperior;

  public float getPuntoDesctoSuperior() {
    return this.puntoDesctoSuperior;
  }

  public void setPuntoDesctoSuperior(float puntoDesctoSuperior) {
    this.puntoDesctoSuperior = puntoDesctoSuperior;
  }

  private java.lang.String tipo;

  public java.lang.String getTipo() {
    return this.tipo;
  }

  public void setTipo(java.lang.String tipo) {
    this.tipo = tipo;
  }

  private java.lang.String tipoAplicacion;

  public java.lang.String getTipoAplicacion() {
    return this.tipoAplicacion;
  }

  public void setTipoAplicacion(java.lang.String tipoAplicacion) {
    this.tipoAplicacion = tipoAplicacion;
  }

  private boolean aplicaDescuentoVendedor;

  public boolean getAplicaDescuentoVendedor() {
    return this.aplicaDescuentoVendedor;
  }

  public void setAplicaDescuentoVendedor(boolean aplicaDescuentoVendedor) {
    this.aplicaDescuentoVendedor = aplicaDescuentoVendedor;
  }

  private boolean aprobacion;

  public boolean getAprobacion() {
    return this.aprobacion;
  }

  public void setAprobacion(boolean aprobacion) {
    this.aprobacion = aprobacion;
  }

}
