/**
 * Generated from schema type t=WsDireccionesOutDTO@java:com.tmmas.cl.scl.commonapp.dto
 */
package com.tmmas.cl.scl.commonapp.dto;

public class WsDireccionesOutDTO implements java.io.Serializable {

  private java.lang.String[] codigosDirecciones;

  public java.lang.String[] getCodigosDirecciones() {
    return this.codigosDirecciones;
  }

  public void setCodigosDirecciones(java.lang.String[] codigosDirecciones) {
    this.codigosDirecciones = codigosDirecciones;
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
