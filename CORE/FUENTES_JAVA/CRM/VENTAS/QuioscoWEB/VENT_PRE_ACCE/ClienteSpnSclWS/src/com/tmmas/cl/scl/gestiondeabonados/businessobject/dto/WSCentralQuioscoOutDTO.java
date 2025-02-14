/**
 * Generated from schema type t=WSCentralQuioscoOutDTO@java:com.tmmas.cl.scl.gestiondeabonados.businessobject.dto
 */
package com.tmmas.cl.scl.gestiondeabonados.businessobject.dto;

public class WSCentralQuioscoOutDTO implements java.io.Serializable {

  private com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.CentralDTO[] centralDTOs;

  public com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.CentralDTO[] getCentralDTOs() {
    return this.centralDTOs;
  }

  public void setCentralDTOs(com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.CentralDTO[] centralDTOs) {
    this.centralDTOs = centralDTOs;
  }

  private java.lang.String codError;

  public java.lang.String getCodError() {
    return this.codError;
  }

  public void setCodError(java.lang.String codError) {
    this.codError = codError;
  }

  private java.lang.String msgError;

  public java.lang.String getMsgError() {
    return this.msgError;
  }

  public void setMsgError(java.lang.String msgError) {
    this.msgError = msgError;
  }

  private java.lang.String numEvento;

  public java.lang.String getNumEvento() {
    return this.numEvento;
  }

  public void setNumEvento(java.lang.String numEvento) {
    this.numEvento = numEvento;
  }

}
