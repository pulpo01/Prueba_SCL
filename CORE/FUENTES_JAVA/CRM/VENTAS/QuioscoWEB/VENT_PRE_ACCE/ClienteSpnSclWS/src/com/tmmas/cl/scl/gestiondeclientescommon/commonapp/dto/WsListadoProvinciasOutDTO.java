/**
 * Generated from schema type t=WsListadoProvinciasOutDTO@java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto
 */
package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

public class WsListadoProvinciasOutDTO extends com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.RetornoDTO {

  private com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.ProvinciaDTO[] provinciaDTOs;

  public com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.ProvinciaDTO[] getProvinciaDTOs() {
    return this.provinciaDTOs;
  }

  public void setProvinciaDTOs(com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.ProvinciaDTO[] provinciaDTOs) {
    this.provinciaDTOs = provinciaDTOs;
  }

}
