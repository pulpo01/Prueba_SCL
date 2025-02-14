/**
 * Generated from schema type t=PrecioDTO@java:com.tmmas.scl.framework.customerDomain.dataTransferObject
 */
package com.tmmas.scl.framework.customerdomain.datatransferobject;

public class PrecioDTO implements java.io.Serializable {

  private java.lang.String codigoConcepto;

  public java.lang.String getCodigoConcepto() {
    return this.codigoConcepto;
  }

  public void setCodigoConcepto(java.lang.String codigoConcepto) {
    this.codigoConcepto = codigoConcepto;
  }

  private com.tmmas.scl.framework.customerdomain.datatransferobject.AtributosMigracionDTO datosAnexos;

  public com.tmmas.scl.framework.customerdomain.datatransferobject.AtributosMigracionDTO getDatosAnexos() {
    return this.datosAnexos;
  }

  public void setDatosAnexos(com.tmmas.scl.framework.customerdomain.datatransferobject.AtributosMigracionDTO datosAnexos) {
    this.datosAnexos = datosAnexos;
  }

  private java.lang.String descripcionConcepto;

  public java.lang.String getDescripcionConcepto() {
    return this.descripcionConcepto;
  }

  public void setDescripcionConcepto(java.lang.String descripcionConcepto) {
    this.descripcionConcepto = descripcionConcepto;
  }

  private java.lang.String fechaAplicacion;

  public java.lang.String getFechaAplicacion() {
    return this.fechaAplicacion;
  }

  public void setFechaAplicacion(java.lang.String fechaAplicacion) {
    this.fechaAplicacion = fechaAplicacion;
  }

  private java.lang.String indicadorAutMan;

  public java.lang.String getIndicadorAutMan() {
    return this.indicadorAutMan;
  }

  public void setIndicadorAutMan(java.lang.String indicadorAutMan) {
    this.indicadorAutMan = indicadorAutMan;
  }

  private float monto;

  public float getMonto() {
    return this.monto;
  }

  public void setMonto(float monto) {
    this.monto = monto;
  }

  private com.tmmas.scl.framework.customerdomain.datatransferobject.MonedaDTO unidad;

  public com.tmmas.scl.framework.customerdomain.datatransferobject.MonedaDTO getUnidad() {
    return this.unidad;
  }

  public void setUnidad(com.tmmas.scl.framework.customerdomain.datatransferobject.MonedaDTO unidad) {
    this.unidad = unidad;
  }

  private java.lang.String valorMaximo;

  public java.lang.String getValorMaximo() {
    return this.valorMaximo;
  }

  public void setValorMaximo(java.lang.String valorMaximo) {
    this.valorMaximo = valorMaximo;
  }

  private java.lang.String valorMinimo;

  public java.lang.String getValorMinimo() {
    return this.valorMinimo;
  }

  public void setValorMinimo(java.lang.String valorMinimo) {
    this.valorMinimo = valorMinimo;
  }

}
