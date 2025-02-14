/**
 * Generated from schema type t=DireccionDTO@java:com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto
 */
package com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto;

public class DireccionDTO implements java.io.Serializable {

  private long codigoDirecion;

  public long getCodigoDirecion() {
    return this.codigoDirecion;
  }

  public void setCodigoDirecion(long codigoDirecion) {
    this.codigoDirecion = codigoDirecion;
  }

  private java.lang.String codigoOperadora;

  public java.lang.String getCodigoOperadora() {
    return this.codigoOperadora;
  }

  public void setCodigoOperadora(java.lang.String codigoOperadora) {
    this.codigoOperadora = codigoOperadora;
  }

  private com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.ConceptoDireccionDTO[] conceptoDireccionDTOs;

  public com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.ConceptoDireccionDTO[] getConceptoDireccionDTOs() {
    return this.conceptoDireccionDTOs;
  }

  public void setConceptoDireccionDTOs(com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.ConceptoDireccionDTO[] conceptoDireccionDTOs) {
    this.conceptoDireccionDTOs = conceptoDireccionDTOs;
  }

  private java.lang.Integer formato;

  public java.lang.Integer getFormato() {
    return this.formato;
  }

  public void setFormato(java.lang.Integer formato) {
    this.formato = formato;
  }

  private java.lang.Integer tipo;

  public java.lang.Integer getTipo() {
    return this.tipo;
  }

  public void setTipo(java.lang.Integer tipo) {
    this.tipo = tipo;
  }

}
