/**
 * Generated from schema type t=WsListadoRegionesOutDTO@java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto
 */
package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

public class WsListadoRegionesOutDTO extends com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.RetornoDTO {

  private com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.RegionDTO[] regionDTOs;

  public com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.RegionDTO[] getRegionDTOs() {
    return this.regionDTOs;
  }

  public void setRegionDTOs(com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.RegionDTO[] regionDTOs) {
    this.regionDTOs = regionDTOs;
  }

}
