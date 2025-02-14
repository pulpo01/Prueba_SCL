/**
 * Generated from schema type t=WsFacturacionVentaInDTO@java:com.tmmas.cl.scl.commonapp.dto
 */
package com.tmmas.cl.scl.commonapp.dto;

public class WsFacturacionVentaInDTO implements java.io.Serializable {

  private com.tmmas.cl.scl.commonapp.dto.WsFacturacionLineaDTO[] facturacionLinea;

  public com.tmmas.cl.scl.commonapp.dto.WsFacturacionLineaDTO[] getFacturacionLinea() {
    return this.facturacionLinea;
  }

  public void setFacturacionLinea(com.tmmas.cl.scl.commonapp.dto.WsFacturacionLineaDTO[] facturacionLinea) {
    this.facturacionLinea = facturacionLinea;
  }

  private java.lang.String identificadorTransaccion;

  public java.lang.String getIdentificadorTransaccion() {
    return this.identificadorTransaccion;
  }

  public void setIdentificadorTransaccion(java.lang.String identificadorTransaccion) {
    this.identificadorTransaccion = identificadorTransaccion;
  }

  private java.lang.String nomUsuario;

  public java.lang.String getNomUsuario() {
    return this.nomUsuario;
  }

  public void setNomUsuario(java.lang.String nomUsuario) {
    this.nomUsuario = nomUsuario;
  }

  private java.lang.String numVenta;

  public java.lang.String getNumVenta() {
    return this.numVenta;
  }

  public void setNumVenta(java.lang.String numVenta) {
    this.numVenta = numVenta;
  }

  private java.lang.String obsFactVenta;

  public java.lang.String getObsFactVenta() {
    return this.obsFactVenta;
  }

  public void setObsFactVenta(java.lang.String obsFactVenta) {
    this.obsFactVenta = obsFactVenta;
  }

  private boolean facturaACiclo;

  public boolean getFacturaACiclo() {
    return this.facturaACiclo;
  }

  public void setFacturaACiclo(boolean facturaACiclo) {
    this.facturaACiclo = facturaACiclo;
  }

}
