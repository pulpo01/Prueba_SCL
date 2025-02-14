/**
 * Generated from schema type t=WsDireccionOutDTO@java:com.tmmas.cl.scl.commonapp.dto
 */
package com.tmmas.cl.scl.commonapp.dto;

public class WsDireccionOutDTO implements java.io.Serializable {

  private java.lang.String codigoDireccion;

  public java.lang.String getCodigoDireccion() {
    return this.codigoDireccion;
  }

  public void setCodigoDireccion(java.lang.String codigoDireccion) {
    this.codigoDireccion = codigoDireccion;
  }

  private com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.RetornoDTO[] errores;

  public com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.RetornoDTO[] getErrores() {
    return this.errores;
  }

  public void setErrores(com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.RetornoDTO[] errores) {
    this.errores = errores;
  }

  private java.lang.String resultadoTransaccion;

  public java.lang.String getResultadoTransaccion() {
    return this.resultadoTransaccion;
  }

  public void setResultadoTransaccion(java.lang.String resultadoTransaccion) {
    this.resultadoTransaccion = resultadoTransaccion;
  }

}
