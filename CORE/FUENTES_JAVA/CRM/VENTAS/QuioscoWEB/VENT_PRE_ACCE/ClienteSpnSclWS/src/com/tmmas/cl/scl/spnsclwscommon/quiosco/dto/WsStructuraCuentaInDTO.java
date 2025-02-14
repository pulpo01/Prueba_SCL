/**
 * Generated from schema type t=WsStructuraCuentaInDTO@java:com.tmmas.cl.scl.spnsclwscommon.quiosco.dto
 */
package com.tmmas.cl.scl.spnsclwscommon.quiosco.dto;

public class WsStructuraCuentaInDTO implements java.io.Serializable {

  private com.tmmas.cl.scl.spnsclwscommon.quiosco.dto.WsStructuraClienteDTO cliente;

  public com.tmmas.cl.scl.spnsclwscommon.quiosco.dto.WsStructuraClienteDTO getCliente() {
    return this.cliente;
  }

  public void setCliente(com.tmmas.cl.scl.spnsclwscommon.quiosco.dto.WsStructuraClienteDTO cliente) {
    this.cliente = cliente;
  }

  private java.lang.String codigoCuenta;

  public java.lang.String getCodigoCuenta() {
    return this.codigoCuenta;
  }

  public void setCodigoCuenta(java.lang.String codigoCuenta) {
    this.codigoCuenta = codigoCuenta;
  }

}
