/**
 * Generated from schema type t=WsListBancoOutDTO@java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto
 */
package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

public class WsListBancoOutDTO extends com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.RetornoDTO {

  private java.lang.String resultadoTransaccion;

  public java.lang.String getResultadoTransaccion() {
    return this.resultadoTransaccion;
  }

  public void setResultadoTransaccion(java.lang.String resultadoTransaccion) {
    this.resultadoTransaccion = resultadoTransaccion;
  }

  private com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsBancoOutDTO[] wsBancoArrOutDTO;

  public com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsBancoOutDTO[] getWsBancoArrOutDTO() {
    return this.wsBancoArrOutDTO;
  }

  public void setWsBancoArrOutDTO(com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsBancoOutDTO[] wsBancoArrOutDTO) {
    this.wsBancoArrOutDTO = wsBancoArrOutDTO;
  }

}
