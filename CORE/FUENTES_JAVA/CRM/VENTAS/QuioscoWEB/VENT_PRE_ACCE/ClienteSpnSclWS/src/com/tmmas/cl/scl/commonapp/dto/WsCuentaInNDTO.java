/**
 * Generated from schema type t=WsCuentaInNDTO@java:com.tmmas.cl.scl.commonapp.dto
 */
package com.tmmas.cl.scl.commonapp.dto;

public class WsCuentaInNDTO implements java.io.Serializable {

  private com.tmmas.cl.scl.commonapp.dto.WsClienteInDTO clienteDTO;

  public com.tmmas.cl.scl.commonapp.dto.WsClienteInDTO getClienteDTO() {
    return this.clienteDTO;
  }

  public void setClienteDTO(com.tmmas.cl.scl.commonapp.dto.WsClienteInDTO clienteDTO) {
    this.clienteDTO = clienteDTO;
  }

  private java.lang.String codigoCuenta;

  public java.lang.String getCodigoCuenta() {
    return this.codigoCuenta;
  }

  public void setCodigoCuenta(java.lang.String codigoCuenta) {
    this.codigoCuenta = codigoCuenta;
  }

  private java.lang.String nomUsuarioOra;

  public java.lang.String getNomUsuarioOra() {
    return this.nomUsuarioOra;
  }

  public void setNomUsuarioOra(java.lang.String nomUsuarioOra) {
    this.nomUsuarioOra = nomUsuarioOra;
  }

}
