/**
 * Generated from schema type t=WsStructuraActivacionLineaDTO@java:com.tmmas.cl.scl.spnsclwscommon.quiosco.dto
 */
package com.tmmas.cl.scl.spnsclwscommon.quiosco.dto;

public class WsStructuraActivacionLineaDTO implements java.io.Serializable {

  private com.tmmas.cl.scl.spnsclwscommon.quiosco.dto.WsStructuraAntecedentesVentaDTO antecedentesVenta;

  public com.tmmas.cl.scl.spnsclwscommon.quiosco.dto.WsStructuraAntecedentesVentaDTO getAntecedentesVenta() {
    return this.antecedentesVenta;
  }

  public void setAntecedentesVenta(com.tmmas.cl.scl.spnsclwscommon.quiosco.dto.WsStructuraAntecedentesVentaDTO antecedentesVenta) {
    this.antecedentesVenta = antecedentesVenta;
  }

  private com.tmmas.cl.scl.spnsclwscommon.quiosco.dto.WsStructuraLineaDTO[] lineas;

  public com.tmmas.cl.scl.spnsclwscommon.quiosco.dto.WsStructuraLineaDTO[] getLineas() {
    return this.lineas;
  }

  public void setLineas(com.tmmas.cl.scl.spnsclwscommon.quiosco.dto.WsStructuraLineaDTO[] lineas) {
    this.lineas = lineas;
  }

}
