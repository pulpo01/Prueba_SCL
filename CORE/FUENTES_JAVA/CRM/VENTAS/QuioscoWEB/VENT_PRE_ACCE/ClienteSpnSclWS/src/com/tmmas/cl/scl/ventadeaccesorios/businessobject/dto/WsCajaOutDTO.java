/**
 * Generated from schema type t=WsCajaOutDTO@java:com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto
 */
package com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto;

public class WsCajaOutDTO implements java.io.Serializable {

  private com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.CajaDTO[] cajaDTOs;

  public com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.CajaDTO[] getCajaDTOs() {
    return this.cajaDTOs;
  }

  public void setCajaDTOs(com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.CajaDTO[] cajaDTOs) {
    this.cajaDTOs = cajaDTOs;
  }

  private int codError;

  public int getCodError() {
    return this.codError;
  }

  public void setCodError(int codError) {
    this.codError = codError;
  }

  private java.lang.String msgError;

  public java.lang.String getMsgError() {
    return this.msgError;
  }

  public void setMsgError(java.lang.String msgError) {
    this.msgError = msgError;
  }

  private int numEvento;

  public int getNumEvento() {
    return this.numEvento;
  }

  public void setNumEvento(int numEvento) {
    this.numEvento = numEvento;
  }

}
