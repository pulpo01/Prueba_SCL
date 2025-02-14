/**
 * Generated from schema type t=WsActivacionLineaDTO@java:com.tmmas.cl.scl.commonapp.dto
 */
package com.tmmas.cl.scl.commonapp.dto;

public class WsActivacionLineaDTO implements java.io.Serializable {

  private com.tmmas.cl.scl.commonapp.dto.WsAntecedentesVentaInDTO antecedentesVenta;

  public com.tmmas.cl.scl.commonapp.dto.WsAntecedentesVentaInDTO getAntecedentesVenta() {
    return this.antecedentesVenta;
  }

  public void setAntecedentesVenta(com.tmmas.cl.scl.commonapp.dto.WsAntecedentesVentaInDTO antecedentesVenta) {
    this.antecedentesVenta = antecedentesVenta;
  }

  private com.tmmas.cl.scl.commonapp.dto.WsLineaInDTO[] lineas;

  public com.tmmas.cl.scl.commonapp.dto.WsLineaInDTO[] getLineas() {
    return this.lineas;
  }

  public void setLineas(com.tmmas.cl.scl.commonapp.dto.WsLineaInDTO[] lineas) {
    this.lineas = lineas;
  }

}
