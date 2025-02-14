/**
 * Generated from schema type t=CargosDTO@java:com.tmmas.scl.framework.customerDomain.dataTransferObject
 */
package com.tmmas.scl.framework.customerdomain.datatransferobject;

public class CargosDTO implements java.io.Serializable {

  private com.tmmas.scl.framework.customerdomain.datatransferobject.AtributosCargoDTO atributo;

  public com.tmmas.scl.framework.customerdomain.datatransferobject.AtributosCargoDTO getAtributo() {
    return this.atributo;
  }

  public void setAtributo(com.tmmas.scl.framework.customerdomain.datatransferobject.AtributosCargoDTO atributo) {
    this.atributo = atributo;
  }

  private int cantidad;

  public int getCantidad() {
    return this.cantidad;
  }

  public void setCantidad(int cantidad) {
    this.cantidad = cantidad;
  }

  private com.tmmas.scl.framework.customerdomain.datatransferobject.DescuentoDTO[] descuento;

  public com.tmmas.scl.framework.customerdomain.datatransferobject.DescuentoDTO[] getDescuento() {
    return this.descuento;
  }

  public void setDescuento(com.tmmas.scl.framework.customerdomain.datatransferobject.DescuentoDTO[] descuento) {
    this.descuento = descuento;
  }

  private java.lang.String idProducto;

  public java.lang.String getIdProducto() {
    return this.idProducto;
  }

  public void setIdProducto(java.lang.String idProducto) {
    this.idProducto = idProducto;
  }

  private com.tmmas.scl.framework.customerdomain.datatransferobject.PrecioDTO precio;

  public com.tmmas.scl.framework.customerdomain.datatransferobject.PrecioDTO getPrecio() {
    return this.precio;
  }

  public void setPrecio(com.tmmas.scl.framework.customerdomain.datatransferobject.PrecioDTO precio) {
    this.precio = precio;
  }

}
