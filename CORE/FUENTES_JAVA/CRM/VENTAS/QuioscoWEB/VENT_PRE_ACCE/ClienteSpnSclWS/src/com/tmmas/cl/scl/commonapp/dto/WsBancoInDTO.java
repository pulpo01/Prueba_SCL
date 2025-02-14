/**
 * Generated from schema type t=WsBancoInDTO@java:com.tmmas.cl.scl.commonapp.dto
 */
package com.tmmas.cl.scl.commonapp.dto;

public class WsBancoInDTO implements java.io.Serializable {

  private java.lang.String codBanco;

  public java.lang.String getCodBanco() {
    return this.codBanco;
  }

  public void setCodBanco(java.lang.String codBanco) {
    this.codBanco = codBanco;
  }

  private java.lang.String indicadorTipcuenta;

  public java.lang.String getIndicadorTipcuenta() {
    return this.indicadorTipcuenta;
  }

  public void setIndicadorTipcuenta(java.lang.String indicadorTipcuenta) {
    this.indicadorTipcuenta = indicadorTipcuenta;
  }

  private java.lang.String numeroCtacorr;

  public java.lang.String getNumeroCtacorr() {
    return this.numeroCtacorr;
  }

  public void setNumeroCtacorr(java.lang.String numeroCtacorr) {
    this.numeroCtacorr = numeroCtacorr;
  }

  private com.tmmas.cl.scl.commonapp.dto.WsSucursalBancoInDTO sucursal;

  public com.tmmas.cl.scl.commonapp.dto.WsSucursalBancoInDTO getSucursal() {
    return this.sucursal;
  }

  public void setSucursal(com.tmmas.cl.scl.commonapp.dto.WsSucursalBancoInDTO sucursal) {
    this.sucursal = sucursal;
  }

  private com.tmmas.cl.scl.commonapp.dto.WsTarjetaCreditoInDTO tarjeta;

  public com.tmmas.cl.scl.commonapp.dto.WsTarjetaCreditoInDTO getTarjeta() {
    return this.tarjeta;
  }

  public void setTarjeta(com.tmmas.cl.scl.commonapp.dto.WsTarjetaCreditoInDTO tarjeta) {
    this.tarjeta = tarjeta;
  }

}
