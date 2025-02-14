/**
 * Generated from schema type t=ConceptoDireccionDTO@java:com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto
 */
package com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto;

public class ConceptoDireccionDTO implements java.io.Serializable {

  private java.lang.String caption;

  public java.lang.String getCaption() {
    return this.caption;
  }

  public void setCaption(java.lang.String caption) {
    this.caption = caption;
  }

  private int codigoConcepto;

  public int getCodigoConcepto() {
    return this.codigoConcepto;
  }

  public void setCodigoConcepto(int codigoConcepto) {
    this.codigoConcepto = codigoConcepto;
  }

  private com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.DatosDireccionDTO[] datosDireccionDTO;

  public com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.DatosDireccionDTO[] getDatosDireccionDTO() {
    return this.datosDireccionDTO;
  }

  public void setDatosDireccionDTO(com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.DatosDireccionDTO[] datosDireccionDTO) {
    this.datosDireccionDTO = datosDireccionDTO;
  }

  private java.lang.Integer identificadorConcepto;

  public java.lang.Integer getIdentificadorConcepto() {
    return this.identificadorConcepto;
  }

  public void setIdentificadorConcepto(java.lang.Integer identificadorConcepto) {
    this.identificadorConcepto = identificadorConcepto;
  }

  private int largoMaximo;

  public int getLargoMaximo() {
    return this.largoMaximo;
  }

  public void setLargoMaximo(int largoMaximo) {
    this.largoMaximo = largoMaximo;
  }

  private java.lang.String nombreColumna;

  public java.lang.String getNombreColumna() {
    return this.nombreColumna;
  }

  public void setNombreColumna(java.lang.String nombreColumna) {
    this.nombreColumna = nombreColumna;
  }

  private int posicion;

  public int getPosicion() {
    return this.posicion;
  }

  public void setPosicion(int posicion) {
    this.posicion = posicion;
  }

  private java.lang.String tipoControl;

  public java.lang.String getTipoControl() {
    return this.tipoControl;
  }

  public void setTipoControl(java.lang.String tipoControl) {
    this.tipoControl = tipoControl;
  }

  private int valorPorDefecto;

  public int getValorPorDefecto() {
    return this.valorPorDefecto;
  }

  public void setValorPorDefecto(int valorPorDefecto) {
    this.valorPorDefecto = valorPorDefecto;
  }

  private boolean obligatoriedad;

  public boolean getObligatoriedad() {
    return this.obligatoriedad;
  }

  public void setObligatoriedad(boolean obligatoriedad) {
    this.obligatoriedad = obligatoriedad;
  }

}
