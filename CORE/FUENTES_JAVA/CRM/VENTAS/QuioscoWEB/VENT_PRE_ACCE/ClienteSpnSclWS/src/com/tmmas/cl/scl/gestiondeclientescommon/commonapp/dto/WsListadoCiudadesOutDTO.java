/**
 * Generated from schema type t=WsListadoCiudadesOutDTO@java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto
 */
package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

public class WsListadoCiudadesOutDTO extends com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.RetornoDTO {

  private com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.CiudadDTO[] ciudadDTOs;

  public com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.CiudadDTO[] getCiudadDTOs() {
    return this.ciudadDTOs;
  }

  public void setCiudadDTOs(com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.CiudadDTO[] ciudadDTOs) {
    this.ciudadDTOs = ciudadDTOs;
  }

}
