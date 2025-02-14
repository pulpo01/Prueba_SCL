/**
 * Generated from schema type t=WsAltaClienteOutDTO@java:com.tmmas.cl.scl.commonapp.dto
 */
package com.tmmas.cl.scl.commonapp.dto;

public class WsAltaClienteOutDTO implements java.io.Serializable {

  private java.lang.String codigoCliente;

  public java.lang.String getCodigoCliente() {
    return this.codigoCliente;
  }

  public void setCodigoCliente(java.lang.String codigoCliente) {
    this.codigoCliente = codigoCliente;
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
