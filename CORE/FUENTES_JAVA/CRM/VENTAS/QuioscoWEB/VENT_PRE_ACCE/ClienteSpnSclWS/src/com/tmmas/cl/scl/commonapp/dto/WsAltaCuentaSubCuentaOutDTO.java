/**
 * Generated from schema type t=WsAltaCuentaSubCuentaOutDTO@java:com.tmmas.cl.scl.commonapp.dto
 */
package com.tmmas.cl.scl.commonapp.dto;

public class WsAltaCuentaSubCuentaOutDTO implements java.io.Serializable {

  private java.lang.String codigoCuenta;

  public java.lang.String getCodigoCuenta() {
    return this.codigoCuenta;
  }

  public void setCodigoCuenta(java.lang.String codigoCuenta) {
    this.codigoCuenta = codigoCuenta;
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
