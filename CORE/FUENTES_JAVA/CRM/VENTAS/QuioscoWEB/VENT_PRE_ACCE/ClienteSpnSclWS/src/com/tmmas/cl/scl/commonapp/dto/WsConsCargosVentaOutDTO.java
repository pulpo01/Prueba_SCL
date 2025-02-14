/**
 * Generated from schema type t=WsConsCargosVentaOutDTO@java:com.tmmas.cl.scl.commonapp.dto
 */
package com.tmmas.cl.scl.commonapp.dto;

public class WsConsCargosVentaOutDTO implements java.io.Serializable {

  private com.tmmas.scl.framework.customerdomain.datatransferobject.ObtencionCargosDTO cargos;

  public com.tmmas.scl.framework.customerdomain.datatransferobject.ObtencionCargosDTO getCargos() {
    return this.cargos;
  }

  public void setCargos(com.tmmas.scl.framework.customerdomain.datatransferobject.ObtencionCargosDTO cargos) {
    this.cargos = cargos;
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
