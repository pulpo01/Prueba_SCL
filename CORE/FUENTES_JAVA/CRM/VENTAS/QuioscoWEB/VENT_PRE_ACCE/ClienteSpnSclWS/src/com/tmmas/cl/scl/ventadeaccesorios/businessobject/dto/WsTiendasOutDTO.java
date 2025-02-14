/**
 * Generated from schema type t=WsTiendasOutDTO@java:com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto
 */
package com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto;

public class WsTiendasOutDTO implements java.io.Serializable {

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

  private com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.TiendaDTO[] tiendaDTOs;

  public com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.TiendaDTO[] getTiendaDTOs() {
    return this.tiendaDTOs;
  }

  public void setTiendaDTOs(com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.TiendaDTO[] tiendaDTOs) {
    this.tiendaDTOs = tiendaDTOs;
  }

}
