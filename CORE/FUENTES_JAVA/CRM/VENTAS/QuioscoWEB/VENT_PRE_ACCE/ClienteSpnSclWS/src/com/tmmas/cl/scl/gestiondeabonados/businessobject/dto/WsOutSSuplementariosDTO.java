/**
 * Generated from schema type t=WsOutSSuplementariosDTO@java:com.tmmas.cl.scl.gestiondeabonados.businessobject.dto
 */
package com.tmmas.cl.scl.gestiondeabonados.businessobject.dto;

public class WsOutSSuplementariosDTO extends com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.RetornoDTO {

  private java.lang.String resultadoTransaccion;

  public java.lang.String getResultadoTransaccion() {
    return this.resultadoTransaccion;
  }

  public void setResultadoTransaccion(java.lang.String resultadoTransaccion) {
    this.resultadoTransaccion = resultadoTransaccion;
  }

  private com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.SSuplementariosDTO[] serviciosSuplementarios;

  public com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.SSuplementariosDTO[] getServiciosSuplementarios() {
    return this.serviciosSuplementarios;
  }

  public void setServiciosSuplementarios(com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.SSuplementariosDTO[] serviciosSuplementarios) {
    this.serviciosSuplementarios = serviciosSuplementarios;
  }

}
