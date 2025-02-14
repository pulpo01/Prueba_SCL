/**
 * Generated from schema type t=WsCunetaAltaDeLineaOutDTO@java:com.tmmas.cl.scl.commonapp.dto
 */
package com.tmmas.cl.scl.commonapp.dto;

public class WsCunetaAltaDeLineaOutDTO implements java.io.Serializable {

  private com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.RetornoLineaDTO[] errores;

  public com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.RetornoLineaDTO[] getErrores() {
    return this.errores;
  }

  public void setErrores(com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.RetornoLineaDTO[] errores) {
    this.errores = errores;
  }

  private com.tmmas.cl.scl.commonapp.dto.WsLineaOutDTO[] lineaOut;

  public com.tmmas.cl.scl.commonapp.dto.WsLineaOutDTO[] getLineaOut() {
    return this.lineaOut;
  }

  public void setLineaOut(com.tmmas.cl.scl.commonapp.dto.WsLineaOutDTO[] lineaOut) {
    this.lineaOut = lineaOut;
  }

  private java.lang.String numVenta;

  public java.lang.String getNumVenta() {
    return this.numVenta;
  }

  public void setNumVenta(java.lang.String numVenta) {
    this.numVenta = numVenta;
  }

  private java.lang.String resultadoTransaccion;

  public java.lang.String getResultadoTransaccion() {
    return this.resultadoTransaccion;
  }

  public void setResultadoTransaccion(java.lang.String resultadoTransaccion) {
    this.resultadoTransaccion = resultadoTransaccion;
  }

}
