/**
 * Generated from schema type t=WSSolicitudBajaAbonadoOutDTO@java:com.tmmas.cl.scl.gestiondeabonados.businessobject.dto
 */
package com.tmmas.cl.scl.gestiondeabonados.businessobject.dto;

public class WSSolicitudBajaAbonadoOutDTO implements java.io.Serializable {

  private com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.RetornoDTO[] errores;

  public com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.RetornoDTO[] getErrores() {
    return this.errores;
  }

  public void setErrores(com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.RetornoDTO[] errores) {
    this.errores = errores;
  }

  private java.lang.String numOOSS;

  public java.lang.String getNumOOSS() {
    return this.numOOSS;
  }

  public void setNumOOSS(java.lang.String numOOSS) {
    this.numOOSS = numOOSS;
  }

  private java.lang.String resultadoTransaccion;

  public java.lang.String getResultadoTransaccion() {
    return this.resultadoTransaccion;
  }

  public void setResultadoTransaccion(java.lang.String resultadoTransaccion) {
    this.resultadoTransaccion = resultadoTransaccion;
  }

}
