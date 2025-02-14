/**
 * Generated from schema type t=WsStructuraComercialOutDTO@java:com.tmmas.cl.scl.spnsclwscommon.quiosco.dto
 */
package com.tmmas.cl.scl.spnsclwscommon.quiosco.dto;

public class WsStructuraComercialOutDTO implements java.io.Serializable {

  private java.lang.String codigoCliente;

  public java.lang.String getCodigoCliente() {
    return this.codigoCliente;
  }

  public void setCodigoCliente(java.lang.String codigoCliente) {
    this.codigoCliente = codigoCliente;
  }

  private com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.RetornoDTO[] errores;

  public com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.RetornoDTO[] getErrores() {
    return this.errores;
  }

  public void setErrores(com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.RetornoDTO[] errores) {
    this.errores = errores;
  }

  private com.tmmas.cl.scl.commonapp.dto.WsLineaOutDTO[] lineaOut;

  public com.tmmas.cl.scl.commonapp.dto.WsLineaOutDTO[] getLineaOut() {
    return this.lineaOut;
  }

  public void setLineaOut(com.tmmas.cl.scl.commonapp.dto.WsLineaOutDTO[] lineaOut) {
    this.lineaOut = lineaOut;
  }

  private java.lang.String numVenta;

  public java.lang.String getNumVenta() {
    return this.numVenta;
  }

  public void setNumVenta(java.lang.String numVenta) {
    this.numVenta = numVenta;
  }

  private byte[] pdfAsBytes;

  public byte[] getPdfAsBytes() {
    return this.pdfAsBytes;
  }

  public void setPdfAsBytes(byte[] pdfAsBytes) {
    this.pdfAsBytes = pdfAsBytes;
  }

  private java.lang.String procesoFacturacion;

  public java.lang.String getProcesoFacturacion() {
    return this.procesoFacturacion;
  }

  public void setProcesoFacturacion(java.lang.String procesoFacturacion) {
    this.procesoFacturacion = procesoFacturacion;
  }

  private java.lang.String resultadoTransaccion;

  public java.lang.String getResultadoTransaccion() {
    return this.resultadoTransaccion;
  }

  public void setResultadoTransaccion(java.lang.String resultadoTransaccion) {
    this.resultadoTransaccion = resultadoTransaccion;
  }

}
