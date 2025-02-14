/**
 * Generated from schema type t=WsCreaStructuraComercialInDTO@java:com.tmmas.cl.scl.spnsclwscommon.quiosco.dto
 */
package com.tmmas.cl.scl.spnsclwscommon.quiosco.dto;

public class WsCreaStructuraComercialInDTO implements java.io.Serializable {

  private java.lang.String codPlanTarif;

  public java.lang.String getCodPlanTarif() {
    return this.codPlanTarif;
  }
  public void setCodPlanTarif(java.lang.String codPlanTarif) {
    this.codPlanTarif = codPlanTarif;
  }
	
  private java.lang.String codPrestacion;

  public java.lang.String getCodPrestacion() {
    return this.codPrestacion;
  }

  public void setCodPrestacion(java.lang.String codPrestacion) {
    this.codPrestacion = codPrestacion;
  }

  private com.tmmas.cl.scl.spnsclwscommon.quiosco.dto.WsStructuraCuentaInDTO cuenta;

  public com.tmmas.cl.scl.spnsclwscommon.quiosco.dto.WsStructuraCuentaInDTO getCuenta() {
    return this.cuenta;
  }

  public void setCuenta(com.tmmas.cl.scl.spnsclwscommon.quiosco.dto.WsStructuraCuentaInDTO cuenta) {
    this.cuenta = cuenta;
  }

  private com.tmmas.cl.scl.spnsclwscommon.quiosco.dto.WsStructuraPagoDTO pago;

  public com.tmmas.cl.scl.spnsclwscommon.quiosco.dto.WsStructuraPagoDTO getPago() {
    return this.pago;
  }

  public void setPago(com.tmmas.cl.scl.spnsclwscommon.quiosco.dto.WsStructuraPagoDTO pago) {
    this.pago = pago;
  }

  private java.lang.String usuarioAD;

  public java.lang.String getUsuarioAD() {
    return this.usuarioAD;
  }

  public void setUsuarioAD(java.lang.String usuarioAD) {
    this.usuarioAD = usuarioAD;
  }

  private java.lang.String usuarioOracle;

  public java.lang.String getUsuarioOracle() {
    return this.usuarioOracle;
  }

  public void setUsuarioOracle(java.lang.String usuarioOracle) {
    this.usuarioOracle = usuarioOracle;
  }

}
